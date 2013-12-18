Class {
	#name : #TRBorderBoxShape,
	#superclass : #TRAbstractBoxShape,
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRBorderBoxShape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [
		athensCanvas pathTransform 
			translateBy: position.

		athensCanvas
			setStrokePaint: strokePaint;
			drawShape: path ]
]
