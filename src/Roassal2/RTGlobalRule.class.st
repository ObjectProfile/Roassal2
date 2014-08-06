Class {
	#name : #RTGlobalRule,
	#superclass : #RTObject,
	#instVars : [
		'elements'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #public }
RTGlobalRule >> distinctColor [
	| normalizer |
	normalizer := RTMultiLinearColorForIdentity new objects: elements.
	elements do: [ :el | el trachelShape color: (normalizer rtValue: el) ]
]

{ #category : #accessing }
RTGlobalRule >> elements: someElements [
	elements := someElements
]

{ #category : #shapes }
RTGlobalRule >> labelled [
	^ self labelledIf: true
]

{ #category : #public }
RTGlobalRule >> labelledIf: aBlock [
	elements do: [ :el | (aBlock rtValue: el model) ifTrue: [ el @ RTLabelled ] ]
]

{ #category : #accessing }
RTGlobalRule >> view: aView [
	self elements: aView elements
]
