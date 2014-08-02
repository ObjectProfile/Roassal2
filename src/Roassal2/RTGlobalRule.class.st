Class {
	#name : #RTGlobalRule,
	#superclass : #RTObject,
	#instVars : [
		'view'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'as yet unclassified' }
RTGlobalRule >> distinctColor [
	| normalizer |
	normalizer := RTMultiLinearColorForIdentity new objects: view elements.
	view elements do: [ :el | el trachelShape color: (normalizer rtValue: el) ]
]

{ #category : #'as yet unclassified' }
RTGlobalRule >> labelled [
	^ self labelledIf: true
]

{ #category : #'as yet unclassified' }
RTGlobalRule >> labelledIf: aBlock [
	view elements do: [ :el | (aBlock rtValue: el model) ifTrue: [ el @ RTLabelled ] ]
]

{ #category : #'as yet unclassified' }
RTGlobalRule >> view: aView [
	view := aView
]
