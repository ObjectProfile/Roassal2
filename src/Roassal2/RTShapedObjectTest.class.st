Class {
	#name : #RTShapedObjectTest,
	#superclass : #RTTest,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTShapedObjectTest >> testAddingInteraction [

	| el |
	el := RTBox element.
	el @ RTHighlightable.
	
	RTView new add: el; createAndFillCanvas.

	self assert: el trachelShape color = RTBox new color.
	el announce: TRMouseEnter.
	self assert: el trachelShape color = RTHighlightable highlightedColor.
]

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
