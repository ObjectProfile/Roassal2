"
A RTHighlightable changes color of elements which should be highlighted.

"
Class {
	#name : #RTHighlightable,
	#superclass : #RTAbstractHighlightable,
	#category : #'Roassal2-Core'
}

{ #category : #'reset shape' }
RTHighlightable class >> highlightedColor [
	^ Color blue
]

{ #category : #actions }
RTHighlightable >> doHighlightElement: anElement [
	self recordElement: anElement.
	^ anElement trachelShape color: self highlightedColor
]

{ #category : #actions }
RTHighlightable >> doUnhighlightElement: anElement [
	(anElement attributes includesKey: #originalColor)
		ifFalse: [ ^ self ].
	anElement trachelShape color: (anElement attributes at: #originalColor).
	anElement attributes removeKey: #originalColor
]

{ #category : #configuration }
RTHighlightable >> highlightedColor [
	^ self class highlightedColor
]

{ #category : #actions }
RTHighlightable >> recordElement: anElement [
	anElement attributes at: #originalColor put: (anElement trachelShape color)

]
