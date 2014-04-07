Class {
	#name : #RTGDNodeB,
	#superclass : #Object,
	#instVars : [
		'conditionalShapes',
		'interaction'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #accessing }
RTGDNodeB >> conditionalShapes [
	"Return a collection of arrays. Each array has a size of 2. First is a condition, second is a shape"
	^ conditionalShapes
]

{ #category : #hooks }
RTGDNodeB >> createElementFor: object [
	| shape element |
	shape := (conditionalShapes detect: [ :arr | arr first rtValue: object ]) second.
	element := shape elementOn: object.

	interaction 
		do: [ :aBlock | aBlock value: element ].

	^ element
]

{ #category : #public }
RTGDNodeB >> for: conditional whenMouseOverShowEdges: aBlock [
	"aBlock, when evaluated against an element return a model or a collection of models. 
	This will be used to draw edges"
	interaction add: (Array with: conditional with: aBlock)
]

{ #category : #public }
RTGDNodeB >> if: condition shape: aShape [
	conditionalShapes add: (Array with: condition with: aShape)
]

{ #category : #initialization }
RTGDNodeB >> initialize [
	super initialize.
	conditionalShapes := OrderedCollection new.
	interaction := OrderedCollection new.
]

{ #category : #public }
RTGDNodeB >> shape: aShape [
	^ self if: true shape: aShape
]

{ #category : #public }
RTGDNodeB >> whenMouseOverShowEdges: aBlock [
	"aBlock, when evaluated against an element return a model or a collection of models. 
	This will be used to draw edges"
	^ self for: true whenMouseOverShowEdges: aBlock
]

{ #category : #'public-interaction' }
RTGDNodeB >> whenOverHighlight: aBlock [
	"When the mouse is over a node, highlight the elements returned by the block.
	 The block takes as argument the model on which the mouse is pointing to"
	interaction add: [ :anElement | 
	self haltOnce.
		anElement @ (RTHighlightable highlight: (aBlock rtValue: anElement model)) ]
]
