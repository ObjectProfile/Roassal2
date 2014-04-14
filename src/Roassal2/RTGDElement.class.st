Class {
	#name : #RTGDElement,
	#superclass : #RTObject,
	#instVars : [
		'graphBuilder',
		'properties'
	],
	#category : #'Roassal2-Builder-Graph'
}

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
