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
				moveTo: -0.5 @ -0.5;
				lineTo: 0.5 @ -0.5;
				lineTo: 0.5 @ 0.5;
				lineTo: -0.5 @ 0.5;
				lineTo: -0.5 @ -0.5 ]
]

{ #category : #testing }
TRBoxShape >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
	^ rectangle containsPoint: invertedPoint.
]
