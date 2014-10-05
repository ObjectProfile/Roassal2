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

{ #category : #'fixed elements' }
RTViewTest >> testAdding [

	| e1 e2 |
	e1 := RTBox element.
	e2 := RTBox element.
	
	e1 setAsFixed.
	view add: e1.
	view add: e2.
	
	self assert: view canvas numberOfFixedShapes = 1.
	self assert: view canvas numberOfShapes = 1.
]

{ #category : #tests }
RTViewTest >> testAddingAnimation [
	| c |
	c := RTView new canvas.
	c addAnimation: (RTLinearMove to: 50 @ 50 during: 2 on: RTBox element).
	self assert: c hasAnimation.
	self assert: c numberOfAnimations = 1
]

{ #category : #edges }
RTViewTest >> testAddingEdgeSetsTheElementInTrachelShape [
	| el1 el2 edge |
	el1 := RTBox element.
	el2 := RTBox element.
	edge := RTLine edgeFrom: el1 to: el2.
	view add: el1; add: el2.
	view add: edge.	
	self assert: edge trachelShape element equals: edge
]

{ #category : #edges }
RTViewTest >> testAddingEdges [
	| el1 el2 edge |
	el1 := RTBox element.
	el2 := RTBox element.
	edge := RTLine edgeFrom: el1 to: el2.
	view add: el1; add: el2.
	self assert: view numberOfElements = 2.

	self assert: view numberOfEdges = 0.
	view add: edge.
	self assert: view numberOfEdges = 1.	
]

{ #category : #camera }
RTViewTest >> testCameraProjection [
	| v camera |

	v := RTView new.
	camera := v canvas camera.

	self assert: ((camera fromPixelToSpace: (camera fromSpaceToPixel: (10@10))) closeTo: (10.0 @ 10.0))
]

{ #category : #tests }
RTViewTest >> testCleaningView [

	| v e |
	v := RTView new.
	e := (RTBox new size: 80) elementOn: 'Hello World'.
	v add: e.
	e @ RTLabelled.

	v cleanAll.
	self assert: v numberOfElements equals: 0.
	self assert: v canvas numberOfFixedShapes equals: 0.
	self assert: v canvas numberOfShapes equals: 0.
	
]

{ #category : #'fixed elements' }
RTViewTest >> testDefault [

	self deny: RTElement new isFixed.
	self assert: (RTElement new setAsFixed; isFixed).
	self deny: (RTElement new setAsNotFixed; isFixed).
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
	self assert: RTView new setUpCanvas numberOfShapes = 0

]

{ #category : #tests }
RTViewTest >> testFillingCanvas [

	| canvas |
	view := RTView new.
	view add: RTBox element.
	canvas := view setUpCanvas.
	
	self assert: canvas class == TRCanvas.
	self assert: canvas numberOfShapes = 1.
]

{ #category : #menu }
RTViewTest >> testMenu [

	view := RTView new.
	view add: (RTEllipse new size: 50) element.
	view addMenu: 'foo' callback: [  ].
	self assert: view canvas numberOfShapes = 1.
	self assert: view canvas numberOfFixedShapes = 1.
]
