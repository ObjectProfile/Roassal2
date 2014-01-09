Class {
	#name : #TRBezierShape,
	#superclass : #TRShape,
	#instVars : [
		'listOfPoints'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRBezierShape >> computePath [
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: listOfPoints first;
				curveVia: listOfPoints second and: listOfPoints third  to:  listOfPoints fourth
				]
]

{ #category : #public }
TRBezierShape >> points: points [
	listOfPoints := points
]

{ #category : #public }
TRBezierShape >> points: listOfPoints color: aColor [

	self points: listOfPoints.
	self strokePaint: aColor.
	self color: aColor
]
