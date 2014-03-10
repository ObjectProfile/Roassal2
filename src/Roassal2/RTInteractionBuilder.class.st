Class {
	#name : #RTInteractionBuilder,
	#superclass : #RTObject,
	#instVars : [
		'interactions'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #public }
RTInteractionBuilder >> draggable [
	| i |
	i := RTDraggable new.
	interactions add: i. 
	^ i
]

{ #category : #public }
RTInteractionBuilder >> highlight [
	self highlightColored: Color blue
]

{ #category : #public }
RTInteractionBuilder >> highlightColored: aColorOrAOneArgBlockOrSymbol [
	
	self when: TRMouseEnter do: [ :event | 
		RTBlink 
			highlight: event element
			color: (aColorOrAOneArgBlockOrSymbol rtValue: event element model) ].

	self when: TRMouseLeave do: [ :event | 
		RTBlink
			unhighlight: event element ].
]

{ #category : #initialization }
RTInteractionBuilder >> initialize [
	super initialize.
	self initializeInteractions.
]

{ #category : #initialization }
RTInteractionBuilder >> initializeInteractions [
	interactions := OrderedCollection new
]

{ #category : #public }
RTInteractionBuilder >> menu [
	| i |
	i := RTMenuActivable new.
	interactions add: i. 
	^ i
]

{ #category : #public }
RTInteractionBuilder >> noInteractions [
	self initializeInteractions.
]

{ #category : #public }
RTInteractionBuilder >> popup [
	| i |
	i := RTPopup new.
	interactions add: i. 
	^ i
]

{ #category : #copying }
RTInteractionBuilder >> postCopy [
	super postCopy.
	interactions := interactions copy.
]

{ #category : #building }
RTInteractionBuilder >> setUpElements: elements [
	"elements is an RTGroup, that contains RTElement or RTEdges"
	
	interactions do: [ :int | elements @ int ]
]

{ #category : #'events-registering' }
RTInteractionBuilder >> when: event do: block [
	interactions add: [ :element | element when: event do: block ]
]
