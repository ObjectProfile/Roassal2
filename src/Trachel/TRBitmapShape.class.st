Class {
	#name : #TRBitmapShape,
	#superclass : #TRShape,
	#instVars : [
		'form'
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

{ #category : #accessing }
TRBitmapShape >> center [
	^ self position
]

{ #category : #drawing }
TRBitmapShape >> drawOn: athensCanvas [
	"self drawEncompassingRectangleOn: athensCanvas color: (Color gray alpha: 0.1)."
	
	| paint |
	athensCanvas pathTransform restoreAfter: [
		"athensCanvas pathTransform translateBy: (self center - (self extent / 2)) asFloatPoint."
		athensCanvas setShape: (0@0 extent: self extent).
		athensCanvas pathTransform translateBy: self encompassingRectangle topLeft asFloatPoint.
		self form ifNotNil: [ 
			 paint := (athensCanvas cacheAt: self form
                             	ifAbsentPut: [ (self form asAthensPaintOn: athensCanvas) ]).
			athensCanvas setPaint: paint.
			].
		athensCanvas draw ]
	
]

{ #category : #accessing }
TRBitmapShape >> encompassingRectangle [
	| w h |
	w := self width.
	h := self height.
	^ self position + ((w / -2) @ (h / -2)) extent: (w @ h)
]

{ #category : #'mode constants' }
TRBitmapShape >> erase [
	self fillColor: Color white
]

{ #category : #accessing }
TRBitmapShape >> extent [
	 ^ self encompassingRectangle extent
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

{ #category : #accessing }
TRBitmapShape >> height [

	self form isNil ifTrue: [ ^ 0 ].
	^ self form height
]

{ #category : #testing }
TRBitmapShape >> includesPoint: aPoint [
	"Probably this methods should be updated to reflect transformation"
	^ self encompassingRectangle containsPoint: aPoint
]

{ #category : #accessing }
TRBitmapShape >> width [

	self form isNil ifTrue: [ ^ 5 ].
	^ self form width
]
