Class {
	#name : #RTUninterpolate,
	#superclass : #RTObject,
	#instVars : [
		'a',
		'b'
	],
	#category : #'Roassal2-Scaling'
}

{ #category : #'as yet unclassified' }
RTUninterpolate class >> uninterpolate: aNum1 and: aNum2 [
	^ self new uninterpolate: aNum1 and: aNum2.
	
]

{ #category : #interpolating }
RTUninterpolate >> uninterpolate: x [
	self subclassResponsibility.
]

{ #category : #interpolating }
RTUninterpolate >> uninterpolate: aNum1 and: aNum2 [
	a := aNum1 .
	b := aNum2 .
	a isNumber 
		ifFalse: [ 
			^ a := b := Float nan. ].
	b  := b - a.
	b isZero 
		ifTrue: [ b := 1 / aNum2 ].
]
