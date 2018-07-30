"
A RTHighlightable changes color of elements which should be highlighted.

"
Class {
	#name : #RTHighlightable,
	#superclass : #RTAbstractHighlightable,
	#instVars : [
		'color',
		'edgeColor',
		'getConnectedEdgesBlock',
		'getConnectedElementBlock'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #'reset shape' }
RTHighlightable class >> highlightedColor [
	"Default color for highlighting"
	^ Color blue
]

{ #category : #visitor }
RTHighlightable >> accept: aVisitor with: args [
	aVisitor visitHightlightableInteraction: self with: args.
]

{ #category : #accessing }
RTHighlightable >> color [
	"Return the color used for the highlighting"
	^ color
]

{ #category : #accessing }
RTHighlightable >> color: aColor [
	"Set the color used for the highlighting"
	color := aColor
]

{ #category : #actions }
RTHighlightable >> doHighlightElement: anElement [
	"Highlight a particular element."
	self recordElement: anElement.
	anElement trachelShape color: (self highlightColorFor: anElement).
	anElement view ifNotNil: [ anElement view signalUpdate ].
	
	"Highlight edges if necessary"
	self shouldHighlightEdges ifTrue: [ (getConnectedEdgesBlock rtValue: anElement) do: [ :anEdge | self doHighlightEdge: anEdge ] ]
]

{ #category : #actions }
RTHighlightable >> doUnhighlightElement: anElementOrEdge [
	"Unhighlight a particular element.
	This method also works for edges"
	(anElementOrEdge attributes includesKey: #originalColor)
		ifFalse: [ ^ self ].
	anElementOrEdge trachelShape color: (anElementOrEdge attributes at: #originalColor).
	anElementOrEdge attributes removeKey: #originalColor.
	anElementOrEdge view ifNotNil: [ anElementOrEdge view signalUpdate ].
	
	"Highlight edges if necessary"
	anElementOrEdge isEdge ifTrue: [ ^ self ].
	self shouldHighlightEdges ifTrue: [ (getConnectedEdgesBlock rtValue: anElementOrEdge) do: [ :anEdge | self doUnhighlightElement: anEdge ] ]
]

{ #category : #utility }
RTHighlightable >> highlightColorFor: anElement [
	"Return the highlight color"
	^ self highlightedColor rtValue: anElement model
]

{ #category : #configuration }
RTHighlightable >> highlightedColor [
	^ color
]

{ #category : #configuration }
RTHighlightable >> highlightedColor: aColorOrABlock [
	"Set the Color used to highlight"
	color := aColorOrABlock
]

{ #category : #initialize }
RTHighlightable >> initialize [
	super initialize.
	color := self class highlightedColor.
	
	"Per default, edges should not be highlighted"
	edgeColor := nil.
	self focusOnOutgoingElements.
]

{ #category : #actions }
RTHighlightable >> recordElement: anElement [
	(anElement attributes includesKey: #originalColor) ifTrue: [ ^ self ].
	anElement attributes at: #originalColor put: (anElement trachelShape color)

]
