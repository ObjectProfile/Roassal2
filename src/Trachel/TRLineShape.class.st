Class {
	#name : #TRLineShape,
	#superclass : #TRShape,
	#instVars : [
		'from',
		'to'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRLineShape >> computePath [
	canvas ifNil: [ ^ self ].
	path := canvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: from;
				lineTo: to ]
]

{ #category : #'as yet unclassified' }
TRLineShape >> from [
	"Return a point"
	^ from
]

{ #category : #'as yet unclassified' }
TRLineShape >> from: aPoint [
	from := aPoint
]

{ #category : #'as yet unclassified' }
TRLineShape >> from: aPoint to: anotherPoint [
	from := aPoint.
	to := anotherPoint.

]

{ #category : #'as yet unclassified' }
TRLineShape >> from: aPoint to: anotherPoint color: aColor [

	self from: aPoint to: anotherPoint.
	self strokePaint: aColor.
	self color: aColor
]

{ #category : #'as yet unclassified' }
TRLineShape >> includesPoint: aPoint [
	^ aPoint onLineFrom: from to: to within: 3
]

{ #category : #'as yet unclassified' }
TRLineShape >> to [
	"Return a point"
	^ to
]

{ #category : #'as yet unclassified' }
TRLineShape >> to: aPoint [
	to := aPoint
]
