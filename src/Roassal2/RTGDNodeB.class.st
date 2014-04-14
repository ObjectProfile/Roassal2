Class {
	#name : #RTGDNodeB,
	#superclass : #RTGDElement,
	#instVars : [
		'conditionalShapes',
		'withPopup',
		'draggableNodes'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #hooks }
RTGDNodeB >> createElementFor: object [
	| shape element |
	shape := (conditionalShapes detect: [ :arr | arr first rtValue: object ] ifNone: [ Array with: nil with: self defaultShape ]) second.
	element := shape elementOn: object.
	self initializePropertiesOn: element.
	self setPopupAndDraggableOn: element.
	^ element
]

{ #category : #initialization }
RTGDNodeB >> defaultShape [
	^ RTEllipse new size: 15
]

{ #category : #'public-interaction' }
RTGDNodeB >> for: conditional whenOverShowEdges: aBlock [
	"aBlock, when evaluated against an element return a model or a collection of models. 
	This will be used to draw edges"
	"interaction add: (Array with: conditional with: aBlock)"

	self addProperty: [ :anElement | 
		(conditional rtValue: anElement model)
			ifTrue: [ anElement @ (RTShowEdge new connectTo: aBlock) ] ]
]

{ #category : #accessing }
RTGDNodeB >> graph: aGraphBuilder [
	self graphBuilder: aGraphBuilder
]

{ #category : #'public-interaction' }
RTGDNodeB >> highlightOutgoingEdges [
]

{ #category : #'public-shape' }
RTGDNodeB >> if: condition color: aColor [
	^ self if: condition shape: (RTEllipse new color: aColor)
]

{ #category : #'public-shape' }
RTGDNodeB >> if: condition shape: aShape [
	conditionalShapes add: (Array with: condition with: aShape)
]

{ #category : #initialization }
RTGDNodeB >> initialize [
	super initialize.
	conditionalShapes := OrderedCollection new.
	withPopup := true.
	draggableNodes := true
]

{ #category : #'public-shape' }
RTGDNodeB >> labelled [
	"Gives a label to each node"
	self addProperty: [ :el |
		| lbl |
		lbl := TRLabelShape new text: el model asString.
		graphBuilder view canvas addShape: lbl.
		TRConstraint stick: lbl below: el trachelShape ]
]

{ #category : #'public-interaction' }
RTGDNodeB >> noPopup [
	withPopup := false
]

{ #category : #'public-interaction' }
RTGDNodeB >> notDraggable [
	draggableNodes := false
]

{ #category : #hooks }
RTGDNodeB >> setPopupAndDraggableOn: element [
	withPopup
		ifTrue: [ element @ RTPopup ].
	draggableNodes
		ifTrue: [ element @ RTDraggable ]
]

{ #category : #'public-shape' }
RTGDNodeB >> shape: aShape [
	^ self if: true shape: aShape
]

{ #category : #'public-interaction' }
RTGDNodeB >> whenOverHighlight: aBlock [
	"When the mouse is over a node, highlight the elements returned by the block.
	 The block takes as argument the model on which the mouse is pointing to"
	self addProperty: [ :anElement | 
		anElement @ (RTHighlightable highlight: (aBlock rtValue: anElement model)) ]
]

{ #category : #'public-interaction' }
RTGDNodeB >> whenOverHighlightOutgoingEdges [
	self addProperty: [ :anElement | 
		RTBlink highlightElements: anElement outgoingEdges ]
]

{ #category : #'public-interaction' }
RTGDNodeB >> whenOverShowEdges: aBlock [
	"aBlock, when evaluated against an element return a model or a collection of models. 
	This will be used to draw edges"
	^ self for: true whenOverShowEdges: aBlock
]
