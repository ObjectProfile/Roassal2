Class {
	#name : #TRBorderBoxShape,
	#superclass : #TRAbstractBoxShape,
	#category : #Trachel
}

{ #category : #drawing }
TRBorderBoxShape >> drawOn: athensCanvas [
	self shouldBeDrawn ifFalse: [ ^ self ].
	athensCanvas pathTransform restoreAfter: [
		athensCanvas
			setStrokePaint: strokePaint;
			drawShape: self path ]
]
