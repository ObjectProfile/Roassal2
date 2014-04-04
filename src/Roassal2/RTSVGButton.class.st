Class {
	#name : #RTSVGButton,
	#superclass : #RTSVGInteraction,
	#instVars : [
		'name'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGButton >> addEventHandlers: aStream id: aString element: element center: aNumber [
	aStream
		nextPutAll: self name,' '
]

{ #category : #'as yet unclassified' }
RTSVGButton >> addFunctions: aStream [
	"working on it"
]

{ #category : #adding }
RTSVGButton >> addGlobalHandlers: aStream [
	"do nothing"
]

{ #category : #initialization }
RTSVGButton >> initialize [
	super initialize.
	contained := true.
	external := false.
	self type: 'button'.
]
