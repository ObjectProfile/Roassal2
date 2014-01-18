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

{ #category : #private }
RTMondrianViewBuilder >> edgeShape [
	shapeBuilder shape: (RTLine new).
	^ shapeBuilder shape
]

{ #category : #adding }
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

{ #category : #adding }
RTMondrianViewBuilder >> nodes: objects [
	| elements |
	elements := shapeBuilder elementsOn: objects.
	view addAll: elements.
	elements @ RTDraggable.
	topLevelNodes addAll: elements.

	"Do we really want to reset the shape builder? Users often find this disturbing"
	self resetShapeBuilder.
	^ elements
]

{ #category : #adding }
RTMondrianViewBuilder >> nodes: objects forEach: aOneArgBlock [
	"Create a set of nodes, each representing an element of objects. Each node then acts as a view on its own."

	| nodes allElements addedElements oldTopLevelNodes oldTopLevelEdges |
	nodes := self nodes: objects.
	nodes do: [ :n | 
		| oldShapeBuilder |
		"self push."
		"self horizontalLineLayout.		
		self createNewInteractionBuilder."
		oldTopLevelNodes := topLevelNodes.
		topLevelNodes := OrderedCollection new.
		oldTopLevelEdges := topLevelEdges.
		topLevelEdges := OrderedCollection new.
		
		oldShapeBuilder := shapeBuilder.
		self resetShapeBuilder.
		
		nesting := nesting + 1.
		allElements := view elements.	
		aOneArgBlock rtValue: n model.
		topLevelNodes := oldTopLevelNodes.
		topLevelEdges := oldTopLevelEdges.
		
		nesting := nesting - 1.
		addedElements := view elements copyWithoutAll: allElements.
		
		"Check if they are all at the same position. If this is the case, then we need to do the layout"
		(addedElements allSatisfy: [ :aNode | aNode position = addedElements anyOne position ])
			ifTrue: [ RTHorizontalLineLayout on: addedElements ].

		RTNest new
			on: n nest: addedElements.

		shapeBuilder := oldShapeBuilder.
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

{ #category : #layout }
RTMondrianViewBuilder >> treeLayout [
	self layout: RTTreeLayout new
]

{ #category : #adding }
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
