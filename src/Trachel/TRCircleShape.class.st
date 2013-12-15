Class {
	#name : #TRCircleShape,
	#superclass : #TRShape,
	#instVars : [
		'radius'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRCircleShape >> buildCircleFrom: aPoint to: anotherPoint color: aColor [


	path := (canvas createPath: [:builder |
		builder
			absolute;	
			moveTo: 0 @ 0; 
			ccwArcTo: 1.0 @ 0.0 angle: 180 degreesToRadians
	]).
	self strokePaint: aColor.
	self color: aColor
]
