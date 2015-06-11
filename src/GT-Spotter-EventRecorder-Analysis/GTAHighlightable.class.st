Class {
	#name : #GTAHighlightable,
	#superclass : #RTHighlightable,
	#instVars : [
		'initializeOnElement'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity'
}

{ #category : #'as yet unclassified' }
GTAHighlightable >> initializeElement: element [
	(initializeOnElement rtValue: element) ifFalse: [ ^ self ].
	super initializeElement: element
]

{ #category : #initialization }
GTAHighlightable >> initializeOn: aSymbolOrBlockOrObject [ 
	self initializeOnElement: [ :anElement | aSymbolOrBlockOrObject rtValue: anElement model ]
]

{ #category : #accessing }
GTAHighlightable >> initializeOnElement: aSymbolOrBlockOrObject [ 
	initializeOnElement := aSymbolOrBlockOrObject
]
