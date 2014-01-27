"
Simon is an electronic game that intensively use arcs:
http://en.wikipedia.org/wiki/Simon_(game)

A RTSimon is xxxxxxxxx.

"
Class {
	#name : #RTSimon,
	#superclass : #RTBuilder,
	#instVars : [
		'models'
	],
	#category : #'Roassal2-Builder-Simon'
}

{ #category : #'as yet unclassified' }
RTSimon >> initialize [
	super initialize.
	self initializeShapeBuilder.
	self initializeInteractionBuilder.
	models := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTSimon >> initializeInteractionBuilder [
	self interaction popup.
]

{ #category : #'as yet unclassified' }
RTSimon >> initializeShapeBuilder [
	self shape arc  
		outerAngle: [ :object | ((self models indexOf: object) - 1) * (360.0 / self models size) ] innerAngle: [ :object | 360.0 / self models size ];
		innerRadius: 50;
		externalRadius: 90;
		color: RTNIdentityNormalizer new
]

{ #category : #'as yet unclassified' }
RTSimon >> models [
	^ models
]

{ #category : #'as yet unclassified' }
RTSimon >> models: objects [
	| elements |
	self recordModels: objects.
	elements := shapeBuilder elementsOn: objects.
	interactionBuilder setUpElements: elements.
	view addAll: elements
]

{ #category : #'as yet unclassified' }
RTSimon >> open [
	^ view canvas open
]

{ #category : #'as yet unclassified' }
RTSimon >> recordModels: objects [
	models addAll: objects
]
