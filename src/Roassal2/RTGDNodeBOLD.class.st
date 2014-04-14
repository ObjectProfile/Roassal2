Class {
	#name : #RTGDNodeBOLD,
	#superclass : #RTGDElement,
	#instVars : [
		'conditionalShapes',
		'withPopup',
		'draggableNodes'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #hooks }
RTGDNodeBOLD >> createElementFor: object [
	| shape element |
	shape := (conditionalShapes detect: [ :arr | arr first rtValue: object ] ifNone: [ Array with: nil with: self defaultShape ]) second.
	element := shape elementOn: object.
	self initializePropertiesOn: element.
	self setPopupAndDraggableOn: element.
	^ element
]

{ #category : #initialization }
RTGDNodeBOLD >> defaultShape [
	^ RTEllipse new size: 15
]

{ #category : #'public-interaction' }
RTGDNodeBOLD >> for: conditional whenOverShowEdges: aBlock [
	"aBlock, when evaluated against an element return a model or a collection of models. 
	This will be used to draw edges"
	"interaction add: (Array with: conditional with: aBlock)"

	self addProperty: [ :anElement | 
		(conditional rtValue: anElement model)
			ifTrue: [ anElement @ (RTShowEdge new connectTo: aBlock) ] ]
]

{ #category : #accessing }
RTGDNodeBOLD >> graph: aGraphBuilder [
	self graphBuilder: aGraphBuilder
]

{ #category : #'public-interaction' }
RTGDNodeBOLD >> highlightOutgoingEdges [
]

{ #category : #'public-shape' }
RTGDNodeBOLD >> if: condition color: aColor [
	^ self if: condition shape: (RTEllipse new color: aColor)
]

{ #category : #'public-shape' }
RTGDNodeBOLD >> if: condition shape: aShape [
	conditionalShapes add: (Array with: condition with: aShape)
]

{ #category : #initialization }
RTGDNodeBOLD >> initialize [
	super initialize.
	conditionalShapes := OrderedCollection new.
	withPopup := true.
	draggableNodes := true
]

{ #category : #'public-shape' }
RTGDNodeBOLD >> labelled [
	"Gives a label to each node"
	self addProperty: [ :el |
		| lbl |
		lbl := TRLabelShape new text: el model asString.
		graphBuilder view canvas addShape: lbl.
		TRConstraint stick: lbl below: el trachelShape ]
]

{ #category : #'public-interaction' }
RTGDNodeBOLD >> noPopup [
	withPopup := false
]

{ #category : #'public-interaction' }
RTGDNodeBOLD >> notDraggable [
	draggableNodes := false
]

{ #category : #hooks }
RTGDNodeBOLD >> setPopupAndDraggableOn: element [
	withPopup
		ifTrue: [ element @ RTPopup ].
	draggableNodes
		ifTrue: [ element @ RTDraggable ]
]

{ #category : #'public-shape' }
RTGDNodeBOLD >> shape: aShape [
	^ self if: true shape: aShape
]

{ #category : #'public-interaction' }
RTGDNodeBOLD >> whenOverHighlight: aBlock [
	"When the mouse is over a node, highlight the elements returned by the block.
	 The block takes as argument the model on which the mouse is pointing to"
	self addProperty: [ :anElement | 
		anElement @ (RTHighlightable highlight: (aBlock rtValue: anElement model)) ]
]

{ #category : #'public-interaction' }
RTGDNodeBOLD >> whenOverHighlightOutgoingEdges [
	self addProperty: [ :anElement | 
		RTBlink highlightElements: anElement outgoingEdges ]
]

{ #category : #'public-interaction' }
RTGDNodeBOLD >> whenOverShowEdges: aBlock [
	"aBlock, when evaluated against an element return a model or a collection of models. 
	This will be used to draw edges"
	^ self for: true whenOverShowEdges: aBlock
]
