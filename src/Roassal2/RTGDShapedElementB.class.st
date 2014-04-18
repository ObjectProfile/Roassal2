Class {
	#name : #RTGDShapedElementB,
	#superclass : #RTGDElement,
	#instVars : [
		'shape'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDShapedElementB >> color: aColorOrABlock [

	shape color: aColorOrABlock
]

{ #category : #'as yet unclassified' }
RTGDShapedElementB >> shape [
	^ shape
]

{ #category : #'as yet unclassified' }
RTGDShapedElementB >> shape: aShape [
	shape := aShape.
	^ aShape
]
