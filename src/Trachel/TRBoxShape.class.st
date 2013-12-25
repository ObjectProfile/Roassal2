Class {
	#name : #TRBoxShape,
	#superclass : #TRAbstractBoxShape,
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRBoxShape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [
		athensCanvas pathTransform 
			translateBy: position.

		athensCanvas
			setPaint: color;
			drawShape: self path ]
]
