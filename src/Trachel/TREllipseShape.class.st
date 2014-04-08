Class {
	#name : #TREllipseShape,
	#superclass : #TRAbstractBoxShape,
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TREllipseShape >> accept: aVisitor [
	aVisitor visitEllipseShape: self
]

{ #category : #hooks }
TREllipseShape >> computePath [
	canvas ifNil: [ ^ self ].
	path := self athensCanvas
				createPath: [ :builder | 
					builder
						absolute;
						moveTo: 0 @ 0.5;
						ccwArcTo: 0.5 @ 0.0 angle: 90 degreesToRadians;
						ccwArcTo: 0.0 @ -0.5 angle: 90 degreesToRadians;
						ccwArcTo: -0.5 @ 0.0 angle: 90 degreesToRadians;
						ccwArcTo: 0 @ 0.5 angle: 90 degreesToRadians ]
]

{ #category : #public }
TREllipseShape >> from: aPoint to: anotherPoint color: aColor [
	rectangle := aPoint corner: anotherPoint.
	self strokePaint: aColor.
	self color: aColor
]

{ #category : #testing }
TREllipseShape >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
	^ rectangle containsPoint: invertedPoint.
]

{ #category : #hooks }
TREllipseShape >> strokeWidth [
	^ 0.05
]
