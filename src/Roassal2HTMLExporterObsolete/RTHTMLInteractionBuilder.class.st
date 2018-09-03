"
A RTHTMLInteractionBuilder is a wrapper class designed to avoid the direct use of the RTSVGInteraction on the RTHTMLBuilder.
"
Class {
	#name : #RTHTMLInteractionBuilder,
	#superclass : #RTObject,
	#instVars : [
		'rawInteractions',
		'interactions'
	],
	#category : #Roassal2HTMLExporterObsolete
}

{ #category : #public }
RTHTMLInteractionBuilder >> draggable [
	rawInteractions add: [ :e | RTSVGDragAndDrop new target: e; yourself ]
]

{ #category : #public }
RTHTMLInteractionBuilder >> highlightColored: aColorOrAOneArgBlockOrSymbol [
	| color |
	color := [ :e |aColorOrAOneArgBlockOrSymbol rtValue: e model].
	rawInteractions add: [ :e | RTSVGHightlight new target: e; color: (color value: e); yourself ]
]

{ #category : #public }
RTHTMLInteractionBuilder >> hightlight [
	rawInteractions add: [ :e | RTSVGHightlight new target: e; color: Color blue; yourself ]
]

{ #category : #initialization }
RTHTMLInteractionBuilder >> initialize [
	super initialize.
	self initializeInteractions.
]

{ #category : #initialization }
RTHTMLInteractionBuilder >> initializeInteractions [
	rawInteractions := OrderedCollection new.
	interactions := Dictionary new
]

{ #category : #public }
RTHTMLInteractionBuilder >> noInteractions [
	self initializeInteractions.
]

{ #category : #public }
RTHTMLInteractionBuilder >> popup [
	| text |
	text := [ :e | e model asString ].
	rawInteractions add: [ :e | RTSVGTextPopup new target: e; text: (text value: e); yourself]
]

{ #category : #copying }
RTHTMLInteractionBuilder >> postCopy [
	super postCopy.
	interactions := interactions copy.
]

{ #category : #building }
RTHTMLInteractionBuilder >> setUpElements: elements [
	elements do: [ :e |  interactions at: e put: (rawInteractions collect: [ :ri | ri value: e]) ]
]
