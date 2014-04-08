Class {
	#name : #TRBoxShape,
	#superclass : #TRAbstractBoxShape,
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRBoxShape >> accept: aVisitor [
	aVisitor visitBoxShape: self
]

{ #category : #private }
TRBoxShape >> computePath [
	canvas ifNil: [ ^ self ].
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: rectangle extent / -2;
				lineTo: (rectangle width / 2) @ (rectangle height / -2);
				lineTo: (rectangle width / 2) @ (rectangle height / 2);
				lineTo: (rectangle width / -2) @ (rectangle height / 2);
				lineTo: rectangle extent / -2.


"				moveTo: rectangle topLeft;
				lineTo: rectangle topRight;
				lineTo: rectangle bottomRight;
				lineTo: rectangle bottomLeft;
				lineTo: rectangle topLeft.
"				
				"moveTo: -1 @ -1;
				lineTo: 1 @ -1;
				lineTo: 1 @ 1;
				lineTo: -1 @ 1;
				lineTo: -1 @ -1" ]
]

{ #category : #drawing }
TRBoxShape >> drawOn: athensCanvas [
	self shouldBeDrawn
		ifFalse: [ ^ self ].
	self drawEncompassingRectangleOn: athensCanvas.
	athensCanvas pathTransform
		restoreAfter: [ 
			athensCanvas pathTransform
				multiplyBy: matrix.
				"translateBy: rectangle center;"
				"scaleBy: matrix sx @ matrix sy.."
			athensCanvas
				setPaint: color;
				drawShape: self path.
			self drawStrokeIfNecessaryOn: athensCanvas ]
]

{ #category : #testing }
TRBoxShape >> includesPoint: aPoint [
	| newPoint |
	Transcript show: aPoint; cr.
	newPoint := matrix inverseTransform: aPoint.
	^ rectangle containsPoint: newPoint.
]
