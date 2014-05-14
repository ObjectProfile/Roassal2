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

{ #category : #private }
TRAbstractBoxShape >> basicEncompassingRectangle [
	^ rectangle
]

{ #category : #accessing }
TRAbstractBoxShape >> center [
	^ self position
]

{ #category : #drawing }
TRAbstractBoxShape >> drawOn: athensCanvas [
	self shouldBeDrawn
		ifFalse: [ ^ self ].
	athensCanvas pathTransform
		restoreAfter: [ 
			athensCanvas pathTransform
				multiplyBy: matrix asFloatTransform.
			self preDrawOn: athensCanvas.
			athensCanvas 
				setPaint: color;
				drawShape: self path.
			self drawStrokeIfNecessaryOn: athensCanvas ]
]

{ #category : #drawing }
TRAbstractBoxShape >> drawStrokeIfNecessaryOn: athensCanvas [
	| scale ratio |
	scale := self canvas camera scale.
	scale < 1 
		ifTrue: [ ratio := self strokeWidth ] 
		ifFalse: [ ratio := self strokeWidth / (scale ) ].
	^ strokePaint
		ifNotNil: [ 
			(athensCanvas setStrokePaint: strokePaint) width: ratio asFloat.
			athensCanvas drawShape: path ]
]

{ #category : #accessing }
TRAbstractBoxShape >> encompassingRectangle [
	^ self transformedEncompassingRectangle 
]

{ #category : #accessing }
TRAbstractBoxShape >> extent [
	^ self encompassingRectangle extent
]

{ #category : #geometry }
TRAbstractBoxShape >> extent: newExtent [
	| oldExtent |
	newExtent = rectangle extent ifTrue: [ ^ self ].
	oldExtent := rectangle extent.
	rectangle := (0@0 - (newExtent / 2)) extent: newExtent.
	self resetPath.
	(oldExtent = (0 @ 0)) ifFalse: [ 
		self triggerCallbacksForNewExtent: newExtent oldExtent: oldExtent ].

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
	self extent: rectangle width @ newHeight
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

{ #category : #drawing }
TRAbstractBoxShape >> preDrawOn: athensCanvas [
]

{ #category : #geometry }
TRAbstractBoxShape >> rectangle: aRectangle [
	rectangle := aRectangle.
	self resetPath.
	
	"(oldExtent = (0 @ 0)) ifFalse: [ 
		self triggerCallbacksForNewExtent: newExtent oldExtent: oldExtent ].
"
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
	^ 1
]

{ #category : #accessing }
TRAbstractBoxShape >> width [
	^ self encompassingRectangle width
]

{ #category : #accessing }
TRAbstractBoxShape >> width: newWidth [
	self extent: newWidth @ rectangle height.
]
