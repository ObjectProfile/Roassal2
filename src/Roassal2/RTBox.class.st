Class {
	#name : #RTBox,
	#superclass : #RTAbstractElementShape,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTBox >> trachelShapeFor: anElement [
	| shape rec ex |
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.

	shape := TRBoxShape new.
	shape fromRectangle: rec color: (self colorFor: anElement).
	shape strokePaint: (self borderColorFor: anElement).
	^ shape
]

{ #category : #rendering }
RTBox >> updateFor: anElement trachelShape: trachelShape [
	| rec ex |
	trachelShape isNil ifTrue: [ ^ self ].
	 
	ex := trachelShape width @ trachelShape height.
	rec := (anElement position - (ex / 2)) extent: ex.
	trachelShape fromRectangle: rec.
	trachelShape strokePaint: (self borderColorFor: anElement).
]
