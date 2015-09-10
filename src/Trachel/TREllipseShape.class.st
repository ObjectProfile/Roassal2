Class {
	#name : #TREllipseShape,
	#superclass : #TRAbstractBoxShape,
	#category : #'Trachel-Shapes'
}

{ #category : #hooks }
TREllipseShape class >> defaultStrokeWidth [
	^ 1
]

{ #category : #visitor }
TREllipseShape >> accept: aVisitor [
	aVisitor visitEllipseShape: self
]

{ #category : #hooks }
TREllipseShape >> computePath [
	| halfWidth halfHeight |
	canvas ifNil: [ ^ self ].
"	path := self athensCanvas
				createPath: [ :builder | 
					builder
						absolute;
						moveTo: 0 @ 0.5;
						ccwArcTo: 0.5 @ 0.0 angle: 90 degreesToRadians;
						ccwArcTo: 0.0 @ -0.5 angle: 90 degreesToRadians;
						ccwArcTo: -0.5 @ 0.0 angle: 90 degreesToRadians;
						ccwArcTo: 0 @ 0.5 angle: 90 degreesToRadians ].
	"
	"Inspired from EllipseMorph>>#drawOnAthensCanvas:
	Thanks Nicolai!"
	halfWidth := rectangle width / 2 asFloat.
	halfHeight := rectangle height / 2 asFloat.

	path := self athensCanvas
		createPath: [ :builder | 
					builder
					absolute;
				relative;
				moveTo: halfWidth negated @ 0;
				curveVia: 0 @ (halfHeight negated * 0.55)
					and: (0.45 * halfWidth) @ halfHeight negated
					to: halfWidth @ halfHeight negated;
				curveVia: (halfWidth * 0.55) @ 0 and: halfWidth @ (0.45 * halfHeight) to: halfWidth @ halfHeight;
				curveVia: 0 @ (halfHeight * 0.55) and: (0.45 * halfWidth negated) @ halfHeight to: halfWidth negated @ halfHeight;
				curveVia: (halfWidth negated * 0.55) @ 0
					and: halfWidth negated @ (halfHeight negated * 0.45)
					to: halfWidth negated @ halfHeight negated ]
				
			
]

{ #category : #hooks }
TREllipseShape >> defaultStrokeWidth [
	^ self class defaultStrokeWidth
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

{ #category : #initialization }
TREllipseShape >> initialize [
	super initialize.
	self strokeWidth: self defaultStrokeWidth
]

{ #category : #drawing }
TREllipseShape >> scaledStrokeWidth [
	^ self strokeWidth 
]
