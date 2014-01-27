Class {
	#name : #RTHighlightable,
	#superclass : #RTInteraction,
	#classInstVars : [
		'lastHighlightedShape',
		'lastColor'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTHighlightable class >> highlightedColor [
	^ Color blue
]

{ #category : #'as yet unclassified' }
RTHighlightable class >> lastColor [
	^ lastColor
]

{ #category : #'as yet unclassified' }
RTHighlightable class >> lastColor: aColor [
	lastColor := aColor
]

{ #category : #'as yet unclassified' }
RTHighlightable class >> lastHighlightedShape [
	^ lastHighlightedShape
]

{ #category : #'as yet unclassified' }
RTHighlightable class >> lastHighlightedShape: aTrachelShape [
	lastHighlightedShape := aTrachelShape
]

{ #category : #configuration }
RTHighlightable >> highlightedColor [
	^ self class highlightedColor
]

{ #category : #hooks }
RTHighlightable >> initializeElement: element [
	element
		on: TRMouseEnter
		do: [ :e | 
			self unhighlightRecordedShape.
			self recordShape: element shape.
			element shape color: self highlightedColor.
			e signalUpdate ].
	element
		on: TRMouseLeave
		do: [ :e | 
			self unhighlightRecordedShape.
			e signalUpdate ]
]

{ #category : #'as yet unclassified' }
RTHighlightable >> recordShape: aShape [
	self class lastHighlightedShape: aShape.
	self class lastColor: aShape color

]

{ #category : #'as yet unclassified' }
RTHighlightable >> unhighlightRecordedShape [
	self class lastHighlightedShape isNil ifTrue: [ ^ self ].
	self class lastHighlightedShape color: self class lastColor.
	self class lastHighlightedShape: nil
]
