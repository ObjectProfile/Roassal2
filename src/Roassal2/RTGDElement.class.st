Class {
	#name : #RTGDElement,
	#superclass : #RTObject,
	#instVars : [
		'graphBuilder'
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
