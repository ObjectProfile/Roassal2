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
						ccwArcTo: 0 @ 0.5 angle: 90 degreesToRadians ].
	
]

{ #category : #testing }
TREllipseShape >> includesPoint: aPoint [
	"Implementation is taken over from EllipseMorph>>containsPoint:"
	| invertedPoint radius other delta xOverY t1 t2 |
	invertedPoint := matrix inverseTransform: aPoint.
	(rectangle containsPoint: invertedPoint) ifFalse: [ ^ false ]. "quick elimination"
	radius := rectangle height asFloat / 2.
	other := rectangle width asFloat / 2.
	delta := invertedPoint - rectangle topLeft - (other@radius).
	xOverY := rectangle width asFloat / rectangle height asFloat.
	t1 := (delta x asFloat / xOverY) squared + delta y squared.
	t2 := radius squared.
	^ (t1 < t2)  or: [ t1 closeTo: t2 ].
]

{ #category : #drawing }
TREllipseShape >> preDrawOn: athensCanvas [
	athensCanvas pathTransform
		scaleBy: rectangle extent asFloatPoint
]

{ #category : #hooks }
TREllipseShape >> strokeWidth [
	^ 0.005
]
