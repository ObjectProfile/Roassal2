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
	self assert: (builder elementFromModel: 100) position = (0 @ 0).
	 
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
