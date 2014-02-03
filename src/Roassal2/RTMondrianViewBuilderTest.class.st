Class {
	#name : #RTMondrianViewBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'builder'
	],
	#category : #'Roassal2-Builder-Mondrian'
}

{ #category : #basic }
RTMondrianViewBuilderTest >> setUp [

	builder := RTMondrianViewBuilder new
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testBasic [
	
	builder nodes: #(1 2 3 4 5).
	builder edges: #(1 2 3 4 5) from: #yourself to: [ :v | v + 1 ].
	builder treeLayout.
	self assert: builder view numberOfElements = 5.
	self assert: builder view numberOfEdges = 4.
]

{ #category : #layout }
RTMondrianViewBuilderTest >> testDefaultLayout [

	self assert: builder layout class == RTHorizontalLineLayout
]

{ #category : #edges }
RTMondrianViewBuilderTest >> testEdgesFrom [

	| view |
	builder nodes: (Array with: 1 with: 2).
	builder edgesFrom: [ :v | v - 1 ].
	view := builder view.
	
	self assert: view numberOfElements equals: 2.
	self assert: view numberOfEdges equals: 1.
	
	self assert: view edges anyOne shape class == RTLine
]

{ #category : #edges }
RTMondrianViewBuilderTest >> testEdgesFromToAll [

	| view edge nodes |
	builder nodes: (Array with: 1 with: 2).
	builder edges: (Array with: 1) from: #yourself toAll: (Array with: 2).
	view := builder view.
	
	self assert: view numberOfElements equals: 2.
	self assert: view numberOfEdges equals: 1.
	
	edge := view edges anyOne.
	nodes := view elements.
	self assert: edge from == nodes first.
	self assert: edge to == nodes second.
	self assert: edge shape class == RTLine
]

{ #category : #layout }
RTMondrianViewBuilderTest >> testLayoutAndTreeLayout [
	| view |
	builder nodes: (Array with: 'hello') forEach: [ :e |
		
		builder nodes: (1 to: 5).
		builder shape line color: Color black.
		builder edges: (Array with: 1) from: #yourself toAll: (1 to: 5).
		builder treeLayout. 
		].
	builder gridLayout.
	builder applyLayout.
	
	view := builder view.
	self assert: (view elementFromModel: 1) position ~= (view elementFromModel: 2) position
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testNesting [

	builder nodes: #(1 10) forEach: [ :v | builder nodes: (Array with: v + 1 with: v + 2) ].
	self assert: builder view numberOfElements = 6.
	self assert: builder topLevelNodes size = 2.
	self assert: (builder topLevelNodes collect: #model) asArray = #(1 10).
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testNestingSimple [

	builder nodes: #(1) forEach: [ :v | builder nodes: #(2) ].
	self assert: builder view numberOfElements = 2.
	self assert: builder topLevelNodes size = 1
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testNestingSmallTree [

	builder nodes: #(100) forEach: [ :v | 
		builder nodes: #(1 2 3 4). 
		builder edges: #(1 2 3 4) from: [ :vv | vv // 2 ] to: #yourself.
		builder treeLayout ].
	
	self assert: builder view numberOfElements = 5.
	self assert: builder view numberOfEdges = 3.
	self assert: builder topLevelNodes size = 1.
	self assert: (builder view elementFromModel: 100) position = (0 @ 0).
	 
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testNoShape [

	| nodes  node |
	nodes := builder nodes: #(10).
	self assert: nodes notNil.
	self assert: nodes size equals: 1.
	
	node := nodes first.
	self assert: node shape class == RTBox.
	self assert: node trachelShape class == TRBoxShape
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testNodeAreDraggablePerDefault [

	| el |
	el := builder node: 'hello'.
	self assert: el position = (0 @ 0).
	el announce: (TRMouseDragging step: 10 @ 5).
	self assert: el position = (10 @ 5).
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testTopLevel [
	builder nodes: (1 to: 5).
	builder nodes: (1 to: 5).
	self assert: builder topLevelNodes size = 10
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testTopLevel2 [
	builder nodes: (1 to: 5).
	builder nodes: (1 to: 5) forEach: [ :v | builder nodes: (Array with: v) ].
	builder nodes: (1 to: 5).
	
	self assert: builder topLevelNodes size = 15
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testTopLevelDefault [

	self assert: builder topLevelNodes isEmpty
]

{ #category : #basic }
RTMondrianViewBuilderTest >> testTopLevelObjects [

	builder nodes: (1 to: 5).
	self assert: builder topLevelObjects asArray = (1 to: 5) asArray
]

{ #category : #layout }
RTMondrianViewBuilderTest >> testTreeLayout [

	| b |
	b := RTMondrianViewBuilder new.
	b nodes: (1 to: 5).
	b shape line color: Color black.
	b edges: (Array with: 1) from: #yourself toAll: (1 to: 5).
	b treeLayout. 
	b applyLayout.
	"There are 5 different position, one for each element"
	self assert: (b view elements collect: #position) asSet size = 5
]
