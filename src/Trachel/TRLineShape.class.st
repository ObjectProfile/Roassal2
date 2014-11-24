Class {
	#name : #TRLineShape,
	#superclass : #TRAbstractLineShape,
	#instVars : [
		'width',
		'from',
		'to'
	],
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRLineShape >> accept: aVisitor [
	aVisitor visitLineShape: self
]

{ #category : #visitor }
TRLineShape >> accept: aVisitor with: decoration [
	aVisitor visitLineShape: self with: decoration
]

{ #category : #accessing }
TRLineShape >> center [
	^ (from + to) / 2
]

{ #category : #hooks }
TRLineShape >> computePath [
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: from;
				lineTo: to ]
]

{ #category : #drawing }
TRLineShape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [
		athensCanvas setShape: self path.
		(athensCanvas setStrokePaint: color) width: width.
		athensCanvas draw  ]
		"(athensCanvas setStrokePaint: strokePaint) width: (1.5 / (scale )) asInteger."
]

{ #category : #accessing }
TRLineShape >> encompassingRectangle [
	^ Rectangle encompassing: (Array with: from with: to)
]

{ #category : #accessing }
TRLineShape >> from [
	"Return a point"
	^ from
]

{ #category : #accessing }
TRLineShape >> from: aPoint [
	from := aPoint
]

{ #category : #public }
TRLineShape >> from: aPoint to: anotherPoint [
	from := aPoint.
	to := anotherPoint.

]

{ #category : #public }
TRLineShape >> from: aPoint to: anotherPoint color: aColor [

	self from: aPoint to: anotherPoint.
	self strokePaint: aColor.
	self color: aColor
]

{ #category : #testing }
TRLineShape >> includesPoint: aPoint [ 
	^ self includesPoint: aPoint delta: 5
]

{ #category : #testing }
TRLineShape >> includesPoint: aPoint delta: nbOfPixelsAroundTheLine [
	^ aPoint onLineFrom: from to: to within: nbOfPixelsAroundTheLine
]

{ #category : #initialization }
TRLineShape >> initialize [
	super initialize.
	from := 0 @ 0.
	to := 0 @ 0.
	width := 1.
]

{ #category : #accessing }
TRLineShape >> position [
	^ ((from + to) / 2)
]

{ #category : #accessing }
TRLineShape >> strokePaint [
	"return the color of the border line"
	^ self color
]

{ #category : #accessing }
TRLineShape >> to [
	"Return a point"
	^ to
]

{ #category : #accessing }
TRLineShape >> to: aPoint [
	to := aPoint
]

{ #category : #actions }
TRLineShape >> translateBy: aPoint [
	from := from + aPoint.
	to := to + aPoint
]

{ #category : #accessing }
TRLineShape >> width [
	^ width
]

{ #category : #accessing }
TRLineShape >> width: aNumber [
	width := aNumber
]
