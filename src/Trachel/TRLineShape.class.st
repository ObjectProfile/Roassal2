Class {
	#name : #TRLineShape,
	#superclass : #TRShape,
	#instVars : [
		'from',
		'to'
	],
	#category : #Trachel
}

{ #category : #hooks }
TRLineShape >> computePath [
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: from;
				lineTo: to ]
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
	^ aPoint onLineFrom: from to: to within: 3
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
