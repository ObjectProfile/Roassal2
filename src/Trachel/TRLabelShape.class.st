Class {
	#name : #TRLabelShape,
	#superclass : #TRAbstractBoxShape,
	#instVars : [
		'text',
		'position'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRLabelShape >> drawOn: athensCanvas [
	| font |
	font := LogicalFont familyName: 'Arial' pointSize: 20.
 
	athensCanvas pathTransform restoreAfter: [
		athensCanvas pathTransform 
			translateBy: position;
			scaleBy: 2.
		athensCanvas setFont: font.
		athensCanvas setPaint: Color black.
		athensCanvas drawString: text
		]
]

{ #category : #'as yet unclassified' }
TRLabelShape >> initialize [
	super initialize.
	position := 0 @ 0.
	text := 'Trachel label'
]

{ #category : #'as yet unclassified' }
TRLabelShape >> text: aText on: aPosition [
	text := aText.
	position := aPosition
]
