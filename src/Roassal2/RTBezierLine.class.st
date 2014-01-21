Class {
	#name : #RTBezierLine,
	#superclass : #RTAbstractLine,
	#instVars : [
		'controllingElements',
		'follow'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTBezierLine >> controllingElements [
	^ controllingElements
]

{ #category : #'as yet unclassified' }
RTBezierLine >> controllingElements: listofElements [
	controllingElements := listofElements
]

{ #category : #'as yet unclassified' }
RTBezierLine >> follow: aBlockOrASymbol [

	follow := aBlockOrASymbol
]

{ #category : #'as yet unclassified' }
RTBezierLine >> getControllingElementsFromFollowFor: anEdge [
	^ self getControllingElementsFromFollowFor: anEdge using: follow
]

{ #category : #'as yet unclassified' }
RTBezierLine >> getControllingElementsFromFollowFor: anEdge using: followBlock [
	| l1 l2 |
	l1 := self getFollowersOf: anEdge from using: followBlock.
	l2 := self getFollowersOf: anEdge to using: followBlock.
	l2 ifEmpty: [ ^ l1 ].
	l1 ifEmpty: [ ^ l2 ].
	^ l1 , l2 reversed allButFirst
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
RTBezierLine >> initialize [
	super initialize.
	controllingElements := #()
]

{ #category : #'as yet unclassified' }
RTBezierLine >> setControllingElementsFromFollowFor: anEdge [
	controllingElements := self getControllingElementsFromFollowFor: anEdge
]

{ #category : #'as yet unclassified' }
RTBezierLine >> trachelShape [
	|  shape aPoint anotherPoint aColor |
	shape := TRBezierShape new.
	shape from: aPoint to: anotherPoint color: aColor.
	^ shape
]

{ #category : #'as yet unclassified' }
RTBezierLine >> trachelShapeFor: anEdge [
	| shape |
	shape := TRBezierShape new.
	shape points: (self getListOfPointsForTrachel: anEdge).
	shape strokePaint: (self colorFor: anEdge).
	controllingElements do: [ :e | e addConnectedEdge: anEdge ].
	^ shape
]

{ #category : #'as yet unclassified' }
RTBezierLine >> updateFor: edge trachelShape: trachelShape [
	trachelShape resetPath. 
	trachelShape points: (self getListOfPointsForTrachel: edge).

]
