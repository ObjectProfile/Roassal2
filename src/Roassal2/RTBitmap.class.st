Class {
	#name : #RTBitmap,
	#superclass : #RTAbstractElementShape,
	#instVars : [
		'form'
	],
	#category : #'Roassal2-Core'
}

{ #category : #accessing }
RTBitmap >> form [
	^ form
]

{ #category : #accessing }
RTBitmap >> form: anObject [
	form := anObject
]

{ #category : #hooks }
RTBitmap >> trachelShapeClass [
	^ TRBitmapShape

]

{ #category : #hooks }
RTBitmap >> updateFor: anElement trachelShape: trachelShape [
	| ex |
	trachelShape isNil ifTrue: [ ^ self ].
	
	form isNil ifTrue: 
		[ ex := (self widthFor: anElement) @ (self heightFor: anElement).
		  trachelShape extent: ex.
		   ^ self ].
	
	trachelShape form: self form

]
