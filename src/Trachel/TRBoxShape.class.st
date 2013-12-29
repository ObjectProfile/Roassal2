Class {
	#name : #TRBoxShape,
	#superclass : #TRAbstractBoxShape,
	#classInstVars : [
		'nullRectangle'
	],
	#category : #Trachel
}

{ #category : #drawing }
TRBoxShape >> drawOn: athensCanvas [
	super drawOn: athensCanvas
"	athensCanvas pathTransform restoreAfter: [
		athensCanvas pathTransform 
			translateBy: position.

		athensCanvas
			setPaint: color;
			drawShape: self path ]"
]
