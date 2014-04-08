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

{ #category : #visitor }
TRAbstractBoxShape >> accept: aVisitor [
	aVisitor visitAbstractBoxShape: self
]

{ #category : #accessing }
TRAbstractBoxShape >> center [
	^ self position
]

{ #category : #drawing }
TRAbstractBoxShape >> drawOn: athensCanvas [
	self shouldBeDrawn
		ifFalse: [ ^ self ].
	self drawEncompassingRectangleOn: athensCanvas.
	athensCanvas pathTransform
		restoreAfter: [ 
			athensCanvas pathTransform
				multiplyBy: matrix.
			athensCanvas
				setPaint: color;
				drawShape: self path.
			self drawStrokeIfNecessaryOn: athensCanvas ]
]

{ #category : #drawing }
TRAbstractBoxShape >> drawStrokeIfNecessaryOn: athensCanvas [
	| scale |
	scale := self canvas camera scale.
	^ strokePaint
		ifNotNil: [ 
			(athensCanvas setStrokePaint: strokePaint) width: (self strokeWidth / (scale )) asFloat.
			athensCanvas drawShape: path ]
]

{ #category : #accessing }
TRAbstractBoxShape >> encompassingRectangle [

	| rotatedRectangle topLeft topRight bottomRight bottomLeft p1 p2 p3 p4 |
	topLeft := matrix transform: rectangle topLeft.
	topRight := matrix transform: rectangle topRight.
	bottomRight := matrix transform: rectangle bottomRight.
	bottomLeft := matrix transform: rectangle bottomLeft.
	
	p1 := OrderedCollection new add: topLeft x; add: topRight x; add: bottomRight x; add: bottomLeft x; yourself.
	p2 := OrderedCollection new add: topLeft y; add: topRight y; add: bottomRight y; add: bottomLeft y; yourself.
	p3 := OrderedCollection new add: topLeft x; add: topRight x; add: bottomRight x; add: bottomLeft x; yourself.
	p4 := OrderedCollection new add: topLeft y; add: topRight y; add: bottomRight y; add: bottomLeft y; yourself.
	
	rotatedRectangle := 
		(p1 min @ p2 min) corner:
		(p3 max @ p4 max).
	^ rotatedRectangle
]

{ #category : #accessing }
TRAbstractBoxShape >> extent [
	^ self encompassingRectangle extent
]

{ #category : #geometry }
TRAbstractBoxShape >> extent: anExtent [
	anExtent = self extent ifTrue: [ ^ self ].
	rectangle := (0@0 - (anExtent / 2)) extent: anExtent.
	self resetPath.
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
TRAbstractBoxShape >> fromRectangle: newRectangle [
	| step |
	step := newRectangle center - self position.
	rectangle := newRectangle translateBy: newRectangle center negated.
	self position: newRectangle center.
	self resetPath.
	self triggerCallbacksForStep: step.
]

{ #category : #public }
TRAbstractBoxShape >> fromRectangle: r color: aColor [
	self fromRectangle: r.
	self color: aColor
]

{ #category : #accessing }
TRAbstractBoxShape >> height [
	^ self encompassingRectangle height
]

{ #category : #accessing }
TRAbstractBoxShape >> height: newHeight [
	rectangle := (0@0 extent: rectangle width @ newHeight) 
						translateBy: (rectangle width @ newHeight) / -2.
	self resetPath.
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
	self position: (aPosition - ((self width / -2) @ 0))
]

{ #category : #accessing }
TRAbstractBoxShape >> rectangle [
	^ rectangle
]

{ #category : #accessing }
TRAbstractBoxShape >> rectangle: newRectangle [
	self fromRectangle: newRectangle
]

{ #category : #testing }
TRAbstractBoxShape >> shouldBeDrawn [
	^ rectangle width > 0 and: [ rectangle height > 0 ]
]

{ #category : #accessing }
TRAbstractBoxShape >> size: v [
	^ self extent: v @ v
]

{ #category : #hooks }
TRAbstractBoxShape >> strokeWidth [
	^ 1.5
]

{ #category : #accessing }
TRAbstractBoxShape >> width [
	^ self encompassingRectangle width
]

{ #category : #accessing }
TRAbstractBoxShape >> width: newWidth [
	rectangle := (0@0 extent: newWidth @ rectangle height) 
						translateBy: (newWidth @ rectangle height) / -2.
	self resetPath.
]
