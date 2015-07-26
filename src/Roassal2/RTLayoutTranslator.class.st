Class {
	#name : #RTLayoutTranslator,
	#superclass : #RTObject,
	#instVars : [
		'view'
	],
	#classInstVars : [
		'defaultTranslator'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #accessing }
RTLayoutTranslator class >> default [
	"Return the default translator, the one used in the layouts"

	defaultTranslator ifNotNil: [ ^ defaultTranslator ].
	^ defaultTranslator := self defaultClass new
]

{ #category : #accessing }
RTLayoutTranslator class >> defaultClass [
	^ self allSubclasses detect: #isDefault
]

{ #category : #'as yet unclassified' }
RTLayoutTranslator class >> isDefault [
	^ false
]

{ #category : #accessing }
RTLayoutTranslator >> nbCycles: anInteger [
	"Do nothing"
]

{ #category : #hook }
RTLayoutTranslator >> translate: element by: deltaPosition [
	"Translate of the center of the element by a step"
	self translate: element to: element position + deltaPosition
]

{ #category : #hook }
RTLayoutTranslator >> translate: element to: newPosition [
	"Translate of the center of the element"
	self subclassResponsibility 
]

{ #category : #accessing }
RTLayoutTranslator >> view [
	^ view
]

{ #category : #accessing }
RTLayoutTranslator >> view: aView [
	view := aView
]
