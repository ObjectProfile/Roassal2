Class {
	#name : #RTPopup,
	#superclass : #RTAbstractPopup,
	#instVars : [
		'text'
	],
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTPopup >> createElementFor: element [
	| el labelShape |
	el := RTElement on: (text roValue: element).
	labelShape := RTLabel new color: Color black. 
	el + labelShape.
	^ el
]

{ #category : #accessing }
RTPopup >> text: aOneArgBlock [
	^ self textElement: [ :e | aOneArgBlock roValue: e model ]
]

{ #category : #accessing }
RTPopup >> textElement: aOneArgBlock [
	text := aOneArgBlock
]
