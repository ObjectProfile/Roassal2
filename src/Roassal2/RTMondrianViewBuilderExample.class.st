Class {
	#name : #RTMondrianViewBuilderExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-Mondrian'
}

{ #category : #'as yet unclassified' }
RTMondrianViewBuilderExample >> basic [
	"
	self new basic
	"
	| b |
	b := RTMondrianViewBuilder new.
	b nodes: (1 to: 10).
	b horizontalLineLayout.
	b open
]
