Class {
	#name : #TRBezierShape,
	#superclass : #TRAbstractLineShape,
	#instVars : [
		'width',
		'listOfPoints'
	],
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRBezierShape >> accept: aVisitor [
	aVisitor visitBezierShape: self
]

{ #category : #visitor }
TRBezierShape >> accept: aVisitor with: decoration [
	aVisitor visitBezierShape: self with: decoration
]

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
		
		athensCanvas setShape: self path.
		(athensCanvas setStrokePaint: color) width: width.
		athensCanvas draw  ]
]

{ #category : #accessing }
TRBezierShape >> encompassingRectangle [
	^ Rectangle encompassing: listOfPoints
]

{ #category : #initialization }
TRBezierShape >> initialize [
	super initialize.
	listOfPoints := Array with: 0 @ 0 with: 0 @ 0
]

{ #category : #accessing }
TRBezierShape >> numberOfPoints [
	^ self points size
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

{ #category : #accessing }
TRBezierShape >> strokePaint [
	"return the color of the border line"
	^ self color
]

{ #category : #accessing }
TRBezierShape >> strokePaint: aColor [
	"set the color of the border line"
	self color: aColor
]

{ #category : #actions }
TRBezierShape >> translateBy: aPoint [
	listOfPoints := listOfPoints collect: [ :p | p + aPoint ]

]

{ #category : #accessing }
TRBezierShape >> width [
	^ width
]

{ #category : #accessing }
TRBezierShape >> width: anObject [
	width := anObject
]
