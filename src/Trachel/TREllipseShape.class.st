Class {
	#name : #TREllipseShape,
	#superclass : #TRShape,
	#instVars : [
		'rectangle'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TREllipseShape >> drawOn: athensCanvas [
	athensCanvas pathTransform restoreAfter: [
		athensCanvas pathTransform 
			translateBy: rectangle center;
			scaleBy: rectangle extent / 2.

		athensCanvas
			setPaint: color;
			drawShape: path.
			
"		athensCanvas
			setStrokePaint: strokePaint;
			drawShape: path
"		]
]

{ #category : #'as yet unclassified' }
TREllipseShape >> from: aPoint to: anotherPoint color: aColor [
	rectangle := aPoint corner: anotherPoint.
	position := rectangle center.
	self update.
	self strokePaint: aColor.
	self color: aColor
]

{ #category : #'as yet unclassified' }
TREllipseShape >> includesPoint: aPoint [
	"We could aternatively translate rectangle by position"
	^ rectangle containsPoint: (aPoint)
]

{ #category : #'as yet unclassified' }
TREllipseShape >> rectangle [
	^ rectangle
]

{ #category : #'as yet unclassified' }
TREllipseShape >> rectangle: rec [
	rectangle := rec
]

{ #category : #'as yet unclassified' }
TREllipseShape >> update [
	path := canvas
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
