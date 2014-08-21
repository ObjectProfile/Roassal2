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

{ #category : #interaction }
RTGDNodeB >> @ anInteraction [
	"Adds an interaction to the elements"

	self addProperty: [ :anElement | anElement @ anInteraction ]
]

{ #category : #shapes }
RTGDNodeB >> circle [
	^ self shape: RTEllipse new
]

{ #category : #hooks }
RTGDNodeB >> createElementFor: object [
	| e |
	e := shape elementOn: object.
	withPopup ifTrue: [ e @ RTPopup @ (RTMenuActivable new item: 'inspect' action: #inspect) ].
	withDraggable ifTrue: [ e @ RTDraggable ].
	self initializePropertiesOn: e.
	^ e
	
]

{ #category : #'creating elements' }
RTGDNodeB >> createElements [
	| es |
	seed ifNil: [ ^ #() ].
	es := self createElementsFor: seed.
	graphBuilder view addAll: es.
	^ es
]

{ #category : #'creating elements' }
RTGDNodeB >> createElementsFor: objects [
	| es |
	es := shape elementsOn: objects.
	withPopup ifTrue: [ es @ RTPopup @ (RTMenuActivable new item: 'inspect' action: #inspect) ].
	withDraggable ifTrue: [ es @ RTDraggable ].
	es do: [ :e | self initializePropertiesOn: e ].
	^ es
]

{ #category : #accessing }
RTGDNodeB >> height: aBlock [
	shape height: aBlock
]

{ #category : #shapes }
RTGDNodeB >> if: conditionBlock color: colorBlock [
	"If conditionBlock is evaluated at true, then colorBlock is used to set the color of the node. Both conditionBlock and colorBlock are evaluated with the model value of the node."
	| oldBlockOrValue |
	oldBlockOrValue :=  shape color.
	^self color: [ :aModel | (conditionBlock rtValue: aModel)
									ifTrue: [ colorBlock rtValue: aModel ] 
									ifFalse: [ 
										"Having to create a new element is rather ugly. 
										Ideally, the oldBlockOrValue has to be 'unwrapped' for the translation"
										oldBlockOrValue rtValue: (RTElement on: aModel) ]].
							
						

]

{ #category : #initialization }
RTGDNodeB >> initialize [
	super initialize.
	withDraggable := true.
	withPopup := true.
	shape := RTEllipse new size: 10
]

{ #category : #shapes }
RTGDNodeB >> labelled [
	"Gives a label to each node"
	self addProperty: [ :el |
		| lbl |
		lbl := TRLabelShape new text: el model asString.
		graphBuilder view canvas addShape: lbl.
		TRConstraint stick: lbl below: el trachelShape ]
]

{ #category : #shapes }
RTGDNodeB >> labelled: aBlockOrSymbol [
	"Gives a label to each node"
	self addProperty: [ :el |
		| lbl |
		lbl := TRLabelShape new text: (aBlockOrSymbol rtValue: el model) asString.
		graphBuilder view canvas addShape: lbl.
		TRConstraint stick: lbl below: el trachelShape ]
]

{ #category : #interaction }
RTGDNodeB >> noPopup [
	withPopup := false
]

{ #category : #accessing }
RTGDNodeB >> rectangle [
	^ self shape: RTBox new
]

{ #category : #accessing }
RTGDNodeB >> size: aSize [
	self height: aSize.
	self width: aSize
]

{ #category : #interaction }
RTGDNodeB >> whenClicked: aBlock [
	"aBlock is evaluated with the model as argument"

	self addProperty: [ :anElement | 
		anElement when: TRMouseClick do: [ :evt | aBlock rtValue: evt element model ] ]
]

{ #category : #interaction }
RTGDNodeB >> whenOverHighlight: aBlock [
	"When the mouse is over a node, highlight the elements returned by the block.
	 The block takes as argument the model on which the mouse is pointing to"
	self addProperty: [ :anElement | 
		anElement @ (RTHighlightable highlight: (aBlock rtValue: anElement model)) ]
]

{ #category : #interaction }
RTGDNodeB >> whenOverShowEdges: aBlock [
	"aBlock, when evaluated against an element return a model or a collection of models. 
	This will be used to draw edges"
	"interaction add: (Array with: conditional with: aBlock)"

	self addProperty: [ :anElement | 
		anElement @ (RTShowEdge new connectTo: aBlock) ]
]

{ #category : #accessing }
RTGDNodeB >> width: aBlock [
	shape width: aBlock
]
