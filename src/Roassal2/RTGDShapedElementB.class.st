Class {
	#name : #RTGDShapedElementB,
	#superclass : #RTGDElement,
	#instVars : [
		'shape',
		'seed'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #accessing }
RTGDShapedElementB >> color: aColorOrABlock [

	shape color: aColorOrABlock
]

{ #category : #testing }
RTGDShapedElementB >> hasSeed [
	^ seed notNil
]

{ #category : #accessing }
RTGDShapedElementB >> seed [ 
	seed ifNotNil: [ ^ seed ].
	^ graphBuilder view elements collect: #model
]

{ #category : #accessing }
RTGDShapedElementB >> seed: objects [
	seed := objects
]

{ #category : #accessing }
RTGDShapedElementB >> shape [
	^ shape
]

{ #category : #accessing }
RTGDShapedElementB >> shape: aShape [
	shape := aShape.
	^ aShape
]
