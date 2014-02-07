Class {
	#name : #RTEllipse,
	#superclass : #RTAbstractElementShape,
	#category : #'Roassal2-Core'
}

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
	
	trachelShape from: rec origin to: rec corner color: (self colorFor: anElement).
	trachelShape strokePaint: (self borderColorFor: anElement).
	^ trachelShape
	
]
