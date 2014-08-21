Class {
	#name : #RTDirectLayoutTranslator,
	#superclass : #RTLayoutTranslator,
	#category : 'Roassal2-Layouts'
}

{ #category : #'as yet unclassified' }
RTDirectLayoutTranslator class >> isDefault [
	^ true
]

{ #category : #'as yet unclassified' }
RTDirectLayoutTranslator >> translate: element to: newPosition [
	element translateTo: newPosition
]
