Class {
	#name : #RTUninterpolate,
	#superclass : #RTObject,
	#instVars : [
		'a',
		'b'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTUninterpolate class >> uninterpolate: aNum1 and: aNum2 [
	^ self new uninterpolate: aNum1 and: aNum2.
	
]

{ #category : #'as yet unclassified' }
RTUninterpolate >> uninterpolate: x [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
RTUninterpolate >> uninterpolate: aNum1 and: aNum2 [
	a := aNum1.
	b := aNum2.
	b := b - a.
	b isZero ifTrue: [ b := 1 ].
	b := b / aNum2.
]
