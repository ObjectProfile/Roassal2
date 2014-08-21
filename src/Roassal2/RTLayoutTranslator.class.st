Class {
	#name : #RTLayoutTranslator,
	#superclass : #RTObject,
	#instVars : [
		'view'
	],
	#classInstVars : [
		'defaultTranslator'
	],
	#category : 'Roassal2-Layouts'
}

{ #category : #'as yet unclassified' }
RTLayoutTranslator class >> default [
	"Return the default translator, the one used in the layouts"

	defaultTranslator ifNotNil: [ ^ defaultTranslator ].
	^ defaultTranslator := self defaultClass new
]

{ #category : #'as yet unclassified' }
RTLayoutTranslator class >> defaultClass [
	^ self allSubclasses detect: #isDefault
]

{ #category : #accessing }
RTLayoutTranslator >> nbCycles: anInteger [
	"Do nothing"
]

{ #category : #hook }
RTLayoutTranslator >> translate: element to: newPosition [
	"Translate of the center of the element"
	self subclassResponsibility 
]

{ #category : #hook }
RTLayoutTranslator >> translateBottomLeftOf: element to: newPosition [
	"Translate the top left corner of the element"
	self translate: element to: (newPosition + (0 @ (element height / -2)))
]

{ #category : #hook }
RTLayoutTranslator >> translateCenterLeftOf: element to: newPosition [
	"Translate the top left corner of the element"
	self translate: element to: (newPosition "+ ((element width / 2) @ 0)")
]

{ #category : #hook }
RTLayoutTranslator >> translateTopLeftOf: element to: newPosition [
	"Translate the top left corner of the element"
	self translate: element to: (newPosition + (element extent / 2))
]

{ #category : #accessing }
RTLayoutTranslator >> view [
	^ view
]

{ #category : #accessing }
RTLayoutTranslator >> view: anObject [
	view := anObject
]
