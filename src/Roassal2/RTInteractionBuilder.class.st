Class {
	#name : #RTInteractionBuilder,
	#superclass : #RTAbstractBuilder,
	#instVars : [
		'interactions'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #public }
RTInteractionBuilder >> action: aBlockOrSymbol [
	"Add a new action, the argument is taken from the argument"
	^ self item: aBlockOrSymbol action: aBlockOrSymbol
]

{ #category : #'private-adding' }
RTInteractionBuilder >> addExclusiveInteraction: anInteraction [
	"We only keep all the interaction that have a different class"
	interactions := interactions select: [ :i | i class ~~ anInteraction class ].
	self addInteraction: anInteraction
]

{ #category : #'private-adding' }
RTInteractionBuilder >> addInteraction: anInteraction [
	interactions add: anInteraction
]

{ #category : #public }
RTInteractionBuilder >> decoration [
	| i |
	i := RTDecoration new.
	interactions add: i. 
	^ i
]

{ #category : #public }
RTInteractionBuilder >> draggable [
	| i |
	i := RTDraggable new.
	interactions add: i. 
	^ i
]

{ #category : #'events-registering' }
RTInteractionBuilder >> fixedPopupText: aBlock [
	self addExclusiveInteraction: (RTFixedPopup new text: aBlock)
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

{ #category : #'events-registering' }
RTInteractionBuilder >> highlightElements: elementsOrABlock [
	"Highlight the elements, elementsOrABlock may either be a block (which takes as argument the selected element and return a list of elements"
	interactions add: [ :element | element @ (RTHighlightable highlightElements: (elementsOrABlock rtValue: element model)) ]
]

{ #category : #'events-registering' }
RTInteractionBuilder >> highlightNeighbour: aBlock [
	"Highlight the elements for which the model is given by 'aBlock rtValue: element', where 'element' is the current element"
	interactions add: [ :element | element @ (RTHighlightable highlight: aBlock) ]
]

{ #category : #'events-registering' }
RTInteractionBuilder >> highlightNeighbour: aBlock color: aColorOrABlock [
	"Highlight the elements for which the model is given by 'aBlock rtValue: element', where 'element' is the current element"
	interactions add: [ :element | element @ (RTHighlightable new 
																highlightedColor: aColorOrABlock; 
																highlight: aBlock) ]
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
RTInteractionBuilder >> item: aTitle action: aBlockOrSymbol [
	interactions add: [ :element | element @ (RTMenuActivable new item: aTitle asString action: [ aBlockOrSymbol rtValue: element model ]) ]
]

{ #category : #public }
RTInteractionBuilder >> menu [
	| i |
	i := RTMenuActivable new.
	interactions add: i. 
	^ i
]

{ #category : #'morphic specific' }
RTInteractionBuilder >> menu: aSymbolOrBlockOrMenu [
	"the argument has to return a menu morph, when evaluated against the object"
	interactions add: [ :element | element when: TRMouseRightClick do: [ :evt | (aSymbolOrBlockOrMenu rtValue: evt element model) popUpInWorld ] ]

]

{ #category : #public }
RTInteractionBuilder >> noInteractions [
	self initializeInteractions.
]

{ #category : #'accessing - computed' }
RTInteractionBuilder >> numberOfMenuEntries [
	^ interactions size
]

{ #category : #public }
RTInteractionBuilder >> popup [
	"Return a new popup, which is set in the builder"
	| i |
	i := RTPopup new.
	self addExclusiveInteraction: i. 
	^ i
]

{ #category : #'events-registering' }
RTInteractionBuilder >> popupText [
	self popupText: #yourself
]

{ #category : #'events-registering' }
RTInteractionBuilder >> popupText: aBlock [
	^ self popup text: aBlock
	"| i |
	i := RTPopup new text: aBlock.
	self addExclusiveInteraction: i. 
	^ i"
]

{ #category : #'events-registering' }
RTInteractionBuilder >> popupText: aBlock color: aColorBlock [
	self addExclusiveInteraction: (RTPopup new text: aBlock; textColor: aColorBlock)
]

{ #category : #'events-registering' }
RTInteractionBuilder >> popupTextColor: aColorBlock [
	self popupText: #yourself color: aColorBlock
]

{ #category : #'events-registering' }
RTInteractionBuilder >> popupView: aTwoArgBlock [
	"aTwoArgBlock has to follow the pattern [ :group :element |  ... ]
	group is an empty group. You need to add what you want to be displayed in the popup. el is the element on which the mouse is above."
	self addExclusiveInteraction: (RTPopup new background: (Color blue alpha: 0.6) group: aTwoArgBlock)
]

{ #category : #copying }
RTInteractionBuilder >> postCopy [
	"Do we really need this method?"
	super postCopy.
	interactions := interactions copy.
]

{ #category : #building }
RTInteractionBuilder >> setUpElement: elementOrGroup [
	"elements is an RTGroup, that contains RTElement or RTEdges"
	
	interactions do: [ :int | elementOrGroup @ int ]
]

{ #category : #building }
RTInteractionBuilder >> setUpElements: elements [
	"elements is an RTGroup, that contains RTElement or RTEdges"
	interactions do: [ :int | elements @ int ]
]

{ #category : #public }
RTInteractionBuilder >> showEdge [
	| i |
	i := RTShowEdge new.
	interactions add: i. 
	^ i
]

{ #category : #'events-registering' }
RTInteractionBuilder >> when: event do: block [
	self addInteraction: [ :element | element when: event do: block ]
]
