Class {
	#name : #RTGDElement,
	#superclass : #RTObject,
	#instVars : [
		'graphBuilder',
		'properties',
		'condition'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #adding }
RTGDElement >> addProperty: aOneOrTwoArgBlock [
	properties add: aOneOrTwoArgBlock
]

{ #category : #'as yet unclassified' }
RTGDElement >> canCreateForObject: anObject [
	"Return true or false on whether I can create a Roassal element for the given argument"
	^ condition rtValue: anObject
]

{ #category : #accessing }
RTGDElement >> elementFromModel: anObject [
	^ self view elementFromModel: anObject
]

{ #category : #accessing }
RTGDElement >> elementsFromModels: anObject [
	^ self view elementsFromModels: anObject
]

{ #category : #accessing }
RTGDElement >> graphBuilder [
	^ graphBuilder
]

{ #category : #accessing }
RTGDElement >> graphBuilder: aGraphBuilder [
	graphBuilder := aGraphBuilder
]

{ #category : #'as yet unclassified' }
RTGDElement >> if: aCondition [
	condition := aCondition
]

{ #category : #initialization }
RTGDElement >> initialize [
	super initialize.
	properties := OrderedCollection new.
	condition := true
]

{ #category : #initialization }
RTGDElement >> initializePropertiesOn: anElementOrAnEdge [

	properties do: [ :aBlock | aBlock value: anElementOrAnEdge ]
]

{ #category : #accessing }
RTGDElement >> view [
	^ graphBuilder view
]
