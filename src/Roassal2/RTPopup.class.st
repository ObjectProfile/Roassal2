Class {
	#name : #RTPopup,
	#superclass : #RTAbstractPopup,
	#instVars : [
		'text'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTPopup >> createElementFor: element [
	| el |
	el := RTElement on: (text roValue: element).
	el + RTLabel.
	^ el
]

{ #category : #'as yet unclassified' }
RTPopup >> text: aOneArgBlock [
	^ self textElement: [ :e | aOneArgBlock roValue: e model ]
]

{ #category : #'as yet unclassified' }
RTPopup >> textElement: aOneArgBlock [
	^ text := aOneArgBlock
]
