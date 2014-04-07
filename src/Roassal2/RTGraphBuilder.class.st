Class {
	#name : #RTGraphBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'node',
		'edge',
		'layout',
		'global',
		'interaction'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGraphBuilder >> add: anObject [
	view add: (self createElementFor: anObject).
	self cleanAndAddEdges.
	global executeOn: self view
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> addAll: objects [
	objects do: [ :anObject |
		view add: (self createElementFor: anObject) ].
	self cleanAndAddEdges.
	global executeOn: self view

	"SLOW!"
	"objects do: [ :o | self add: o ]"
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> addEdgesForObject: anObject [
	| edges |
	edges := self createEdgesFor: anObject.
	edges notNil
		ifTrue: [ view addAll: edges ]
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> applyLayout [
	layout executeOn: view.
	view edges do: [ :e | e trachelShape pushBack ]
	"layout on: view elements edges: view edges"
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> cleanAndAddEdges [
	"This is an expensive method"
	
	"Remove all the edges of the view"
	view edges copy do: [ :e | e remove ].

	view elements do: [ :element |
		self addEdgesForObject: element model ]
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> createEdgesFor: anObject [
	^ edge createEdgesFor: anObject
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> createElementFor: anObject [
	^ node createElementFor: anObject

]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> edge [
	^ edge
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> global [
	^ global
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> initialize [
	super initialize.
	node := RTGDNodeB new.
	edge := RTGDEdgeB new graphBuilder: self; yourself.
	layout := RTGDLayoutB new.
	global := RTGDGlobalB new.
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> layout [
	^ layout
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> node [
	^ node
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> open [
	self applyLayout.
	view open
]
