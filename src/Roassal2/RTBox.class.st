Class {
	#name : #RTBox,
	#superclass : #RTAbstractElementShape,
	#category : #'Roassal2-Core'
}

{ #category : #visitor }
RTBox >> accept: aVisitor [
	aVisitor visitBox: self
]

{ #category : #hooks }
RTBox >> trachelShapeClass [
	^ TRBoxShape
]

{ #category : #rendering }
RTBox >> updateFor: anElement trachelShape: trachelShape [
	| ex |
	trachelShape isNil ifTrue: [ ^ self ].
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	trachelShape extent: ex.
	trachelShape color: (self colorFor: anElement).
	self haltOnce.
	trachelShape strokePaint: (self borderColorFor: anElement).

]
