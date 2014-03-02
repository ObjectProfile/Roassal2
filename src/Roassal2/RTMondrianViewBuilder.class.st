Class {
	#name : #RTMondrianViewBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'topLevelNodes',
		'nesting',
		'topLevelEdges',
		'layout',
		'lineShapeBuilder'
	],
	#category : #'Roassal2-Builder-Mondrian'
}

{ #category : #layout }
RTMondrianViewBuilder >> applyLayout [
	self layout on: self topLevelNodes edges: self topLevelEdges 
]

{ #category : #layout }
RTMondrianViewBuilder >> clusterLayout [
	self layout: RTClusterLayout new
]

{ #category : #private }
RTMondrianViewBuilder >> edgeShape [
	^ lineShapeBuilder shape
]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edges: objects from: fromBlock to: toBlock [

	| es |
	es := RTEdge 
		buildEdgesFromObjects: objects 
		from: fromBlock 
		to: toBlock 
		using: self edgeShape
		inView: view 
		scope: (RTGroup new addAll: topLevelNodes; yourself).
	topLevelEdges addAll: es.
	es do: #moveBehindItsExtremities.
	^ es
]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edges: objects from: fromBlock toAll: toAllBlock [
	"- objects is the collection of from which the edges are defined from.
	- fromBlock will be called on each entity of the collection and return one edge source each time.
	- toAllBlock will be called similarly to return a collection of destination correpsonding to each source.
	Note that there is no restriction on the entities of aCollection, as long as aFromBlock returns a node and aToBlock returns a collection of nodes.
	For example:
	  aView edges: someFamixInvocations from: #sender toAll: #candidates

	Or:
	
	| collection |
	collection := #(1 2 3 4 5 6 7 8 9 10).
	builder shape label.
	builder nodes: collection.
	builder edges: collection from: #yourself toAll: (collection select: #odd).
	builder circleLayout
		
	aToBlock should return a collection, edges will be drawn from the entity returned by aFromBlock to this collection"
	
	| es |
	es := RTEdge 
		buildEdgesFromObjects: objects 
		from: fromBlock 
		toAll: toAllBlock 
		using: self edgeShape
		inView: view 
		scope: (RTGroup new addAll: topLevelNodes; yourself).
	topLevelEdges addAll: es.
	es do: #moveBehindItsExtremities
]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edgesFrom: fromBlock [
	^ self edges: self topLevelObjects from: fromBlock to: #yourself

]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edgesFrom: object toAll: objects [
	^ self edges: (Array with: object) from: #yourself toAll: objects

]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edgesFromAssociations: associations [

	^ self edges: associations from: #key to: #value

]

{ #category : #layout }
RTMondrianViewBuilder >> forceBasedLayout [
	self layout: RTForceBasedLayout new
]

{ #category : #layout }
RTMondrianViewBuilder >> gridLayout [
	self layout: RTGridLayout
]

{ #category : #layout }
RTMondrianViewBuilder >> horizontalLineLayout [
	self layout: RTHorizontalLineLayout
]

{ #category : #initialization }
RTMondrianViewBuilder >> initialize [
	super initialize.
	self resetView.
	self resetShapeBuilder.
	self resetLineShapeBuilder.
	self resetInteractionBuilder.
	
	topLevelNodes := OrderedCollection new.
	topLevelEdges := OrderedCollection new.
	nesting := 0.
	
]

{ #category : #accessing }
RTMondrianViewBuilder >> layout [
	layout ifNil: [ layout := RTHorizontalLineLayout new ].
	^ layout
]

{ #category : #accessing }
RTMondrianViewBuilder >> layout: aLayout [
	layout := aLayout
]

{ #category : #'adding - nodes' }
RTMondrianViewBuilder >> node: anObject [
	"Add a new node to the view"
	^ (self nodes: (Array with: anObject)) first
]

{ #category : #private }
RTMondrianViewBuilder >> nodeShape [
	^ shapeBuilder shape
]

{ #category : #'adding - nodes' }
RTMondrianViewBuilder >> nodes: objects [
	| elements |
	elements := shapeBuilder elementsOn: objects.
	view addAll: elements.

	interactionBuilder setUpElements: elements.

	topLevelNodes addAll: elements.

	"Do we really want to reset the shape builder? Users often find this disturbing"
	self resetShapeBuilder.
	^ elements
]

{ #category : #'adding - nodes' }
RTMondrianViewBuilder >> nodes: objects forEach: aOneArgBlock [
	"Create a set of nodes, each representing an element of objects. Each node then acts as a view on its own."

	| nodes allElements addedElements oldTopLevelNodes oldTopLevelEdges oldShapeBuilder allEdges addedEdges |
	nodes := self nodes: objects.
	nodes do: [ :n | 
		"We push"
		oldTopLevelNodes := topLevelNodes.
		topLevelNodes := OrderedCollection new.
		oldTopLevelEdges := topLevelEdges.
		topLevelEdges := OrderedCollection new.
		nesting := nesting + 1.
		oldShapeBuilder := shapeBuilder.
		self resetShapeBuilder.
		
		"We remember all the elements before adding the inner ones"
		allElements := view elements.	
		allEdges := view edges.
		
		aOneArgBlock rtValue: n model.

		"We identify all the inner elements and edges"
		addedElements := view elements copyWithoutAll: allElements.
		addedEdges := view edges copyWithoutAll: allEdges.

		self applyLayout.

		RTNest new
			on: n nest: addedElements.

		addedElements do: [ :e | e trachelShape pushFront ].
		
		"We pop"
		shapeBuilder := oldShapeBuilder.
		topLevelNodes := oldTopLevelNodes.
		topLevelEdges := oldTopLevelEdges.		
		nesting := nesting - 1.

		 ].
	"self unsetShape."
	^ nodes
]

{ #category : #'instance creation' }
RTMondrianViewBuilder >> open [
	self applyLayout.
	^ view open
]

{ #category : #layout }
RTMondrianViewBuilder >> radialTreeLayout [
	^ self layout: RTRadialTreeLayout new
]

{ #category : #initialization }
RTMondrianViewBuilder >> resetInteractionBuilder [
	interactionBuilder := RTInteractionBuilder new.
	interactionBuilder 
		draggable; popup
]

{ #category : #initialization }
RTMondrianViewBuilder >> resetLineShapeBuilder [
	lineShapeBuilder := RTShapeBuilder new.
	lineShapeBuilder line
		color: Color gray 
]

{ #category : #initialization }
RTMondrianViewBuilder >> resetShapeBuilder [
	shapeBuilder := RTShapeBuilder new.
	shapeBuilder rectangle
						fillColor: Color white;
						borderColor: Color black. 
]

{ #category : #initialization }
RTMondrianViewBuilder >> resetView [
	view := RTView new.
	view @ RTDraggableView.
	view canvas color: Color white
]

{ #category : #accessing }
RTMondrianViewBuilder >> topLevelEdges [
	^ topLevelEdges
]

{ #category : #accessing }
RTMondrianViewBuilder >> topLevelNodes [
	^ topLevelNodes
]

{ #category : #accessing }
RTMondrianViewBuilder >> topLevelObjects [
	^ self topLevelNodes collect: #model
]

{ #category : #layout }
RTMondrianViewBuilder >> treeLayout [
	self view edges do: [ :e | e shape withVerticallAttachPoint ].
	self layout: RTTreeLayout new
]

{ #category : #'adding - nodes' }
RTMondrianViewBuilder >> use [
	^ shapeBuilder ifNil: [ shapeBuilder := RTShapeBuilder new ]
]

{ #category : #accessing }
RTMondrianViewBuilder >> view [
	^ view
]

{ #category : #private }
RTMondrianViewBuilder >> with: anElement during: aBlock [
	| state |
	state := self shallowCopy.
	self root: anElement.
	aBlock ensure: [ self copyFrom: state ]

]
