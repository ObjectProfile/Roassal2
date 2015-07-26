"
A RTAbstractHighlightable is an highlight mechanism of an element or group of elements. It trigger highlight on mouse enter and reset the highlight on mouse leave. By default it highlight the element itself, but by methods #highlight: and #highlightElements: any other element can be highlighted.

Instance Variables
	highlightElements:		<BlockClosure>

highlightElements
	- it is one argument block (o any object which understand #rtValue:) which returns collection of elements. Those element are then highlighted.

"
Class {
	#name : #RTAbstractHighlightable,
	#superclass : #RTInteraction,
	#instVars : [
		'highlightElements'
	],
	#classInstVars : [
		'lastHighlightedElements',
		'lastColor'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #public }
RTAbstractHighlightable class >> allSibblings [

	^ self highlightElements: [ :el | el view elements select: [ :e | e model notNil and: [ e model == el model ]] ]
]

{ #category : #public }
RTAbstractHighlightable class >> highlight: aBlock [
	"aBlock return an element or a list of elements to highlight"
	^ self new highlight: aBlock
]

{ #category : #public }
RTAbstractHighlightable class >> highlightElements: aBlock [
	"aBlock return an element or a list of elements to highlight"
	^ self new highlightElements: aBlock
]

{ #category : #'reset shape' }
RTAbstractHighlightable class >> lastHighlightedElements [
	^ lastHighlightedElements
]

{ #category : #'reset shape' }
RTAbstractHighlightable class >> lastHighlightedElements: elements [
	lastHighlightedElements 
		ifNil: [ lastHighlightedElements := elements ]
		ifNotNil: [ lastHighlightedElements := lastHighlightedElements, elements ].
	
]

{ #category : #'reset shape' }
RTAbstractHighlightable class >> resetHighlightedElements [
	lastHighlightedElements := nil.
]

{ #category : #private }
RTAbstractHighlightable >> attributeIdentificator [
	^ self className asSymbol
]

{ #category : #actions }
RTAbstractHighlightable >> doHighlight: element [
	| elements |
	"self unhighlightRecordedElements."
	elements := highlightElements rtValue: element.
	elements := elements copyWithout: nil.
	elements do: [ :eachElement | self doHighlightElement: eachElement ].
	element attributes at: self attributeIdentificator put: elements.
	self class lastHighlightedElements: elements
]

{ #category : #actions }
RTAbstractHighlightable >> doHighlightElement: anElement [
	self subclassResponsibility
]

{ #category : #actions }
RTAbstractHighlightable >> doUnhighlight: element [
	self unhighlightRecordedElements.
	(element hasAttribute: self attributeIdentificator)
		ifFalse: [ ^ self ].
	(element attributeAt: self attributeIdentificator) 
		do: [ :el | self doUnhighlightElement: el ].
	element removeAttributeAt: self attributeIdentificator.
	
]

{ #category : #actions }
RTAbstractHighlightable >> doUnhighlightElement: anElement [
	self subclassResponsibility
]

{ #category : #public }
RTAbstractHighlightable >> highlight: aBlock [
	"aBlock return an object or a list of objects to highlight"
	highlightElements := [ :el | 
		| objects |
		objects := aBlock rtValue: el model.
		(objects collect: [ :o | el view elementFromModel: o ]) copyWithout: nil
		]
]

{ #category : #public }
RTAbstractHighlightable >> highlightElements: aBlock [
	"aBlock return an element or a list of elements to highlight"
	highlightElements := aBlock
]

{ #category : #initialize }
RTAbstractHighlightable >> initialize [
	super initialize.
	self highlightElements: [ :el | Array with: el ]
]

{ #category : #hooks }
RTAbstractHighlightable >> initializeElement: element [
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
RTAbstractHighlightable >> unhighlightRecordedElements [
	self class lastHighlightedElements ifNil: [ ^ self ].
	self class lastHighlightedElements do: [ :el | self doUnhighlightElement: el ].
	self class resetHighlightedElements.
]
