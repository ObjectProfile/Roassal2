Class {
	#name : #RTMondrianViewBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'topLevelNodes',
		'nesting',
		'topLevelEdges',
		'layout'
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
	shapeBuilder shape: (RTLine new).
	^ shapeBuilder shape
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
	topLevelEdges addAll: es
]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edgesFrom: fromBlock [
	^ self edges: self topLevelObjects from: fromBlock to: #yourself

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

{ #category : #initialization }
RTMondrianViewBuilder >> resetInteractionBuilder [
	interactionBuilder := RTInteractionBuilder new.
	interactionBuilder 
		draggable; popup
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
