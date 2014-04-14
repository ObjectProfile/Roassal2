Class {
	#name : #RTGDElement,
	#superclass : #RTObject,
	#instVars : [
		'graphBuilder',
		'properties'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDElement >> addProperty: aOneOrTwoArgBlock [
	properties add: aOneOrTwoArgBlock
]

{ #category : #accessing }
RTGDElement >> graphBuilder [
	^ graphBuilder
]

{ #category : #accessing }
RTGDElement >> graphBuilder: anObject [
	graphBuilder := anObject
]

{ #category : #'as yet unclassified' }
RTGDElement >> initialize [
	super initialize.
	properties := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTGDElement >> initializePropertiesOn: anElementOrAnEdge [

	properties do: [ :aBlock | aBlock value: anElementOrAnEdge ]
]
