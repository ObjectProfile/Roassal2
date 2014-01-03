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
RTBox >> updateFor: anElement [
	| rec ex |
	anElement trachelShape isNil ifTrue: [ ^ self ].
	 
	ex := anElement trachelShape width @ anElement trachelShape height.
	rec := (anElement position - (ex / 2)) extent: ex.
	anElement trachelShape fromRectangle: rec.
	anElement trachelShape strokePaint: (self borderColorFor: anElement).
]

{ #category : #rendering }
RTBox >> updateFor: anElement [
	| rec ex |
	anElement trachelShape isNil ifTrue: [ ^ self ].
	 
	ex := anElement trachelShape width @ anElement trachelShape height.
	rec := (anElement position - (ex / 2)) extent: ex.
	anElement trachelShape fromRectangle: rec.
	anElement trachelShape strokePaint: (self borderColorFor: anElement).
]
