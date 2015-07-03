"
A RTHighlightable changes color of elements which should be highlighted.

"
Class {
	#name : #RTHighlightable,
	#superclass : #RTAbstractHighlightable,
	#instVars : [
		'color'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'reset shape' }
RTHighlightable class >> highlightedColor [
	^ Color blue
]

{ #category : #visitor }
RTHighlightable >> accept: aVisitor with: args [
	aVisitor visitHightlightableInteraction: self with: args.
]

{ #category : #actions }
RTHighlightable >> doHighlightElement: anElement [
	| v |
	self recordElement: anElement.	"not sure if we need to return something"
	v := anElement trachelShape color: (self highlightColorFor: anElement).
	anElement view ifNotNil: [ anElement view signalUpdate ].
	^ v
]

{ #category : #actions }
RTHighlightable >> doUnhighlightElement: anElement [
	(anElement attributes includesKey: #originalColor)
		ifFalse: [ ^ self ].
	anElement trachelShape color: (anElement attributes at: #originalColor).
	anElement attributes removeKey: #originalColor.
	anElement view ifNotNil: [ anElement view signalUpdate ].
	
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
	color := aColorOrABlock
]

{ #category : #initialize }
RTHighlightable >> initialize [
	super initialize.
	color := self class highlightedColor
]

{ #category : #actions }
RTHighlightable >> recordElement: anElement [
	(anElement attributes includesKey: #originalColor) ifTrue: [ ^ self ].
	anElement attributes at: #originalColor put: (anElement trachelShape color)

]
