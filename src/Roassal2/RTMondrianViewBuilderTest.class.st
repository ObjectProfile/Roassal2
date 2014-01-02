Class {
	#name : #RTMondrianViewBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'builder'
	],
	#category : #'Roassal2-Builder-Mondrian'
}

{ #category : #'as yet unclassified' }
RTMondrianViewBuilderTest >> setUp [

	builder := RTMondrianViewBuilder new
]

{ #category : #'as yet unclassified' }
RTMondrianViewBuilderTest >> testBasic [
	
	builder nodes: #(1 2 3 4 5).
	builder edges: #(1 2 3 4 5) from: #yourself to: [ :v | v + 1 ].
	builder treeLayout.
	self assert: builder view numberOfElements = 5.
	self assert: builder view numberOfEdges = 4.
]
