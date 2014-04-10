Class {
	#name : #TRBoxShape,
	#superclass : #TRAbstractBoxShape,
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRBoxShape >> accept: aVisitor [
	aVisitor visitBoxShape: self
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
TRBoxShape >> includesPoint: aPoint [
	^ rectangle containsPoint: aPoint
]

{ #category : #'as yet unclassified' }
TRBoxShape >> translateBy: aPoint [
	super translateBy: aPoint.
	self resetPath
]

{ #category : #'as yet unclassified' }
TRBoxShape >> translateTo: aPoint [
	super translateTo: aPoint.
	self resetPath
]
