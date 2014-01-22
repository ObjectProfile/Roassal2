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

{ #category : #'as yet unclassified' }
TRBezierShape >> initialize [
	super initialize.
	listOfPoints := Array with: 0 @ 0 with: 0 @ 0
]

{ #category : #accessing }
TRBezierShape >> points [
	^ listOfPoints copy
]

{ #category : #public }
TRBezierShape >> points: points [
	listOfPoints := points
]

{ #category : #public }
TRBezierShape >> points: aListOfPoints color: aColor [

	self points: aListOfPoints.
	self strokePaint: aColor.
	self color: aColor
]

{ #category : #accessing }
TRBezierShape >> position [
	^ self encompassingRectangle center
]

{ #category : #actions }
TRBezierShape >> translateBy: aPoint [
	listOfPoints := listOfPoints collect: [ :p | p:=p+aPoint ]

]
