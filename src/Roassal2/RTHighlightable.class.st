Class {
	#name : #RTHighlightable,
	#superclass : #RTInteraction,
	#classInstVars : [
		'lastHighlightedShape',
		'lastColor'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'reset shape' }
RTHighlightable class >> highlightedColor [
	^ Color blue
]

{ #category : #'reset shape' }
RTHighlightable class >> lastColor [
	^ lastColor
]

{ #category : #'reset shape' }
RTHighlightable class >> lastColor: aColor [
	self assert: [ aColor notNil ].
	lastColor := aColor
]

{ #category : #'reset shape' }
RTHighlightable class >> lastHighlightedShape [
	^ lastHighlightedShape
]

{ #category : #'reset shape' }
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
		when: TRMouseEnter
		do: [ :e | 
			self unhighlightRecordedShape.
			self recordShape: element trachelShape.
			element trachelShape color: self highlightedColor.
			e signalUpdate ].
	element
		when: TRMouseLeave
		do: [ :e | 
			self unhighlightRecordedShape.
			e signalUpdate ]
]

{ #category : #actions }
RTHighlightable >> recordShape: aShape [
	self class lastHighlightedShape: aShape.
	self class lastColor: aShape color

]

{ #category : #actions }
RTHighlightable >> unhighlightRecordedShape [
	self class lastHighlightedShape isNil ifTrue: [ ^ self ].
	self class lastHighlightedShape color: self class lastColor.
	self class lastHighlightedShape: nil
]
