Class {
	#name : #TRBitmapShape,
	#superclass : #TRShape,
	#instVars : [
		'form',
		'rectangle'
	],
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRBitmapShape >> accept: aVisitor [
	aVisitor visitBitMapShape: self
]

{ #category : #accessing }
TRBitmapShape >> at: aPosition put: aColor [
	self form getCanvas fillRectangle: (aPosition extent: 1 @ 1) color: aColor
]

{ #category : #private }
TRBitmapShape >> basicEncompassingRectangle [
	rectangle ifNil: [ self computeRectangle ].
	^ rectangle
]

{ #category : #accessing }
TRBitmapShape >> center [
	^ self position
]

{ #category : #private }
TRBitmapShape >> computeRectangle [
	form 
		ifNil: [ rectangle := (-2.5 @ -2.5) corner: (2.5 @ 2.5) ]
		ifNotNil: [ rectangle := form boundingBox translateBy: form boundingBox center negated ].
]

{ #category : #drawing }
TRBitmapShape >> drawOn: athensCanvas [
	| paint |
	athensCanvas pathTransform restoreAfter: [
		athensCanvas setShape: self form boundingBox.
		athensCanvas pathTransform 
			multiplyBy: matrix asFloatTransform;
			translateBy: rectangle corner negated.
		self form ifNotNil: [ 
			 paint := (athensCanvas cacheAt: self form
                             	ifAbsentPut: [ (self form asAthensPaintOn: athensCanvas) ]).
			athensCanvas setPaint: paint.
			].
		athensCanvas draw ].
	self drawEncompassingRectangleOn: athensCanvas.

	
]

{ #category : #accessing }
TRBitmapShape >> encompassingRectangle [
	^ self transformedEncompassingRectangle 
]

{ #category : #'mode constants' }
TRBitmapShape >> erase [
	self fillColor: Color white
]

{ #category : #actions }
TRBitmapShape >> extent: anExtent [
	form := Form extent: anExtent depth: 32.
	"form := ColorForm extent: anExtent depth: 32"
]

{ #category : #accessing }
TRBitmapShape >> fillColor: aColor [
	self form getCanvas fillRectangle: (0 @ 0 extent: self extent) color: aColor
]

{ #category : #accessing }
TRBitmapShape >> fillColorMap: aColorMap [
	self form getCanvas fillRectangle: (0 @ 0 extent: self extent) color: aColorMap
]

{ #category : #accessing }
TRBitmapShape >> form [
	^ form
]

{ #category : #accessing }
TRBitmapShape >> form: aForm [
	form := aForm
]

{ #category : #testing }
TRBitmapShape >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
	^ self basicEncompassingRectangle containsPoint: invertedPoint.
]
