Class {
	#name : #RTMenuActivable,
	#superclass : #RTInteraction,
	#instVars : [
		'actions'
	],
	#category : #'Roassal2-Core'
}

{ #category : #initialization }
RTMenuActivable >> initialize [ 
	super initialize.
	actions := OrderedCollection new.
	
]

{ #category : #hooks }
RTMenuActivable >> initializeElement: element [
	element on: TRMouseRightClick do: [ :event |
		TRUtil instance widgetFactory menuForAssociations: actions on: element
	]
]

{ #category : #public }
RTMenuActivable >> item: titleAsString action: aBlockOrSymbol [
	actions add: (titleAsString -> aBlockOrSymbol)
]
