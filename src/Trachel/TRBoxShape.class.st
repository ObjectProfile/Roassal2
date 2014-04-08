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
				moveTo: -1 @ -1;
				lineTo: 1 @ -1;
				lineTo: 1 @ 1;
				lineTo: -1 @ 1;
				lineTo: -1 @ -1. ]
]

{ #category : #testing }
TRBoxShape >> includesPoint: aPoint [
	| newPoint |
	Transcript show: aPoint; cr.
	newPoint := matrix inverseTransform: aPoint.
	^ rectangle containsPoint: newPoint.
]
