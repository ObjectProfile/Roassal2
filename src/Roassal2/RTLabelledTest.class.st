Class {
	#name : #RTLabelledTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #tests }
RTLabelledTest >> testDefault [

	| v el |
	v := RTView new.
	el := (RTBox new size: 30) element.
	v add: el.
	
	el @ RTLabelled.
	self assert: v numberOfElements = 1.
	self assert: v canvas numberOfShapes = 2.
	
	self assert: v canvas shapes last class == TRLabelShape.
	self assert: v canvas shapes last position x = 0.
	self assert: v canvas shapes last position y < 10
]
