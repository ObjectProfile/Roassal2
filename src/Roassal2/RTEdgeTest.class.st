Class {
	#name : #RTEdgeTest,
	#superclass : #RTTest,
	#instVars : [
		'el1',
		'el2',
		'edge'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTEdgeTest >> setUp [
	el1 := RTBox element.
	el2 := RTBox element.
	el1 translateTo: 20 @ 20.
	el2 translateTo: 60 @ 80.
	edge := RTLine edgeFrom: el1 to: el2
]

{ #category : #'as yet unclassified' }
RTEdgeTest >> testBasic [

	RTView new
		add: el1;
		add: el2;
		add: edge;
		createAndFillCanvas.
	self assert: edge trachelShape notNil.
	self assert: edge trachelShape color notNil
]

{ #category : #'as yet unclassified' }
RTEdgeTest >> testIncomingAndOutgoingEdges [

	self assert: (el1 outgoingEdges includes: edge).
	self assert: (el2 incomingEdges includes: edge).
]

{ #category : #'as yet unclassified' }
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
