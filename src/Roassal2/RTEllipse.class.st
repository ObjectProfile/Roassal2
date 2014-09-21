"
A RTEllipse is an ellipse. e.g., RTEllipse new width: 10; height: 20
"
Class {
	#name : #RTEllipse,
	#superclass : #RTAbstractElementShape,
	#category : #'Roassal2-Core'
}

{ #category : #visitor }
RTEllipse >> accept: aVisitor [
	aVisitor visitEllipse: self
]

{ #category : #initialization }
RTEllipse >> initialize [
	super initialize.
	color := self defaultColor
]

{ #category : #hooks }
RTEllipse >> trachelShapeClass [
	^ TREllipseShape

]

{ #category : #rendering }
RTEllipse >> updateFor: anElement trachelShape: trachelShape [
	| ex rec |
	trachelShape isNil ifTrue: [ ^ self ].
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	
	trachelShape fromRectangle: rec color: (self colorFor: anElement).
	trachelShape strokePaint: (self borderColorFor: anElement).
	^ trachelShape
	
]
