Class {
	#name : #RTGDNodeB,
	#superclass : #RTGDShapedElementB,
	#instVars : [
		'withPopup',
		'draggableNodes',
		'withDraggable'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDNodeB >> circle [
	^ self shape: RTEllipse new
]

{ #category : #'as yet unclassified' }
RTGDNodeB >> createElementFor: object [
	| e |
	e := shape elementOn: object.
	withPopup ifTrue: [ e @ RTPopup ].
	withDraggable ifTrue: [ e @ RTDraggable ].
	self initializePropertiesOn: e.
	^ e
	
]

{ #category : #'as yet unclassified' }
RTGDNodeB >> createElementsFor: objects [
	| es |
	es := shape elementsOn: objects.
	withPopup ifTrue: [ es @ RTPopup ].
	withDraggable ifTrue: [ es @ RTDraggable ].
	es do: [ :e | self initializePropertiesOn: e ].
	^ es
]

{ #category : #'as yet unclassified' }
RTGDNodeB >> initialize [
	super initialize.
	withDraggable := true.
	withPopup := true.
	shape := RTEllipse new size: 10
]

{ #category : #'as yet unclassified' }
RTGDNodeB >> noPopup [
	withPopup := false
]

{ #category : #'as yet unclassified' }
RTGDNodeB >> rectangle [
	^ self shape: RTBox new
]

{ #category : #'as yet unclassified' }
RTGDNodeB >> whenOverHighlight: aBlock [
	"When the mouse is over a node, highlight the elements returned by the block.
	 The block takes as argument the model on which the mouse is pointing to"
	self addProperty: [ :anElement | 
		anElement @ (RTHighlightable highlight: (aBlock rtValue: anElement model)) ]
]

{ #category : #'as yet unclassified' }
RTGDNodeB >> whenOverShowEdges: aBlock [
	"aBlock, when evaluated against an element return a model or a collection of models. 
	This will be used to draw edges"
	"interaction add: (Array with: conditional with: aBlock)"

	self addProperty: [ :anElement | 
		anElement @ (RTShowEdge new connectTo: aBlock) ]
]
