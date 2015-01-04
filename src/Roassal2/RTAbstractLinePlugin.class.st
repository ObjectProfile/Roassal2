Class {
	#name : #RTAbstractLinePlugin,
	#superclass : #RTAbstractGrapherPlugin,
	#instVars : [
		'values'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #adding }
RTAbstractLinePlugin >> add: aValue [
	values add: aValue
]

{ #category : #adding }
RTAbstractLinePlugin >> addAll: someValues [
	values addAll: someValues
]

{ #category : #initialization }
RTAbstractLinePlugin >> initialize [
	super initialize.
	values := OrderedCollection new.
]
