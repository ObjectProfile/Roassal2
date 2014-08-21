Class {
	#name : #RTShowEdge,
	#superclass : #RTInteraction,
	#instVars : [
		'connectToElements',
		'shape'
	],
	#classInstVars : [
		'lastHighlightedElements',
		'lastColor'
	],
	#category : 'Roassal2-Core'
}

{ #category : #'reset shape' }
RTShowEdge class >> lastHighlightedElements [
	^ lastHighlightedElements
]

{ #category : #'reset shape' }
RTShowEdge class >> lastHighlightedElements: elements [
	lastHighlightedElements := elements
]

{ #category : #public }
RTShowEdge >> connectTo: aBlock [
	"aBlock accepts an object and returns a list of objects"
	"aBlock return an object or a list of objects to highlight"
	connectToElements := [ :el | 
		| objects |
		objects := aBlock rtValue: el model.
		(objects collect: [ :o | el view elementFromModel: o ]) copyWithout: nil
		]
]

{ #category : #public }
RTShowEdge >> connectToElements: aBlock [
	"aBlock accepts a element and returns a list of elements"
	"aBlock return an element or a list of elements to highlight"
	connectToElements := aBlock
]

{ #category : #actions }
RTShowEdge >> doHideEdges: element [
	(element attributes includesKey: #showEdges)
		ifFalse: [ ^ self ].

	(element attributes at: #showEdges) do: #remove.

	element attributes removeKey: #showEdges
]

{ #category : #actions }
RTShowEdge >> doShowEdges: element [
	| t edges |
	self removeAllAddedEdges.

	t := (connectToElements rtValue: element).
	t := t copyWithout: nil.
	edges := (shape rtValue: element) edgesFrom: element toAll: t.
	element view addAll: edges.
	element attributes at: #showEdges put: edges.
	self class lastHighlightedElements: edges
]

{ #category : #configuration }
RTShowEdge >> highlightedColor [
	^ self class highlightedColor
]

{ #category : #initialize }
RTShowEdge >> initialize [
	super initialize.
	connectToElements := [ :el | Array with: el ].
	self shape: RTLine
]

{ #category : #hooks }
RTShowEdge >> initializeElement: element [
	element
		when: TRMouseEnter
		do: [ :e | 
			self doShowEdges: element.
			e signalUpdate ].
	element
		when: TRMouseLeave
		do: [ :e | 
			self doHideEdges: element.
			e signalUpdate ]
]

{ #category : #actions }
RTShowEdge >> recordElement: anElement [
	anElement attributes at: #originalColor put: (anElement trachelShape color)

]

{ #category : #actions }
RTShowEdge >> removeAllAddedEdges [
	self class lastHighlightedElements ifNil: [ ^ self ].
	self class lastHighlightedElements do: #remove.
	self class lastHighlightedElements: nil
]

{ #category : #accessing }
RTShowEdge >> shape [
	"Return the line shape"
	^ shape
]

{ #category : #accessing }
RTShowEdge >> shape: aLineShapeOrABlock [
	"Set the line shape used to draw the edges"
	"The argument is rtValued against the element to display"
	shape := aLineShapeOrABlock
]
