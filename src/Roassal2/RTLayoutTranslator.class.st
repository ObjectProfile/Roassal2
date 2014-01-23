Class {
	#name : #RTLayoutTranslator,
	#superclass : #RTObject,
	#classInstVars : [
		'defaultTranslator'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #'as yet unclassified' }
RTLayoutTranslator class >> default [
	"Return the default translator, the one used in the layouts"

	defaultTranslator ifNotNil: [ ^ defaultTranslator ].
	^ defaultTranslator := self defaultClass new
]

{ #category : #'as yet unclassified' }
RTLayoutTranslator class >> defaultClass [
	^ self withAllSubclasses detect: #isDefault
]

{ #category : #'as yet unclassified' }
RTLayoutTranslator >> nbCycles: anInteger [
	"Do nothing"
]

{ #category : #'as yet unclassified' }
RTLayoutTranslator >> translate: element to: newPosition [
	self subclassResponsibility 
]
