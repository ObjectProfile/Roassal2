Class {
	#name : #TRShape,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'color',
		'path',
		'strokePaint',
		'position'
	],
	#category : #Trachel
}

{ #category : #accessing }
TRShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	canvas := aSurface
]

{ #category : #accessing }
TRShape >> color [
	
	^ color
]

{ #category : #accessing }
TRShape >> color: aColor [
	
	color := aColor
]

{ #category : #drawing }
TRShape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [
		athensCanvas pathTransform 
			translateBy: position.

		athensCanvas
			setPaint: color;
			drawShape: path.
			
		athensCanvas
			setStrokePaint: strokePaint;
			drawShape: path  ]
]

{ #category : #initialization }
TRShape >> initialize [
	super initialize.
	color := Color gray.
	strokePaint := Color black.
	path := 10 @ 20 extent: 30 @ 30.
	
	position := 0 @ 0
]

{ #category : #accessing }
TRShape >> path [
	
	^ path
]

{ #category : #accessing }
TRShape >> path: aCairoPath [
	
	path := aCairoPath
]

{ #category : #accessing }
TRShape >> strokePaint [
	"Return the color of the border line"
	^ strokePaint
]

{ #category : #accessing }
TRShape >> strokePaint: aColor [
	"set the color of the border line"
	strokePaint := aColor
]

{ #category : #actions }
TRShape >> translateBy: aPoint [
	"We should not have this..."
	self translateTo: (position + aPoint)
]

{ #category : #actions }
TRShape >> translateTo: aPoint [
	"We should not have this..."
	position := aPoint
]
