"
A RTTransitivelyHighlightable highlight all connected elements (either incoming or outgoing). Consider the following example:

	v := RTView new.
	v addAll: (RTBox elementsOn: (1 to: 3)).
	RTGridLayout on: v elements.
	
	eb := RTEdgeBuilder new.
	eb view: v.
	eb useAssociations: { 1 -> 2 . 2 -> 3 }.
	
	v elements @ RTPopup @ (RTTransitivelyHighlightable new focusOnIncomingElements; color: Color red).
	v
"
Class {
	#name : #RTTransitivelyHighlightable,
	#superclass : #RTHighlightable,
	#instVars : [
		'getConnectedElementBlock'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #'public - configuration' }
RTTransitivelyHighlightable >> focusOnIncomingElements [
	self getConnectedElementBlock: [ :e | e incomingEdges collect: #from ]
]

{ #category : #'public - configuration' }
RTTransitivelyHighlightable >> focusOnOutgoingElements [
	self getConnectedElementBlock:  [ :e | e outgoingEdges collect: #to ]
]

{ #category : #accessing }
RTTransitivelyHighlightable >> getConnectedElementBlock [
	^ getConnectedElementBlock
]

{ #category : #accessing }
RTTransitivelyHighlightable >> getConnectedElementBlock: aBlockOrSymbol [
	"Set the way connected elements must be obtained "
	getConnectedElementBlock := aBlockOrSymbol
]

{ #category : #actions }
RTTransitivelyHighlightable >> getConnectedElementsFrom: anElement [
	^ getConnectedElementBlock rtValue: anElement
]

{ #category : #actions }
RTTransitivelyHighlightable >> getRelevantElementsFrom: someElements [
	"Return the transively closure of connected elements."
	| set |
	set := Set new.
	someElements do: [ :e | self getRelevantElementsFromSingle: e in: set ].
	^ set
]

{ #category : #actions }
RTTransitivelyHighlightable >> getRelevantElementsFromSingle: anElement in: set [
	(set includes: anElement)
		ifTrue: [ ^ self ].
	set add: anElement.
	(self getConnectedElementsFrom: anElement)
		do: [ :e | self getRelevantElementsFromSingle: e in: set ]
]

{ #category : #initialization }
RTTransitivelyHighlightable >> initialize [
	super initialize.
	self focusOnOutgoingElements
]
