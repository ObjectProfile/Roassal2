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
	"Set one control point, at the center of the elements provided as argument"
	^ self centerOfElements: [ :edge |
		aOneArgBlockOrValues isClosure
			ifTrue:  [ view elementsFromModels: (aOneArgBlockOrValues 
															value: edge from model value: edge to model) ]
			ifFalse: [ view elementsFromModels: aOneArgBlockOrValues ] ]
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
	"Make the bezier follow the path specified as the argument"
	
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
RTBezierLine >> midPointInCenterOfElements: aOneArgBlockOrValues [
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
				intermediaryElement translateTo: (edge from position + center) / 2.
				Array with: intermediaryElement ] ].

	self controllingElements:  b
]

{ #category : #'control points' }
RTBezierLine >> midPointInCenterOfObjects: aOneArgBlockOrValues inView: view [
	"Set one control point, between the starting point and the center of all the objects provided as argument"
	^ self midPointInCenterOfElements: [ :edge |
		aOneArgBlockOrValues isClosure
			ifTrue:  [ view elementsFromModels: (aOneArgBlockOrValues 
															value: edge from model value: edge to model) ]
			ifFalse: [ view elementsFromModels: aOneArgBlockOrValues ] ]
]

{ #category : #'control points' }
RTBezierLine >> setControllingElementsFromFollowFor: anEdge [
	(anEdge hasAttribute: #controllingElements)
		ifTrue: [ controllingElements := anEdge attributeAt: #controllingElements ]
		ifFalse: [ controllingElements := self getControllingElementsFromFollowFor: anEdge.
			anEdge attributeAt: #controllingElements put: controllingElements ] 
	
]

{ #category : #public }
RTBezierLine >> trachelShapeFor: anEdge [
	| trachelShape realControllingElements |
	trachelShape := TRBezierShape new.
	self updateFor: anEdge trachelShape: trachelShape.
"	shape width: (self widthFor: anEdge).
	shape points: (self getListOfPointsForTrachel: anEdge).
	shape strokePaint: (self colorFor: anEdge)."
	realControllingElements := controllingElements rtValue: anEdge. 
	realControllingElements do: [ :e | e addConnectedEdge: anEdge ].
	^ trachelShape
]

{ #category : #rendering }
RTBezierLine >> updateFor: edge trachelShape: trachelShape [
	trachelShape resetPath. 
	trachelShape strokePaint: (self colorFor: edge).
	trachelShape width: (self widthFor: edge).
	trachelShape points: (self getListOfPointsForTrachel: edge).
	trachelShape strokePaint: (self colorFor: edge).

]
