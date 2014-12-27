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

{ #category : #public }
RTAbstractLine >> + anotherShape [
	anotherShape line: self.
	^ RTMultiCompositeShape with: self with: anotherShape instance
]

{ #category : #visitor }
RTAbstractLine >> accept: aVisitor [
	aVisitor visitLine: self
]

{ #category : #'attach point' }
RTAbstractLine >> attachPoint [
	"Return the attach point of the line"
	^ attachPoint
]

{ #category : #'attach point' }
RTAbstractLine >> attachPoint: aRTAttachPoint [
	attachPoint := aRTAttachPoint.
]

{ #category : #public }
RTAbstractLine >> copyWithSimpleArrow [
	"Return a new line, the one with arrow"
	| arrow |
	arrow := RTSimpleArrowHead new 
				color: Color red; 
				attachPoint: RTVerticalAttachPoint instance.
	arrow size: 15; baseSize: 10. 
	^ self + arrow
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
	trachelShape from: (attachPoint startingPointOf: edge) to: (attachPoint endingPointOf: edge).
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
RTAbstractLine >> withCenteredAttachPoint [
	| ap |
	ap := RTCenteredAttachPoint new.
	self attachPoint: ap.
	^ ap
]

{ #category : #'attach point' }
RTAbstractLine >> withHorizontalAttachPoint [
	| ap |
	ap := RTHorizontalAttachPoint new.
	self attachPoint: ap.
	^ ap
]

{ #category : #public }
RTAbstractLine >> withOffsetIfMultiple [
	self attachPoint: RTShorterDistanceWithOffsetAttachPoint new
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
