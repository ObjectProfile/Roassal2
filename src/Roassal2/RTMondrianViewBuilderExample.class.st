Class {
	#name : #RTMondrianViewBuilderExample,
	#superclass : #RTObject,
	#category : 'Roassal2-Builder-Mondrian'
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
RTMondrianViewBuilderExample >> classes [

	"
	self new classes
	"
	| b |
	b := RTMondrianViewBuilder new.
	b shape rectangle 
				withBorder;
				width: #numberOfVariables;
				height: #numberOfMethods;
				fillColor: Color white.
	b nodes: RTObject withAllSubclasses.
	b gridLayout.
	b open
]

{ #category : #example }
RTMondrianViewBuilderExample >> nestedTrees [
	"
	self new nestedTrees
	"
	| b |
	b := RTMondrianViewBuilder new.
	
	b nodes: (1 to: 100 by: 10) forEach: [ :each |
		b nodes: (1 to: each).
		b edgesFrom: [ :v | v // 2 ].
		b clusterLayout.
	].
	b gridLayout.
	b open
]

{ #category : #example }
RTMondrianViewBuilderExample >> nesting [
	"
	self new nesting
	"
	| b |
	b := RTMondrianViewBuilder new.
	
	b nodes: (1 to: 10) forEach: [ :each |
		b nodes: (1 to: (each)).
		b gridLayout.
	].
"	b horizontalLineLayout."
	b open
]

{ #category : #example }
RTMondrianViewBuilderExample >> radialTreeLayout [

	| b |
	b := RTMondrianViewBuilder new.
	b shape circle size: 10.
	b nodes: (1 to: 100).
	b edgesFrom: [ :v | v // 2 ].
	b radialTreeLayout.
	b open

]
