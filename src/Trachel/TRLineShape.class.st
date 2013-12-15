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
TRLineShape >> from: aPoint to: anotherPoint [ 

	path := (canvas createPath: [:builder |
		builder
			absolute;
			moveTo: aPoint;
			lineTo: anotherPoint
	]).

]

{ #category : #'as yet unclassified' }
TRLineShape >> from: aPoint to: anotherPoint color: aColor [

	self from: aPoint to: anotherPoint.
	self strokePaint: aColor.
	self color: aColor
]
