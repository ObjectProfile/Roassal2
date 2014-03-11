Class {
	#name : #TRAbstractBoxShape,
	#superclass : #TRShape,
	#instVars : [
		'rectangle'
	],
	#classInstVars : [
		'nullRectangle'
	],
	#category : #'Trachel-Core'
}

{ #category : #public }
TRAbstractBoxShape class >> nullRectangle [
	nullRectangle ifNotNil: [ ^ nullRectangle ].
	nullRectangle := (0 @ 0) extent: (0 @ 0).
	^ nullRectangle
]

{ #category : #accessing }
TRAbstractBoxShape >> center [
	^ self position
]

{ #category : #hooks }
TRAbstractBoxShape >> computePath [
	self subclassResponsibility
]

{ #category : #drawing }
TRAbstractBoxShape >> drawOn: athensCanvas [
	self subclassResponsibility
]

{ #category : #drawing }
TRAbstractBoxShape >> drawStrokeIfNecessaryOn: athensCanvas [
	| scale |
	scale := self canvas camera scale.
	^ strokePaint
		ifNotNil: [ 
			"4 / (rectangle extent x + 10)"
			(athensCanvas setStrokePaint: strokePaint) width: (1.5 / (scale )) asInteger.
			athensCanvas drawShape: path ]
]

{ #category : #accessing }
TRAbstractBoxShape >> encompassingRectangle [
	^ self rectangle
]

{ #category : #accessing }
TRAbstractBoxShape >> extent [
	^ self rectangle extent
]

{ #category : #geometry }
TRAbstractBoxShape >> extent: anExtent [
	| center |
	anExtent = self extent ifTrue: [ ^ self ].
	center := rectangle center.
	rectangle := (center - (anExtent / 2)) extent: anExtent.
	self resetPath
]

{ #category : #public }
TRAbstractBoxShape >> from: aPoint extent: anotherPoint [ 
	
	self fromRectangle: (aPoint corner: (aPoint + anotherPoint))
]

{ #category : #public }
TRAbstractBoxShape >> from: aPoint to: anotherPoint [ 
	
	self fromRectangle: (aPoint corner: anotherPoint)
]

{ #category : #public }
TRAbstractBoxShape >> from: aPoint to: anotherPoint color: aColor [
	self from: aPoint to: anotherPoint.
	self color: aColor.
]

{ #category : #public }
TRAbstractBoxShape >> fromRectangle: r [
	| oldTopLeft |
	oldTopLeft := rectangle topLeft.
	rectangle := r.
	position := rectangle center.
	self triggerCallbacksForStep: (r topLeft - oldTopLeft).
	self resetPath
]

{ #category : #public }
TRAbstractBoxShape >> fromRectangle: r color: aColor [
	self fromRectangle: r.
	self color: aColor
]

{ #category : #accessing }
TRAbstractBoxShape >> height [
	^ rectangle height
]

{ #category : #accessing }
TRAbstractBoxShape >> height: newHeight [
	rectangle := (position - (0 @ (newHeight / 2))) extent: (self extent x @ newHeight)
]

{ #category : #testing }
TRAbstractBoxShape >> includesPoint: aPoint [
	self subclassResponsibility
]

{ #category : #initialization }
TRAbstractBoxShape >> initialize [
	super initialize.
	rectangle := self class nullRectangle
]

{ #category : #public }
TRAbstractBoxShape >> leftPosition: aPosition [
	self position: (aPosition - ((self width / -2) @ 0) ) asIntegerPoint
]

{ #category : #accessing }
TRAbstractBoxShape >> rectangle [
	^ rectangle
]

{ #category : #accessing }
TRAbstractBoxShape >> rectangle: r [
	self fromRectangle: r
]

{ #category : #testing }
TRAbstractBoxShape >> shouldBeDrawn [
	^ rectangle width > 0 and: [ rectangle height > 0 ]
]

{ #category : #accessing }
TRAbstractBoxShape >> size: v [
	^ self extent: v @ v
]

{ #category : #actions }
TRAbstractBoxShape >> translateBy: aPoint [
	super translateBy: aPoint.
	rectangle := (rectangle topLeft + aPoint) extent: rectangle extent.
	self triggerCallbacksForStep: aPoint
]

{ #category : #actions }
TRAbstractBoxShape >> translateTo: aPoint [
	| oldTopLeft |
	super translateTo: aPoint.
	oldTopLeft := rectangle topLeft.
	rectangle := (aPoint - (self extent / 2)) extent: self extent.
	self triggerCallbacksForStep: (rectangle topLeft - oldTopLeft)
]

{ #category : #actions }
TRAbstractBoxShape >> triggerCallbacksForStep: aStep [
	"aStep is a point that represents a translation step"
	callbacks ifNil: [ ^ self ].
	callbacks do: [ :c | c block value: self value: aStep ]
]

{ #category : #accessing }
TRAbstractBoxShape >> width [
	^ rectangle width
]

{ #category : #accessing }
TRAbstractBoxShape >> width: newWidth [
	rectangle := (position - ((newWidth / 2) @ 0)) extent: (newWidth @ self extent y)
]
