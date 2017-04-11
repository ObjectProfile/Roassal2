"
A RTMondrianViewBuilder is a builder for the Mondrian domain-specific language.
"
Class {
	#name : #RTMondrianViewBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'topLevelNodes',
		'nesting',
		'topLevelEdges',
		'layout'
	],
	#category : #'Roassal2-Builder-MondrianOLD'
}

{ #category : #layout }
RTMondrianViewBuilder >> applyLayout [
	self layout on: self topLevelNodes edges: self topLevelEdges 
]

{ #category : #layout }
RTMondrianViewBuilder >> build [
	self applyLayout
]

{ #category : #layout }
RTMondrianViewBuilder >> cellLayout [
	self layout: RTCellLayout new.
	^ self layout
]

{ #category : #layout }
RTMondrianViewBuilder >> circleLayout [
	self layout: RTCircleLayout new.
	^ self layout
]

{ #category : #layout }
RTMondrianViewBuilder >> clusterLayout [
	self layout: RTClusterLayout new.
	^self layout
]

{ #category : #hooks }
RTMondrianViewBuilder >> createShapeBuilder [
	^ RTMondrianShapeBuilder new
]

{ #category : #layout }
RTMondrianViewBuilder >> dominanceTreeLayout [
	self view edges do: [ :e | e shape withVerticallAttachPoint ].
	self layout: RTDominanceTreeLayout new.
	^self layout
]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edgeFromAssociation: association [

	^ self edges: (Array with: association) from: #key to: #value

]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edges: objects from: fromBlock to: toBlock [
	| es |
	self setLineShapeIfNecessary.
	es := RTEdge
		buildEdgesFromObjects: objects
		from: fromBlock
		to: toBlock
		using: shapeBuilder current
		inView: view
		scope:
			(RTGroup new
				addAll: topLevelNodes;
				yourself).
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
	self setLineShapeIfNecessary.
	es := RTEdge 
		buildEdgesFromObjects: objects 
		from: fromBlock 
		toAll: toAllBlock 
		using: shapeBuilder current
		inView: view 
		scope: (RTGroup new addAll: view elements; yourself).
	"scope: (RTGroup new addAll: topLevelNodes; yourself)."
	topLevelEdges addAll: es.
	es do: #moveBehindItsExtremities.
	^ es
]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edges: objects fromAll: fromAllBlock to: toBlock [
	
	| associations |
	associations := OrderedCollection new.
	objects do: [ :obj |
		| to |
		to := toBlock rtValue: obj.
		(fromAllBlock rtValue: obj) do: [:from | 
			associations add: (from -> to)
		]
	].
	^ self edgesFromAssociations: associations
]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edgesFrom: fromBlock [
	"The message edgesFrom: defines one edge per node. For each node that has been added in the visualization, an edge is defined between this node and a node lookup from the provided block."
	
	^ self edges: self topLevelObjects from: fromBlock to: #yourself

]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edgesFrom: object toAll: objects [
	^ self edges: self topLevelObjects from: #yourself toAll: objects

]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edgesFromAssociations: associations [

	^ self edges: associations from: #key to: #value

]

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> edgesToAll: objects [
	^ self edgesFrom: #yourself toAll: objects
]

{ #category : #layout }
RTMondrianViewBuilder >> flowLayout [
	self layout: RTFlowLayout new.
	^self layout
]

{ #category : #layout }
RTMondrianViewBuilder >> forceBasedLayout [
	self layout: RTForceBasedLayout new.
	^self layout
]

{ #category : #layout }
RTMondrianViewBuilder >> gridLayout [
	self layout: RTGridLayout new.
	^self layout
]

{ #category : #layout }
RTMondrianViewBuilder >> horizontalDominanceTreeLayout [
	self view edges do: [ :e | e shape withHorizontalAttachPoint ].
	self layout: RTHorizontalDominanceTreeLayout new.
	^self layout
]

{ #category : #layout }
RTMondrianViewBuilder >> horizontalLineLayout [
	self layout: RTHorizontalLineLayout new.
	^self layout
]

{ #category : #layout }
RTMondrianViewBuilder >> horizontalTreeLayout [
	self view edges do: [ :e | e shape withHorizontalAttachPoint ].
	self layout: RTHorizontalTreeLayout new.
	^self layout
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

{ #category : #'adding - nodes' }
RTMondrianViewBuilder >> node: anObject [
	"Add a new node to the view"
	^ (self nodes: (Array with: anObject)) first
]

{ #category : #'adding - nodes' }
RTMondrianViewBuilder >> node: anObject forIt: aBlock [
	^ (self 
		nodes: (Array with: anObject)
		forEach: [ :each | aBlock value ]) first
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
		n shape class == RTCompositeShape
			ifTrue: [ RTNest new on: n inShape: #second nest: addedElements ]
			ifFalse: [ RTNest new on: n nest: addedElements ].

		addedElements do: [ :e | e trachelShape pushFront ].
		
		"We pop"
		shapeBuilder := oldShapeBuilder.
		topLevelNodes := oldTopLevelNodes.
		topLevelEdges := oldTopLevelEdges.		
		nesting := nesting - 1.

		 ].
	self resetShapeBuilder.
	^ nodes
]

{ #category : #layout }
RTMondrianViewBuilder >> radialTreeLayout [
	self layout: RTRadialTreeLayout new.
	^self layout
]

{ #category : #initialization }
RTMondrianViewBuilder >> resetInteractionBuilder [
	interactionBuilder := RTInteractionBuilder new.
	interactionBuilder 
		draggable; popup
]

{ #category : #initialization }
RTMondrianViewBuilder >> resetShapeBuilder [
	shapeBuilder := self createShapeBuilder.
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

{ #category : #'adding - edges' }
RTMondrianViewBuilder >> setLineShapeIfNecessary [
	(self nodeShape class inheritsFrom: RTAbstractLine)
		ifFalse: [ self shape line ]
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
	self layout: RTTreeLayout new.
	^self layout
]

{ #category : #'adding - nodes' }
RTMondrianViewBuilder >> use [
	^ shapeBuilder ifNil: [ shapeBuilder := RTShapeBuilder new ]
]

{ #category : #layout }
RTMondrianViewBuilder >> verticalLineLayout [
	self layout: RTVerticalLineLayout new.
	^self layout
]

{ #category : #accessing }
RTMondrianViewBuilder >> view [
	^ view
]