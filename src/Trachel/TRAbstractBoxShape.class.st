Class {
	#name : #TRAbstractBoxShape,
	#superclass : #TRShape,
	#instVars : [
		'rectangle'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> from: aPoint to: anotherPoint [ 
	
	self fromRectangle: (aPoint corner: anotherPoint)
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> from: aPoint to: anotherPoint color: aColor [
	self from: aPoint to: anotherPoint.
	self color: aColor.
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> fromRectangle: r [
	rectangle := r.
	self update
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> fromRectangle: r color: aColor [
	self fromRectangle: r.
	self color: aColor
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> includesPoint: aPoint [
	"We could aternatively translate rectangle by position"
	^ rectangle containsPoint: (aPoint - position)
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> update [
	path := canvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: rectangle topLeft;
				lineTo: rectangle topRight;
				lineTo: rectangle bottomRight;
				lineTo: rectangle bottomLeft;
				lineTo: rectangle topLeft ]
]
