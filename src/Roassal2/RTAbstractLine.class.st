Class {
	#name : #RTAbstractLine,
	#superclass : #RTShape,
	#instVars : [
		'width',
		'attachPoint'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTAbstractLine class >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #public }
RTAbstractLine class >> edgesFrom: el1 toAll: el2 [
	^ (RTEdge from: el1 toAll: el2) addShape: self
]

{ #category : #visitor }
RTAbstractLine >> accept: aVisitor [
	aVisitor visitLine: self
]

{ #category : #'attach point' }
RTAbstractLine >> attachPoint: aRTAttachPoint [
	attachPoint := aRTAttachPoint.
]

{ #category : #public }
RTAbstractLine >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #public }
RTAbstractLine >> edgesFrom: el1 toAll: el2 [
	^ (RTEdge from: el1 toAll: el2) addShape: self
]

{ #category : #'attach point' }
RTAbstractLine >> endingPointOf: anEdge [
	^ attachPoint endingPointOf: anEdge
]

{ #category : #initialization }
RTAbstractLine >> initialize [
	super initialize.
	attachPoint := RTCenteredAttachPoint new.
	width := 1.
]

{ #category : #'attach point' }
RTAbstractLine >> startingPointOf: anEdge [
	^ attachPoint startingPointOf: anEdge
]

{ #category : #rendering }
RTAbstractLine >> updateFor: edge trachelShape: trachelShape [
	trachelShape from: (attachPoint startingPointOf: edge).
	trachelShape to: (attachPoint endingPointOf: edge).
	trachelShape color: (self colorFor: edge).
	trachelShape width: (self widthFor: edge).
	trachelShape resetPath

]

{ #category : #public }
RTAbstractLine >> width: aBlockOrValue [
	width := aBlockOrValue
]

{ #category : #public }
RTAbstractLine >> widthFor: anElement [
	^ width rtValue: anElement
]

{ #category : #'attach point' }
RTAbstractLine >> withHorizontalAttachPoint [
	| ap |
	ap := RTHorizontalAttachPoint new.
	self attachPoint: ap.
	^ ap
]

{ #category : #'attach point' }
RTAbstractLine >> withShorterDistanceAttachPoint [
	| ap |
	ap := RTShorterDistanceAttachPoint new.
	self attachPoint: ap.
	^ ap.
]

{ #category : #'attach point' }
RTAbstractLine >> withVerticallAttachPoint [
	| ap |
	ap := RTVerticalAttachPoint new.
	self attachPoint: ap.
	^ ap
]
