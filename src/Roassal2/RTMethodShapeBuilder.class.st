"
I am a class to buld more ease some interactions for RTUMLClassBuilder, see RTUMLClassBuilder examples
"
Class {
	#name : #RTMethodShapeBuilder,
	#superclass : #RTShapeBuilder,
	#instVars : [
		'properties'
	],
	#category : #'Roassal2-Builder-UML'
}

{ #category : #shapes }
RTMethodShapeBuilder >> if: conditionBlock color: colorBlock [
	| oldBlockOrValue |
	oldBlockOrValue := self color.
	^self color: [ :aModel | (conditionBlock rtValue: aModel)
									ifTrue: [ colorBlock rtValue: aModel ] 
									ifFalse: [ 
										oldBlockOrValue rtValue: (RTElement on: aModel) ]].
							
						
]
