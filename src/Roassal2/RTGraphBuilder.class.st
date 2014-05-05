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

{ #category : #adding }
RTGraphBuilder >> add: anObject [
	^ self addAll: (Array with: anObject)
]

{ #category : #adding }
RTGraphBuilder >> addAll: objects [
	view addAll: (self createElementsFor: objects).
	self cleanAndAddEdges.
	globals do: #execute
]

{ #category : #adding }
RTGraphBuilder >> addEdgesForObject: anObject [
	| edges |
	edges := self createEdgesFor: anObject.
	edges notNil
		ifTrue: [ view addAll: edges ]
]

{ #category : #actions }
RTGraphBuilder >> applyLayout [
	| partionnedGroups |
	partionnedGroups := nil.
	layouts do: [ :l |
		partionnedGroups ifNotNil: [ l partionnedGroups: partionnedGroups ].
		l execute.
		partionnedGroups := l partionnedGroups.
	].
	view edges do: [ :e | e trachelShape pushBack ]
]

{ #category : #public }
RTGraphBuilder >> build [
	self applyLayout
]

{ #category : #actions }
RTGraphBuilder >> cleanAndAddEdges [
	"This is an expensive method"
	
	"Remove all the edges of the view"
	view edges copy do: [ :e | e remove ].

	view elements do: [ :element |
		self addEdgesForObject: element model ]
]

{ #category : #public }
RTGraphBuilder >> createEdgesFor: anObject [
	"Return a collection of Roassal edges that correspond to the argument"
	| answer |
	answer := OrderedCollection new.
	edges do: [ :edge |
		answer addAll: (edge createEdgesFor: anObject)
	].

	^ answer
	
]

{ #category : #'creating elements' }
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

{ #category : #hooks }
RTGraphBuilder >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #accessing }
RTGraphBuilder >> edges [
	"Create a new entry for the edges"
	| n |
	n := RTGDEdgeB new.
	n graphBuilder: self.
	edges add: n.
	^ n
]

{ #category : #accessing }
RTGraphBuilder >> edgesUsedForLayout [
	"Return all the edges in the view that have to be used for layout"
	| answer |
	answer := OrderedCollection new.
	edges do: [ :e | answer addAll: e edgesUsedForLayout ].
	^ answer
]

{ #category : #accessing }
RTGraphBuilder >> getNodeFor: obj [
	^ nodes detect: [ :n | n canCreateForObject: obj ] ifNone: [ nil ]
]

{ #category : #accessing }
RTGraphBuilder >> global [
	"Create a new entry for the globals"
	| global |
	global := RTGDGlobalB new.
	global graphBuilder: self.
	globals add: global.
	^ global.
	
]

{ #category : #initialization }
RTGraphBuilder >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	edges := OrderedCollection new.	
	layouts := OrderedCollection new.				
	globals := OrderedCollection new.
	
]

{ #category : #accessing }
RTGraphBuilder >> layout [
	"Create a new entry for the layout"
	| layout |
	layout := RTGDLayoutB new.
	layout graphBuilder: self.
	layouts add: layout.
	^ layout
]

{ #category : #accessing }
RTGraphBuilder >> nodes [
	"Create a new entry for the nodes"
	| n |
	n := RTGDNodeB new.
	n graphBuilder: self.
	nodes add: n.
	^ n
]
