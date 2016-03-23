Class {
	#name : #RTAbstractMenuEntry,
	#superclass : #RTObject,
	#category : #'Roassal2-Plugins'
}

{ #category : #'world menu' }
RTAbstractMenuEntry class >> menuConfigurationEntryTitle [
	^ #'Plugin: '
]

{ #category : #'world menu' }
RTAbstractMenuEntry class >> menuConfigurationSymbol [
	^ #RoassalPlugin
]

{ #category : #'as yet unclassified' }
RTAbstractMenuEntry >> configurationMessage [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
RTAbstractMenuEntry >> description [
	^ self subclassResponsibility 
]

{ #category : #hooks }
RTAbstractMenuEntry >> execute [
	"Code to be executed"
	self subclassResponsibility
]

{ #category : #hooks }
RTAbstractMenuEntry >> label [
	"Menu entry"
	^ 'Need to define'
]

{ #category : #public }
RTAbstractMenuEntry >> run [
	| answer |
	answer := UIManager default
		confirm: self description
		label:
			self configurationMessage , self label , '?'.
	answer ifNil: [ ^ self ].
	answer
		ifTrue: [ self execute ]
]
