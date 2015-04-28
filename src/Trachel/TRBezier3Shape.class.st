"
Describe a cubic Bezier spline
"
Class {
	#name : #TRBezier3Shape,
	#superclass : #TRAbstractLineShape,
	#instVars : [
		'listOfPoints'
	],
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRBezier3Shape >> accept: aVisitor [
	aVisitor visitBezierShape: self
]

{ #category : #visitor }
TRBezier3Shape >> accept: aVisitor with: decoration [
	aVisitor visitBezierShape: self with: decoration
]

{ #category : #hooks }
TRBezier3Shape >> computePath [
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: listOfPoints first.
			builder 
				curveViaX: listOfPoints first x asFloat Y: listOfPoints first y asFloat
				viaX: listOfPoints second x asFloat Y: listOfPoints second y asFloat 
				toX: listOfPoints third x asFloat Y: listOfPoints third y asFloat.
		]
]

{ #category : #drawing }
TRBezier3Shape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [
		
		athensCanvas setShape: self path.
		(athensCanvas setStrokePaint: color) width: width.
		athensCanvas draw  ]
]

{ #category : #accessing }
TRBezier3Shape >> encompassingRectangle [
	^ Rectangle encompassing: listOfPoints
]

{ #category : #initialization }
TRBezier3Shape >> initialize [
	super initialize.
	listOfPoints := Array with: 0 @ 0 with: 0 @ 0 with: 0 @ 0
]

{ #category : #accessing }
TRBezier3Shape >> numberOfPoints [
	^ self points size
]

{ #category : #accessing }
TRBezier3Shape >> points [
	^ listOfPoints copy
]

{ #category : #public }
TRBezier3Shape >> points: points [
	self assert: [ points size = 3 ] description: 'Only 3 points may be provided'.
	listOfPoints := points
]

{ #category : #public }
TRBezier3Shape >> points: aListOfPoints color: aColor [
	self assert: [ aListOfPoints size = 3 ] description: 'Only 3 points may be provided'.
	
	self points: aListOfPoints.
	self strokePaint: aColor.
	self color: aColor
]

{ #category : #accessing }
TRBezier3Shape >> position [
	^ self encompassingRectangle center
]

{ #category : #actions }
TRBezier3Shape >> translateBy: aPoint [
	listOfPoints := listOfPoints collect: [ :p | p + aPoint ]

]
