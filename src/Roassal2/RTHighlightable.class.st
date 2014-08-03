Class {
	#name : #RTHighlightable,
	#superclass : #RTInteraction,
	#instVars : [
		'highlightElements'
	],
	#classInstVars : [
		'lastHighlightedElements',
		'lastColor'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTHighlightable class >> allSibblings [

	^ self highlightElements: [ :el | el view elements select: [ :e | e model == el model ] ]
]

{ #category : #public }
RTHighlightable class >> highlight: aBlock [
	"aBlock return an element or a list of elements to highlight"
	^ self new highlight: aBlock
]

{ #category : #public }
RTHighlightable class >> highlightElements: aBlock [
	"aBlock return an element or a list of elements to highlight"
	^ self new highlightElements: aBlock
]

{ #category : #'reset shape' }
RTHighlightable class >> highlightedColor [
	^ Color blue
]

{ #category : #'reset shape' }
RTHighlightable class >> lastHighlightedElements [
	^ lastHighlightedElements
]

{ #category : #'reset shape' }
RTHighlightable class >> lastHighlightedElements: elements [
	lastHighlightedElements := elements
]

{ #category : #actions }
RTHighlightable >> doHighlight: element [
	| t |
	self unhighlightRecordedElements.

	t := (highlightElements rtValue: element).
	t := t copyWithout: nil.
	t do: [ :el |
		self recordElement: el.
		el trachelShape color: self highlightedColor ].
	element attributes at: #highlightedElements put: t.
	self class lastHighlightedElements: t
]

{ #category : #actions }
RTHighlightable >> doUnhighlight: element [
	(element attributes includesKey: #highlightedElements)
		ifFalse: [ ^ self ].

	(element attributes at: #highlightedElements) do: [ :el |
		self unhighlightRecordedElement: el ].

	element attributes removeKey: #highlightedElements
]

{ #category : #public }
RTHighlightable >> highlight: aBlock [
	"aBlock return an object or a list of objects to highlight"
	highlightElements := [ :el | 
		| objects |
		objects := aBlock rtValue: el model.
		(objects collect: [ :o | el view elementFromModel: o ]) copyWithout: nil
		]
]

{ #category : #public }
RTHighlightable >> highlightElements: aBlock [
	"aBlock return an element or a list of elements to highlight"
	highlightElements := aBlock
]

{ #category : #configuration }
RTHighlightable >> highlightedColor [
	^ self class highlightedColor
]

{ #category : #initialize }
RTHighlightable >> initialize [
	super initialize.
	self highlightElements: [ :el | Array with: el ]
]

{ #category : #hooks }
RTHighlightable >> initializeElement: element [
	element
		when: TRMouseEnter
		do: [ :e | 
			self doHighlight: element.
			e signalUpdate ].
	element
		when: TRMouseLeave
		do: [ :e | 
			self doUnhighlight: element.
			e signalUpdate ]
]

{ #category : #actions }
RTHighlightable >> recordElement: anElement [
	anElement attributes at: #originalColor put: (anElement trachelShape color)

]

{ #category : #actions }
RTHighlightable >> unhighlightRecordedElement: anElement [
	(anElement attributes includesKey: #originalColor)
		ifFalse: [ ^ self ].
	anElement trachelShape color: (anElement attributes at: #originalColor).
	anElement attributes removeKey: #originalColor
]

{ #category : #actions }
RTHighlightable >> unhighlightRecordedElements [
	self class lastHighlightedElements ifNil: [ ^ self ].
	self class lastHighlightedElements do: [ :el | self unhighlightRecordedElement: el ].
	self class lastHighlightedElements: nil
]
