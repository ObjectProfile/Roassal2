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
