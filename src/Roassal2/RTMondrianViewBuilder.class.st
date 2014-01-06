Class {
	#name : #RTMondrianViewBuilder,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'topLevelNodes',
		'nesting',
		'topLevelEdges',
		'shapeBuilder',
		'interactionBuilder'
	],
	#category : #'Roassal2-Builder-Mondrian'
}

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
	RTGridLayout on: topLevelNodes
]

{ #category : #layout }
RTMondrianViewBuilder >> horizontalLineLayout [
	RTHorizontalLineLayout on: topLevelNodes
]

{ #category : #initialization }
RTMondrianViewBuilder >> initialize [
	super initialize.
	view := RTView new.
	view @ RTDraggableView.
	topLevelNodes := OrderedCollection new.
	topLevelEdges := OrderedCollection new.
	nesting := 0.
	shapeBuilder := RTShapeBuilder new.
]

{ #category : #private }
RTMondrianViewBuilder >> nodeShape [
	^ shapeBuilder shape
]

{ #category : #adding }
RTMondrianViewBuilder >> nodes: objects [
	| elements |
	elements := self nodeShape elementsOn: objects.
	view addAll: elements.
	elements @ RTDraggable.
	topLevelNodes addAll: elements.
	shapeBuilder reset.
	^ elements
]

{ #category : #adding }
RTMondrianViewBuilder >> nodes: objects forEach: aOneArgBlock [
	"Create a set of nodes, each representing an element of objects. Each node then acts as a view on its own."

	| nodes allElements addedElements oldTopLevelNodes oldTopLevelEdges |
	nodes := self nodes: objects.
	nodes do: [ :n | 
		"self push."
		"self horizontalLineLayout.		
		self createNewInteractionBuilder."
		oldTopLevelNodes := topLevelNodes.
		topLevelNodes := OrderedCollection new.
		oldTopLevelEdges := topLevelEdges.
		topLevelEdges := OrderedCollection new.
		
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
		 ].
	"self unsetShape."
	^ nodes
]

{ #category : #'instance creation' }
RTMondrianViewBuilder >> open [
	^ view open
]

{ #category : #accessing }
RTMondrianViewBuilder >> topLevelNodes [
	^ topLevelNodes
]

{ #category : #layout }
RTMondrianViewBuilder >> treeLayout [
	RTTreeLayout on: topLevelNodes edges: topLevelEdges
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
