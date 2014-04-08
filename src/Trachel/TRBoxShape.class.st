Class {
	#name : #TRBoxShape,
	#superclass : #TRAbstractBoxShape,
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRBoxShape >> accept: aVisitor [
	aVisitor visitBoxShape: self
]

{ #category : #hooks }
TRBoxShape >> computePath [
	canvas ifNil: [ ^ self ].
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: rectangle topLeft;
				lineTo: rectangle topRight;
				lineTo: rectangle bottomRight;
				lineTo: rectangle bottomLeft;
				lineTo: rectangle topLeft.
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
	athensCanvas pathTransform
		restoreAfter: [ 
			"athensCanvas pathTransform
				translateBy: rectangle center;
				scaleBy: rectangle extent / 2."
			athensCanvas
				setPaint: color;
				drawShape: self path.
			self drawStrokeIfNecessaryOn: athensCanvas ]
]

{ #category : #testing }
TRBoxShape >> includesPoint: aPoint [
	^ rectangle containsPoint: aPoint
]

{ #category : #actions }
TRBoxShape >> translateBy: aPoint [
	super translateBy: aPoint.
	self resetPath
]

{ #category : #actions }
TRBoxShape >> translateTo: aPoint [
	super translateTo: aPoint.
	self resetPath
]
