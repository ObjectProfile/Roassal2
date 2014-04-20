Class {
	#name : #RTGraphBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'bundleConnectToElements',
		'nodes',
		'edges',
		'layouts',
		'globals'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGraphBuilder >> add: anObject [
	^ self addAll: (Array with: anObject)
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> addAll: objects [
	view addAll: (self createElementsFor: objects).
	self cleanAndAddEdges.
	globals do: #execute
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
	layouts do: #execute.
	view edges do: [ :e | e trachelShape pushBack ]
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> build [
	self applyLayout
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
	"Return a collection of Roassal edges that correspond to the argument"
	| answer |
	answer := OrderedCollection new.
	edges do: [ :edge |
		answer addAll: (edge createEdgesFor: anObject)
	].

	^ answer
	
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> createElementsFor: objects [
	"Return a collection of Roassal elements that corresponds to the argument"

	| gdNode answer |
	answer := OrderedCollection new.
	objects
		do: [ :obj | 
			gdNode := self getNodeFor: obj.
			gdNode ifNotNil: [ answer add: (gdNode createElementFor: obj) ] ].
	^ answer
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> edges [
	"Create a new entry for the edges"
	| n |
	n := RTGDEdgeB new.
	n graphBuilder: self.
	edges add: n.
	^ n
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> edgesUsedForLayout [
	"Return all the edges in the view that have to be used for layout"
	| answer |
	answer := OrderedCollection new.
	edges do: [ :e | answer addAll: e edgesUsedForLayout ].
	^ answer
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> getNodeFor: obj [
	^ nodes detect: [ :n | n canCreateForObject: obj ] ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> global [
	"Create a new entry for the globals"
	| global |
	global := RTGDGlobalB new.
	global graphBuilder: self.
	globals add: global.
	^ global.
	
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	edges := OrderedCollection new.	
	layouts := OrderedCollection new.				
	globals := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> layout [
	"Create a new entry for the layout"
	| layout |
	layout := RTGDLayoutB new.
	layout graphBuilder: self.
	layouts add: layout.
	^ layout
]

{ #category : #'as yet unclassified' }
RTGraphBuilder >> nodes [
	"Create a new entry for the nodes"
	| n |
	n := RTGDNodeB new.
	n graphBuilder: self.
	nodes add: n.
	^ n
]
