Class {
	#name : #TRShape,
	#superclass : #TRObject,
	#instVars : [
		'canvas',
		'color',
		'path',
		'strokePaint',
		'announcer',
		'element',
		'callbacks',
		'matrix'
	],
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRShape >> accept: aVisitor [
	aVisitor visitShape: self
]

{ #category : #callbacks }
TRShape >> addCallback: aCallback [
	callbacks ifNil: [ callbacks := OrderedCollection new ].
	callbacks add: aCallback
]

{ #category : #actions }
TRShape >> addedIn: aCanvas [
	aCanvas privateAdd: self.
	self canvas: aCanvas
]

{ #category : #events }
TRShape >> announce: anEvent [
	self announcer announce: anEvent
]

{ #category : #events }
TRShape >> announcer [
	announcer isNil ifTrue: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #events }
TRShape >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
TRShape >> athensCanvas [
	^ self canvas athensCanvas
]

{ #category : #accessing }
TRShape >> canvas [
	"Return a Trachel Canvas"
	^ canvas
]

{ #category : #accessing }
TRShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	canvas := aSurface
]

{ #category : #accessing }
TRShape >> center [
	self subclassResponsibility
]

{ #category : #accessing }
TRShape >> color [
	
	^ color
]

{ #category : #accessing }
TRShape >> color: aColor [
	
	color := aColor
]

{ #category : #private }
TRShape >> computePath [
	self subclassResponsibility
]

{ #category : #drawing }
TRShape >> drawEncompassingRectangleOn: athensCanvas [
	"debugging purpose"
	self drawEncompassingRectangleOn: athensCanvas color: (Color blue alpha: 0.2)
]

{ #category : #drawing }
TRShape >> drawEncompassingRectangleOn: athensCanvas color: aColor [
	"debugging purpose"
 	| r tpath |
	r := self encompassingRectangle.
	tpath := athensCanvas
				createPath: [ :builder | 
					builder absolute; moveTo: r topLeft; lineTo: r topRight; 
							lineTo: r bottomRight; lineTo: r bottomLeft; lineTo: r topLeft ].
	athensCanvas pathTransform
		restoreAfter: [ 
			athensCanvas
				setPaint: aColor;
				drawShape: tpath ].
]

{ #category : #drawing }
TRShape >> drawOn: athensCanvas [
	| pt |
	pt := athensCanvas pathTransform.
	pt restoreAfter: [
		pt scaleBy: matrix sx @ matrix sy.
		
		athensCanvas
			setPaint: color;
			drawShape: self path.
			
		athensCanvas
			setStrokePaint: strokePaint;
			drawShape: self path  ]
]

{ #category : #accessing }
TRShape >> element [
	"A shape has a reference to an object, typically the object odel that the trachel shape represents"
	^ element 
]

{ #category : #accessing }
TRShape >> element: anObject [
	"anObject could be any kind of object. A shape has a reference to an object, typically the object odel that the trachel shape represents"
	element := anObject
]

{ #category : #accessing }
TRShape >> encompassingRectangle [
	self subclassReponsibility
]

{ #category : #actions }
TRShape >> extent: anExtent [
	"do nothing here. This method may be overriden for particular behavior"
]

{ #category : #testing }
TRShape >> hasCallback [
	^ callbacks notNil
]

{ #category : #testing }
TRShape >> hasEventCallback [
	^ announcer notNil and: [ announcer numberOfSubscriptions > 0 ]
]

{ #category : #testing }
TRShape >> includesPoint: aPoint [
	^ false
]

{ #category : #initialization }
TRShape >> initialize [
	super initialize.
	color := Color gray.
	strokePaint := Color black.
	matrix := AthensAffineTransform new.
	self position: 0 @ 0.
]

{ #category : #testing }
TRShape >> isFixed [

	^ self canvas fixedShapes includes: self
]

{ #category : #testing }
TRShape >> isInACanvas [
	^ canvas notNil
]

{ #category : #testing }
TRShape >> isMovable [

	^ self canvas isMovableShape: self
]

{ #category : #testing }
TRShape >> isNotFixed [

	^ self isMovable
]

{ #category : #accessing }
TRShape >> matrix [
	^ matrix
]

{ #category : #actions }
TRShape >> noBorder [
	"Remove the border from the shape"
	self strokePaint: nil
]

{ #category : #private }
TRShape >> path [
	path ifNil: [ self computePath ].
	^ path
]

{ #category : #accessing }
TRShape >> position [
	^ matrix x @ matrix y
]

{ #category : #accessing }
TRShape >> position: aPosition [
	matrix translation: aPosition
]

{ #category : #actions }
TRShape >> pushBack [
	canvas pushBack: self
	
	
]

{ #category : #actions }
TRShape >> pushBehind: aShape [
	canvas push: self behind: aShape
]

{ #category : #actions }
TRShape >> pushBehindAll: manyShapes [
	canvas push: self behindAll: manyShapes
]

{ #category : #actions }
TRShape >> pushFront [
	canvas pushFront: self
	
	
]

{ #category : #actions }
TRShape >> remove [
	"Do nothing if the line is not already in a canvas"
	self isInACanvas ifFalse: [ ^ self ]. 
	canvas removeShape: self
]

{ #category : #callbacks }
TRShape >> removeCallback: aCallback ifAbsent: anErrorBlock [
	callbacks ifNil: [ ^ self ].
	callbacks remove: aCallback ifAbsent: anErrorBlock
]

{ #category : #private }
TRShape >> resetPath [
	path := nil
]

{ #category : #transformations }
TRShape >> rotateByDegrees: angle [ 
	matrix rotateByDegrees: angle 
]

{ #category : #transformations }
TRShape >> scaleBy: anInteger [ 
	matrix scaleBy: anInteger.
]

{ #category : #actions }
TRShape >> setAsFixed [
	canvas ifNil: [ self error: 'You should first insert the shape in the canvas before setting it as fixed'. ].
	canvas setAsFixed: self.
	
]

{ #category : #actions }
TRShape >> setAsNotFixed [
	canvas removeFixedShape: self.
	canvas addShape: self.
]

{ #category : #testing }
TRShape >> shouldBeDrawn [
	^ true
]

{ #category : #actions }
TRShape >> signalUpdate [
	"Refresh the canvas"
	canvas ifNil: [ ^ self ].
	canvas signalUpdate
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
	self position: self position + aPoint.
	self triggerCallbacksForStep: aPoint
]

{ #category : #actions }
TRShape >> translateTo: aPoint [
	| oldPosition |
	oldPosition := self position.
	self position: aPoint.
	self triggerCallbacksForStep: (self position - oldPosition)
]

{ #category : #callbacks }
TRShape >> triggerCallbacksForNewExtent: newExtent oldExtent: oldExtent [ 
	callbacks ifNil: [ ^ self ].
	callbacks do: [ :c | 
		c isExtentCallback ifTrue: [ 
			c shape: self newExtent: newExtent oldExtent: oldExtent ] ]
]

{ #category : #callbacks }
TRShape >> triggerCallbacksForStep: aStep [
	"aStep is a point that represents a translation step"
	callbacks ifNil: [ ^ self ].
	callbacks do: [ :c | 
		c isTranslationCallback ifTrue: [ 
			c shape: self step: aStep ] ]
]

{ #category : #events }
TRShape >> when: event do: aBlock [
	self announcer when: event do: aBlock
]
