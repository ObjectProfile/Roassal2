Class {
	#name : #TRBoxShape,
	#superclass : #TRShape,
	#instVars : [
		'width',
		'height'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRBoxShape >> from: aPoint to: anotherPoint [ 
	
	self fromRectangle: (aPoint corner: anotherPoint)
]

{ #category : #'as yet unclassified' }
TRBoxShape >> from: aPoint to: anotherPoint color: aColor [
	self from: aPoint to: anotherPoint.
	self color: aColor.
]

{ #category : #'as yet unclassified' }
TRBoxShape >> fromRectangle: r [
	path := (canvas createPath: [:builder |
		builder
			absolute;
			moveTo: r topLeft;
			lineTo: r topRight;
			lineTo: r bottomRight;
			lineTo: r bottomLeft;
			lineTo: r topLeft.
	]).

]

{ #category : #'as yet unclassified' }
TRBoxShape >> fromRectangle: r color: aColor [
	self fromRectangle: r.
	self color: aColor
]
