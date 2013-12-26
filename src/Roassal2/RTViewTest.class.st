Class {
	#name : #RTViewTest,
	#superclass : #RTTest,
	#instVars : [
		'view'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTViewTest >> setUp [
	super setUp.
	view := RTView new
]

{ #category : #'as yet unclassified' }
RTViewTest >> testAdding [

	view add: RTElement new.
	self assert: view numberOfElements = 1
]

{ #category : #'as yet unclassified' }
RTViewTest >> testDefault [

	self assert: view numberOfElements = 0
]

{ #category : #'as yet unclassified' }
RTViewTest >> testElementFromModel [

	| els |
	els := RTBox elementsOn: (1 to: 3).
	view addAll: els.

	self assert: (view elementFromModel: 1) == els first.
	self assert: (view elementFromModel: 2) == els second.
	self assert: (view elementFromModel: 3) == els third.
]

{ #category : #'as yet unclassified' }
RTViewTest >> testEmptyCanvas [
	self assert: RTView new createAndFillCanvas numberOfShapes = 0

]

{ #category : #'as yet unclassified' }
RTViewTest >> testFillingCanvas [

	| canvas |
	view := RTView new.
	view add: RTBox element.
	canvas := view createAndFillCanvas.
	
	self assert: canvas class == TRCanvas.
	self assert: canvas numberOfShapes = 1.
]
