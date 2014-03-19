Class {
	#name : #RTHTMLInteraction,
	#superclass : #RTObject,
	#instVars : [
		'targets',
		'contained',
		'external'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #'as yet unclassified' }
RTHTMLInteraction class >> on: anHTMLExporter targets: aRTShape [
	|interaction|
	interaction := self new targets: aRTShape; yourself. 
	anHTMLExporter interactions add: interaction.
	^interaction
]

{ #category : #adding }
RTHTMLInteraction >> addEventHandlers: aStream id: aString element: aRTElement [
	self subclassResponsibility 
]

{ #category : #adding }
RTHTMLInteraction >> addFunctions: aStream [
	self subclassResponsibility
]

{ #category : #accessing }
RTHTMLInteraction >> contained [
	^contained
]

{ #category : #accessing }
RTHTMLInteraction >> external [
	^external
]

{ #category : #accessing }
RTHTMLInteraction >> targets [
	^ targets
]

{ #category : #accessing }
RTHTMLInteraction >> targets: anObject [
	targets := anObject
]
