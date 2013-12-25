Class {
	#name : #TRAbstractBoxShape,
	#superclass : #TRShape,
	#instVars : [
		'rectangle'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> computePath [
	canvas ifNil: [ ^ self ].
	path := self athensCanvas
		createPath: [ :builder | 
			builder
				absolute;
				moveTo: rectangle topLeft;
				lineTo: rectangle topRight;
				lineTo: rectangle bottomRight;
				lineTo: rectangle bottomLeft;
				lineTo: rectangle topLeft ]
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> extent [
	^ self rectangle extent
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> extent: anExtent [
	| center |
	center := rectangle center.
	rectangle := (center - (anExtent / 2)) extent: anExtent.
	self resetPath
]

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
	self resetPath
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> fromRectangle: r color: aColor [
	self fromRectangle: r.
	self color: aColor
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> height [
	^ rectangle height
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> includesPoint: aPoint [
	"We could aternatively translate rectangle by position"
	^ rectangle containsPoint: (aPoint - position)
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> rectangle [
	^ rectangle
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> rectangle: r [
	self fromRectangle: r
]

{ #category : #'as yet unclassified' }
TRAbstractBoxShape >> width [
	^ rectangle width
]
