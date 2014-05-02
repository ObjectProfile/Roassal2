Class {
	#name : #RTGDShapedElementB,
	#superclass : #RTGDElement,
	#instVars : [
		'shape'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #accessing }
RTGDShapedElementB >> color: aColorOrABlock [

	shape color: aColorOrABlock
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
