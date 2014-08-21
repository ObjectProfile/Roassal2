"
A RTShowLabel adds a label when highlight mechanism is triggered. It uses RTLabelled object for labelling.

Instance Variables
	labelledInteraction:		<RTLabelled>

labelledInteraction
	- an object which is responsible for creating and removing of a label

"
Class {
	#name : #RTShowLabel,
	#superclass : #RTAbstractHighlightable,
	#instVars : [
		'labelledInteraction'
	],
	#category : #'Roassal2-Core'
}

{ #category : #actions }
RTShowLabel >> doHighlightElement: anElement [ 
	anElement @ labelledInteraction.
]

{ #category : #actions }
RTShowLabel >> doUnhighlightElement: anElement [ 
	labelledInteraction removeLabelFrom: anElement.
]

{ #category : #'reflective operations' }
RTShowLabel >> doesNotUnderstand: aMessage [ 
	labelledInteraction 
		perform: aMessage selector 
		withArguments: aMessage arguments
]

{ #category : #initialize }
RTShowLabel >> initialize [
	super initialize.
	labelledInteraction := RTLabelled new.
]

{ #category : #accessing }
RTShowLabel >> labelledInteraction [
	^ labelledInteraction
]

{ #category : #accessing }
RTShowLabel >> labelledInteraction: aRTLabelled [
	labelledInteraction := aRTLabelled
]
