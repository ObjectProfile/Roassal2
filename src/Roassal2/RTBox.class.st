Class {
	#name : #RTBox,
	#superclass : #RTAbstractElementShape,
	#instVars : [
		'borderColor'
	],
	#category : #Roassal2
}

{ #category : #accessing }
RTBox >> borderColor [
	^ borderColor
]

{ #category : #accessing }
RTBox >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #rendering }
RTBox >> renderOn: trachelCanvas for: anElement [
	| rec ex |
	self halt.
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.
	^ trachelCanvas buildRectangle: rec color: (self colorFor: anElement)
]

{ #category : #'as yet unclassified' }
RTBox >> trachelShapeFor: anElement [
	|  shape rec ex |
	ex := (self widthFor: anElement) @ (self heightFor: anElement).
	rec := (anElement position - (ex / 2)) extent: ex.

	shape := TRBoxShape new.
	shape fromRectangle: rec color: (self colorFor: anElement).
	^ shape
]

{ #category : #rendering }
RTBox >> updateFor: anElement [
	| rec ex |
	anElement trachelShape isNil ifTrue: [ ^ self ].
	 
	ex := anElement trachelShape width @ anElement trachelShape height.
	rec := (anElement position - (ex / 2)) extent: ex.
	anElement trachelShape fromRectangle: rec
]
