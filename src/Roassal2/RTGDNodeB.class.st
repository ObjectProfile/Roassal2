Class {
	#name : #RTGDNodeB,
	#superclass : #Object,
	#instVars : [
		'conditionalShapes',
		'forWhenMouseOverShowEdges'
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

	forWhenMouseOverShowEdges do: [ :array |
		| condition blockEdgeCreation |
		condition := array first.
		blockEdgeCreation := array second.
		(condition rtValue: object) ifTrue: [  ]
		].
self flag: #TODO.
	^ element
]

{ #category : #public }
RTGDNodeB >> for: conditional whenMouseOverShowEdges: aBlock [
	"aBlock, when evaluated against an element return a model or a collection of models. 
	This will be used to draw edges"
	forWhenMouseOverShowEdges add: (Array with: conditional with: aBlock)
]

{ #category : #public }
RTGDNodeB >> if: condition shape: aShape [
	conditionalShapes add: (Array with: condition with: aShape)
]

{ #category : #initialization }
RTGDNodeB >> initialize [
	super initialize.
	conditionalShapes := OrderedCollection new.
	forWhenMouseOverShowEdges := OrderedCollection new.
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
