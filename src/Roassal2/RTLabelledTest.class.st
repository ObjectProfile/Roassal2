Class {
	#name : #RTLabelledTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core-Tests'
}

{ #category : #tests }
RTLabelledTest >> testConstruction [

	RTLabeled above; below; center
]

{ #category : #tests }
RTLabelledTest >> testDefault [

	| v el |
	v := RTView new.
	el := (RTBox new size: 30) elementOn: 'hello world'.
	v add: el.
	
	el @ RTLabeled.
	self assert: v numberOfElements = 1.
	self assert: v canvas numberOfShapes = 2.
	
	self assert: v canvas shapes first class == TRLabelShape.
	self assert: v canvas shapes first position x = 0.
	self assert: v canvas shapes first position y < 10
]

{ #category : #tests }
RTLabelledTest >> testDefaultFromNumber [

	| v el |
	v := RTView new.
	el := (RTBox new size: 30) elementOn: 5.
	v add: el.
	
	el @ RTLabeled.
	self assert: v numberOfElements = 1.
	self assert: v canvas numberOfShapes = 2.
	
	self assert: v canvas shapes first class == TRLabelShape.
	self assert: v canvas shapes first position x = 0.
	self assert: v canvas shapes first position y < 10.
	self assert: v canvas shapes first text = '5'.
]

{ #category : #tests }
RTLabelledTest >> testDefaultWithNoLabel [

	| v el |
	v := RTView new.
	el := (RTBox new size: 30) element.
	v add: el.
	
	el @ RTLabeled.
	self assert: v numberOfElements = 1.
	
	"No label since there is no object behind the el"
	self assert: v canvas numberOfShapes = 1.
	
]

{ #category : #tests }
RTLabelledTest >> testRemovingLabelledElement [

	| v el |
	v := RTView new.
	el := (RTBox new size: 30) elementOn: 'hello world'.
	v add: el.
	
	el @ RTLabeled.
	self assert: v numberOfElements = 1.
	self assert: v canvas numberOfShapes = 2.
	
	el remove.
	self assert: v numberOfElements equals: 0.
	self assert: v canvas numberOfShapes equals: 0.

]
