Class {
	#name : #RTMenuActivable,
	#superclass : #RTInteraction,
	#instVars : [
		'actions'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTMenuActivable class >> action: anAction [

	^ self item: anAction asString action: anAction
]

{ #category : #public }
RTMenuActivable class >> item: title action: action [
	^ self new item: title action: action
]

{ #category : #public }
RTMenuActivable >> action: aSymbol [
	^ self item: aSymbol asString action: aSymbol
]

{ #category : #initialization }
RTMenuActivable >> initialize [ 
	super initialize.
	actions := OrderedCollection new.
	
]

{ #category : #hooks }
RTMenuActivable >> initializeElement: element [

	| menuActivable |
	(element hasInteraction: self class) ifFalse: [ ^ self initializeFirstTimeElement: element ].
	
	menuActivable := element getInteractionForClass: self class.
	actions do: [ :assoc |
		menuActivable item: assoc key action: assoc value ]
]

{ #category : #hooks }
RTMenuActivable >> initializeFirstTimeElement: element [
	element when: TRMouseRightClick do: [ :event |
		TRUtil instance widgetFactory menuForAssociations: actions on: element
	]
]

{ #category : #public }
RTMenuActivable >> item: titleAsString action: aBlockOrSymbol [
	actions add: (titleAsString -> aBlockOrSymbol)
]
