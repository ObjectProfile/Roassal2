Class {
	#name : #RTBezierLine,
	#superclass : #RTAbstractLine,
	#instVars : [
		'controllingElements',
		'follow'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'control points' }
RTBezierLine >> centerOfElements: aOneArgBlockOrValues [
	"Argument can be a OneArgBlock (taking an edge as argument) or direct values"
	| b |
	b := [ :edge |
		| center intermediaryElement elements |
		elements := aOneArgBlockOrValues rtValue: edge.
		(elements isNil or: [ elements isEmpty ]) 
			ifTrue: [ #() ]
			ifFalse: [ 
				center := (RTGroup withAll: elements) center.
				intermediaryElement := RTBox element.
				intermediaryElement translateTo: center.
				Array with: intermediaryElement ] ].

	self controllingElements:  b
]

{ #category : #'control points' }
RTBezierLine >> centerOfObjects: aOneArgBlockOrValues inView: view [
	^ self centerOfElements: [ :edge | view elementsFromModels: (aOneArgBlockOrValues rtValue: edge) ]
]

{ #category : #accessing }
RTBezierLine >> controllingElements [
	"Return a list of elements or a one arg block, evaluated against the edge"
	^ controllingElements
]

{ #category : #accessing }
RTBezierLine >> controllingElements: listOfElementsOrOneArgBlock [
	"Argument can be a OneArgBlock (taking an edge as argument) or direct values"
	"NOTE: controlling elements are retreived when the edge is created, which may not be already added to the view. This means that the argument should not try to access the view from the edge directly"
	controllingElements := listOfElementsOrOneArgBlock
]

{ #category : #accessing }
RTBezierLine >> follow: aBlockOrASymbol [

	follow := aBlockOrASymbol
]

{ #category : #'control points' }
RTBezierLine >> getControllingElementsFromFollowFor: anEdge [
	^ self getControllingElementsFromFollowFor: anEdge using: follow
]

{ #category : #'control points' }
RTBezierLine >> getControllingElementsFromFollowFor: anEdge using: followBlock [
	| l1 l2 |
	l1 := self getFollowersOf: anEdge from using: followBlock.
	l2 := self getFollowersOf: anEdge to using: followBlock.
	l2 ifEmpty: [ ^ l1 ].
	l1 ifEmpty: [ ^ l2 ].
	^ l1 , l2 reversed allButFirst
]

{ #category : #'control points' }
RTBezierLine >> getFollowersOf: aNode using: followBlock [
	| answer view t |
	answer := OrderedCollection new.
	view := aNode view.
	t := view elementFromModel: (followBlock rtValue: aNode model).
	[ t notNil ]
		whileTrue: [ 
			answer add: t.
			t := view elementFromModel: (followBlock rtValue: t model) ].
	^ answer asArray
]

{ #category : #'control points' }
RTBezierLine >> getListOfPointsForTrachel: anEdge [
	| listOfPoints realControllingElements |
	listOfPoints := OrderedCollection new.
	
	"We add the first point of the edge"
	listOfPoints add: (attachPoint startingPointOf: anEdge).
	
	"Set the controlling elements from a follow block, if any"
	follow ifNotNil: 
		[ self setControllingElementsFromFollowFor: anEdge ].
	
	realControllingElements := controllingElements rtValue: anEdge.
	realControllingElements ~= #() ifTrue: 
		[ | cElements |
			cElements := realControllingElements collect: #position.
			cElements isNotEmpty ifTrue: [ 
				(cElements first = anEdge from position and: [ cElements size  > 1 ])
					ifTrue: [ cElements := cElements allButFirst ].
				(cElements last = anEdge to position and: [ cElements size  > 1 ])
					ifTrue: [ cElements := cElements allButLast ] ].
			listOfPoints addAll: cElements
		].
		
	"We add the last point of the edge"
	listOfPoints add: (attachPoint endingPointOf: anEdge).
	^ listOfPoints
]

{ #category : #initialization }
RTBezierLine >> initialize [
	super initialize.
	controllingElements := #()
]

{ #category : #'control points' }
RTBezierLine >> setControllingElementsFromFollowFor: anEdge [
	controllingElements := self getControllingElementsFromFollowFor: anEdge
]

{ #category : #public }
RTBezierLine >> trachelShapeFor: anEdge [
	| shape realControllingElements |
	shape := TRBezierShape new.
	shape width: (self widthFor: anEdge).
	shape points: (self getListOfPointsForTrachel: anEdge).
	shape strokePaint: (self colorFor: anEdge).
	realControllingElements := controllingElements rtValue: anEdge. 
	realControllingElements do: [ :e | e addConnectedEdge: anEdge ].
	^ shape
]

{ #category : #rendering }
RTBezierLine >> updateFor: edge trachelShape: trachelShape [
	trachelShape resetPath. 
	trachelShape strokePaint: (self colorFor: edge).
	trachelShape width: (self widthFor: edge).
	trachelShape points: (self getListOfPointsForTrachel: edge).

]
