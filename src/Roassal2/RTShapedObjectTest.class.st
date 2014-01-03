Class {
	#name : #RTShapedObjectTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTShapedObjectTest >> testEmittingEvent [

	| el t |
	t := 0.
	el := RTBox element.
	el on: TRMouseEnter do: [ :evt | t := t + 1 ].
	
	self assert: t = 0.
	el announce: TRMouseEnter.
	self assert: t = 1
	
]
