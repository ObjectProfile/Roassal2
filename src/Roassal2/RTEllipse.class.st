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
RTEllipse >> trachelShapeFor: anElement [
	|  shape ex rec |
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	
	shape := TREllipseShape new.
	shape from: rec origin to: rec corner color: (self colorFor: anElement).
	shape strokePaint: (self borderColorFor: anElement).
	^ shape
]

{ #category : #rendering }
RTEllipse >> updateFor: anElement [
	| rec ex |
	"This is a bit ugly... We need to find a better way"
	anElement trachelShape isNil ifTrue: [ ^ self ].
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	anElement trachelShape rectangle: rec.
	anElement trachelShape strokePaint: (self borderColorFor: anElement).
]
