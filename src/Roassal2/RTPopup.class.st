Class {
	#name : #RTPopup,
	#superclass : #RTAbstractPopup,
	#instVars : [
		'text'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTPopup class >> text: aBlockOrSymbol [
	^ self new text: aBlockOrSymbol
]

{ #category : #hooks }
RTPopup >> createElementFor: element [
	| el labelShape |
	el := RTElement on: (text rtValue: element).
	labelShape := RTLabel new color: Color black. 
	el + labelShape.
	^ el
]

{ #category : #accessing }
RTPopup >> text: aOneArgBlock [
	^ self textElement: [ :e | aOneArgBlock rtValue: e model ]
]

{ #category : #accessing }
RTPopup >> textElement: aOneArgBlock [
	text := aOneArgBlock
]
