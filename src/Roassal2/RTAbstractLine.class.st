Class {
	#name : #RTAbstractLine,
	#superclass : #RTShape,
	#instVars : [
		'width',
		'attachPoint'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTAbstractLine class >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #'attach point' }
RTAbstractLine >> attachPoint: aRTAttachPoint [
	attachPoint := aRTAttachPoint.
]

{ #category : #public }
RTAbstractLine >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #'attach point' }
RTAbstractLine >> endingPointOf: anEdge [
	^ attachPoint endingPointOf: anEdge
]

{ #category : #initialization }
RTAbstractLine >> initialize [
	super initialize.
	attachPoint := RTCenteredAttachPoint new.
]

{ #category : #'attach point' }
RTAbstractLine >> startingPointOf: anEdge [
	^ attachPoint startingPointOf: anEdge
]

{ #category : #rendering }
RTAbstractLine >> updateFor: edge trachelShape: trachelShape [
	trachelShape from: (attachPoint startingPointOf: edge).
	trachelShape to: (attachPoint endingPointOf: edge).
	trachelShape resetPath

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
