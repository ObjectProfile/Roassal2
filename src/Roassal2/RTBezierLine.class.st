Class {
	#name : #RTBezierLine,
	#superclass : #RTAbstractLine,
	#instVars : [
		'controllingElements',
		'follow'
	],
	#category : #'Roassal2-Core'
}

{ #category : #accessing }
RTBezierLine >> controllingElements [
	^ controllingElements
]

{ #category : #accessing }
RTBezierLine >> controllingElements: listofElements [
	controllingElements := listofElements
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
	| listOfPoints |
	listOfPoints := OrderedCollection new.
	listOfPoints add: anEdge from position.
	
	follow ifNotNil: 
		[ self setControllingElementsFromFollowFor: anEdge ].

	controllingElements ifNotEmpty: 
		[ listOfPoints addAll: (controllingElements collect: #position) ].
		
	listOfPoints add: anEdge to position.
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
	| shape |
	shape := TRBezierShape new.
	shape width: (self widthFor: anEdge).
	shape points: (self getListOfPointsForTrachel: anEdge).
	shape strokePaint: (self colorFor: anEdge).
	controllingElements do: [ :e | e addConnectedEdge: anEdge ].
	^ shape
]

{ #category : #rendering }
RTBezierLine >> updateFor: edge trachelShape: trachelShape [
	trachelShape resetPath. 
	trachelShape strokePaint: (self colorFor: edge).
	trachelShape width: (self widthFor: edge).
	trachelShape points: (self getListOfPointsForTrachel: edge).

]
