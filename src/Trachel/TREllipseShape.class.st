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

{ #category : #testing }
TREllipseShape >> includesPoint: aPoint [
	"Implementation is taken over from EllipseMorph>>containsPoint:"
	| invertedPoint radius other delta xOverY |
	invertedPoint := matrix inverseTransform: aPoint.
	(rectangle containsPoint: invertedPoint) ifFalse: [ ^ false ]. "quick elimination"
	radius := rectangle height asFloat / 2.
	other := rectangle width asFloat / 2.
	delta := invertedPoint - rectangle topLeft - (other@radius).
	xOverY := rectangle width asFloat / rectangle height asFloat.
	^ (delta x asFloat / xOverY) squared + delta y squared <= radius squared
]
