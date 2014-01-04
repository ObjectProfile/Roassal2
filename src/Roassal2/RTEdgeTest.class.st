Class {
	#name : #RTEdgeTest,
	#superclass : #RTTest,
	#instVars : [
		'el1',
		'el2',
		'edge'
	],
	#category : #'Roassal2-Core'
}

{ #category : #running }
RTEdgeTest >> setUp [
	el1 := RTBox element.
	el2 := RTBox element.
	el1 translateTo: 20 @ 20.
	el2 translateTo: 60 @ 80.
	edge := RTLine edgeFrom: el1 to: el2
]

{ #category : #tests }
RTEdgeTest >> testBasic [

	RTView new
		add: el1;
		add: el2;
		add: edge;
		createAndFillCanvas.
	self assert: edge trachelShape notNil.
	self assert: edge trachelShape color notNil
]

{ #category : #'tests - building' }
RTEdgeTest >> testBuildingFromAssociations [

	| view elements |
	view := RTView new.
	elements := RTBox elementsOn: #(1 2).
	view addAll: elements.
	
	RTEdge buildEdgesFromAssociations: (Array with: 1 -> 2) inView: view.
	
	self assert: view numberOfElements = 2.
	self assert: view numberOfEdges = 1.
	edge := view edges last.
	self assert: edge from == view elements first.
	self assert: edge to == view elements second.
	
	self assert: edge trachelShape class == TRLineShape.
	
	
]

{ #category : #'tests - building' }
RTEdgeTest >> testBuildingFromObjects [

	| view objects elements |
	view := RTView new.
	objects := Array with: RTLine with: RTLine superclass.
	elements := (RTBox new size: 20) elementsOn: objects.
	view addAll: elements.
	RTEdge buildEdgesFromObjects: objects from: #yourself to: #superclass inView: view.
	
	self assert: view numberOfElements = 2. 
	self assert: view numberOfEdges = 1.
	edge := view edges last.
	self assert: edge from == elements first.
	self assert: edge to == elements second.
]

{ #category : #tests }
RTEdgeTest >> testIncomingAndOutgoingEdges [

	self assert: (el1 outgoingEdges includes: edge).
	self assert: (el2 incomingEdges includes: edge).
]

{ #category : #tests }
RTEdgeTest >> testTrachelShape [
	edge := RTLine edgeFrom: RTBox element to: RTBox element.
	self assert: edge trachelShape notNil.
	self assert: edge trachelShape class == TRLineShape.
]

{ #category : #tests }
RTEdgeTest >> testTranslatingNode [
	| old |
	RTView new
		add: el1;
		add: el2;
		add: edge;
		createAndFillCanvas.

	old := edge trachelShape from.
	self assert: edge trachelShape from = el1 position.
	self assert: edge trachelShape to = el2 position.
	
	el1 translateBy: 10 @ 5.
	self assert: edge trachelShape from = (old + (10 @ 5)).
	self assert: edge trachelShape from = el1 position.
	self assert: edge trachelShape to = el2 position.
]
