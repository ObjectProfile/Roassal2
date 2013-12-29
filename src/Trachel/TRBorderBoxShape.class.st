Class {
	#name : #TRBorderBoxShape,
	#superclass : #TRAbstractBoxShape,
	#category : #Trachel
}

{ #category : #drawing }
TRBorderBoxShape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [
"		athensCanvas pathTransform 
			translateBy: position.
"
		athensCanvas
			setStrokePaint: strokePaint;
			drawShape: self path ]
]
