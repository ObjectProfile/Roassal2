Class {
	#name : #TRBezierShape,
	#superclass : #TRShape,
	#instVars : [
		'listOfPoints'
	],
	#category : #Trachel
}

{ #category : #hooks }
TRBezierShape >> computePath [
	|   |
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: listOfPoints first.
			
			(2 to: (listOfPoints size -1)) do: [ :index |
				builder 
					curveVia: (listOfPoints at: index) 
					to: (((listOfPoints at: index) + (listOfPoints at: (index + 1))) / 2) asFloatPoint.
			].
			builder lineTo: listOfPoints last.
		]
]

{ #category : #drawing }
TRBezierShape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [
			
		athensCanvas
			setStrokePaint: strokePaint;
			drawShape: self path  ]
]

{ #category : #accessing }
TRBezierShape >> encompassingRectangle [
	^ Rectangle encompassing: listOfPoints
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
