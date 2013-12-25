"
A TREllipseShape is xxxxxxxxx.

Instance Variables
	rectangle:		<Object>

rectangle
	- xxxxx

"
Class {
	#name : #TREllipseShape3,
	#superclass : #TRShape,
	#instVars : [
		'rectangle'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TREllipseShape3 >> computePath [
	canvas ifNil: [ ^ self ].
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

{ #category : #'as yet unclassified' }
TREllipseShape3 >> drawOn: athensCanvas [

Transcript show: rectangle printString, color printString, self path printString; cr.

	athensCanvas pathTransform restoreAfter: [
		athensCanvas pathTransform 
			translateBy: rectangle center;
			scaleBy: rectangle extent / 2.

		athensCanvas
			setPaint: color;
			drawShape: self path.
			
"		athensCanvas
			setStrokePaint: strokePaint;
			drawShape: path
"		]
]

{ #category : #'as yet unclassified' }
TREllipseShape3 >> from: aPoint to: anotherPoint color: aColor [
	rectangle := aPoint corner: anotherPoint.
	position := rectangle center.
	self strokePaint: aColor.
	self color: aColor
]

{ #category : #'as yet unclassified' }
TREllipseShape3 >> includesPoint: aPoint [
	"We could aternatively translate rectangle by position"
	^ rectangle containsPoint: (aPoint)
]

{ #category : #'as yet unclassified' }
TREllipseShape3 >> rectangle [
	^ rectangle
]

{ #category : #'as yet unclassified' }
TREllipseShape3 >> rectangle: rec [
	rectangle := rec
]
