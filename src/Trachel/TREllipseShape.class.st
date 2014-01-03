Class {
	#name : #TREllipseShape,
	#superclass : #TRAbstractBoxShape,
	#category : #Trachel
}

{ #category : #hooks }
TREllipseShape >> computePath [
	canvas ifNil: [ ^ self ].
	path := self athensCanvas
				createPath: [ :builder | 
					builder
						absolute;
						moveTo: 0 @ 1;
						ccwArcTo: 1.0 @ 0.0 angle: 90 degreesToRadians;
						ccwArcTo: 0.0 @ -1.0 angle: 90 degreesToRadians;
						ccwArcTo: -1.0 @ 0.0 angle: 90 degreesToRadians;
						ccwArcTo: 0 @ 1.0 angle: 90 degreesToRadians ]
"	path := canvas
		cacheAt: self
		ifAbsentPut: [ 
			canvas
				createPath: [ :builder | 
					builder
						absolute;
						moveTo: 0 @ 1;
						ccwArcTo: 1.0 @ 0.0 angle: 90 degreesToRadians;
						ccwArcTo: 0.0 @ -1.0 angle: 90 degreesToRadians;
						ccwArcTo: -1.0 @ 0.0 angle: 90 degreesToRadians;
						ccwArcTo: 0 @ 1.0 angle: 90 degreesToRadians ] ]"
]

{ #category : #drawing }
TREllipseShape >> drawOn: athensCanvas [
	self shouldBeDrawn ifFalse: [ ^ self ].
	athensCanvas pathTransform restoreAfter: [
		athensCanvas pathTransform 
			translateBy: rectangle center;
			scaleBy: rectangle extent / 2.

		athensCanvas
			setPaint: color;
			drawShape: self path.

		self drawStrokeIfNecessaryOn: athensCanvas
		]
]

{ #category : #public }
TREllipseShape >> from: aPoint to: anotherPoint color: aColor [
	rectangle := aPoint corner: anotherPoint.
	self strokePaint: aColor.
	self color: aColor
]

{ #category : #testing }
TREllipseShape >> includesPoint: aPoint [
	"We could aternatively translate rectangle by position"
	^ rectangle containsPoint: (aPoint)
]
