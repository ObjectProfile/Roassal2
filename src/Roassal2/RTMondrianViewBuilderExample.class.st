Class {
	#name : #RTMondrianViewBuilderExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-Mondrian'
}

{ #category : #example }
RTMondrianViewBuilderExample >> basic [
	"
	self new basic
	"
	| b |
	b := RTMondrianViewBuilder new.
	b shape rectangle size: 10; borderColor: Color black.
	b nodes: (1 to: 100).
	b edges: (1 to: 100) from: [ :v | v // 2 ] to: #yourself.
	b treeLayout.
	b open
]

{ #category : #example }
RTMondrianViewBuilderExample >> nestedTrees [
	"
	self new nestedTrees
	"
	| b |
	b := RTMondrianViewBuilder new.
	b use rectangle.
	b nodes: ((1 to: 10)) forEach: [ :each |
		b nodes: (each to: (each + 10)).
		b edges: (each to: (each + 10)) from: [ :v | v // 2 ] to: #yourself.
		b treeLayout.
	].
	b horizontalLineLayout.
	b open
]

{ #category : #example }
RTMondrianViewBuilderExample >> nesting [
	"
	self new nesting
	"
	| b |
	b := RTMondrianViewBuilder new.
	
	b nodes: (1 to: 10 by: 5) forEach: [ :each |
		b nodes: (each to: (each + 4)).
	].
"	b horizontalLineLayout."
	b open
]
