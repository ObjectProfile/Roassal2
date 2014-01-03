Class {
	#name : #RTViewTest,
	#superclass : #RTTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal2-Core'
}

{ #category : #running }
RTViewTest >> setUp [
	super setUp.
	view := RTView new
]

{ #category : #running }
RTViewTest >> setUp [
	super setUp.
	view := RTView new
]

{ #category : #tests }
RTViewTest >> testAdding [

	view add: RTElement new.
	self assert: view numberOfElements = 1
]

{ #category : #tests }
RTViewTest >> testAdding [

	view add: RTElement new.
	self assert: view numberOfElements = 1
]

{ #category : #edges }
RTViewTest >> testAddingEdges [
	| el1 el2 edge |
	el1 := RTBox element.
	el2 := RTBox element.
	edge := RTEdge from: el1 to: el2.
	view add: el1; add: el2.
	self assert: view numberOfElements = 2.

	self assert: view numberOfEdges = 0.
	view add: edge.
	self assert: view numberOfEdges = 1.	
]

{ #category : #edges }
RTViewTest >> testAddingEdges [
	| el1 el2 edge |
	el1 := RTBox element.
	el2 := RTBox element.
	edge := RTEdge from: el1 to: el2.
	view add: el1; add: el2.
	self assert: view numberOfElements = 2.

	self assert: view numberOfEdges = 0.
	view add: edge.
	self assert: view numberOfEdges = 1.	
]

{ #category : #tests }
RTViewTest >> testDefault [

	self assert: view numberOfElements = 0
]

{ #category : #tests }
RTViewTest >> testDefault [

	self assert: view numberOfElements = 0
]

{ #category : #tests }
RTViewTest >> testElementFromModel [

	| els |
	els := RTBox elementsOn: (1 to: 3).
	view addAll: els.

	self assert: (view elementFromModel: 1) == els first.
	self assert: (view elementFromModel: 2) == els second.
	self assert: (view elementFromModel: 3) == els third.
]

{ #category : #tests }
RTViewTest >> testElementFromModel [

	| els |
	els := RTBox elementsOn: (1 to: 3).
	view addAll: els.

	self assert: (view elementFromModel: 1) == els first.
	self assert: (view elementFromModel: 2) == els second.
	self assert: (view elementFromModel: 3) == els third.
]

{ #category : #tests }
RTViewTest >> testEmptyCanvas [
	self assert: RTView new createAndFillCanvas numberOfShapes = 0

]

{ #category : #tests }
RTViewTest >> testEmptyCanvas [
	self assert: RTView new createAndFillCanvas numberOfShapes = 0

]

{ #category : #tests }
RTViewTest >> testFillingCanvas [

	| canvas |
	view := RTView new.
	view add: RTBox element.
	canvas := view createAndFillCanvas.
	
	self assert: canvas class == TRCanvas.
	self assert: canvas numberOfShapes = 1.
]

{ #category : #tests }
RTViewTest >> testFillingCanvas [

	| canvas |
	view := RTView new.
	view add: RTBox element.
	canvas := view createAndFillCanvas.
	
	self assert: canvas class == TRCanvas.
	self assert: canvas numberOfShapes = 1.
]

{ #category : #menu }
RTViewTest >> testMenu [

	view := RTView new.
	view add: (RTEllipse new size: 50) element.
	view addMenu: 'foo' callback: [  ].
	self assert: view canvas numberOfShapes = 0.
	self assert: view canvas numberOfFixedShapes = 1.
]

{ #category : #menu }
RTViewTest >> testMenu [

	view := RTView new.
	view add: (RTEllipse new size: 50) element.
	view addMenu: 'foo' callback: [  ].
	self assert: view canvas numberOfShapes = 0.
	self assert: view canvas numberOfFixedShapes = 1.
]
