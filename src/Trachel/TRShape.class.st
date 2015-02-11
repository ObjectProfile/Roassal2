Class {
	#name : #TRShape,
	#superclass : #TRCallableObject,
	#instVars : [
		'canvas',
		'color',
		'path',
		'strokePaint',
		'announcer',
		'element',
		'matrix',
		'rotationAngleDegrees',
		'session'
	],
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRShape >> accept: aVisitor [
	aVisitor visitShape: self
]

{ #category : #actions }
TRShape >> addedIn: aCanvas [
	aCanvas privateAdd: self.
	self canvas: aCanvas
]

{ #category : #actions }
TRShape >> addedIn: aCanvas atIndex: index [
	aCanvas privateAdd: self atIndex: index.
	self canvas: aCanvas
]

{ #category : #accessing }
TRShape >> angleInDegrees [
	^ rotationAngleDegrees
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

{ #category : #private }
TRShape >> basicEncompassingRectangle [
	^ self subclassResponsibility
]

{ #category : #accessing }
TRShape >> canvas [
	"Return a Trachel Canvas"
	^ canvas
]

{ #category : #accessing }
TRShape >> canvas: aTRCanvas [
	"aCanvas is a TRCanvas"
	canvas := aTRCanvas
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
	"Maybe here, we need to insert the stroke"
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
	"Return true if at least one callback has been added to the shape"
	^ callbacks notNil
]

{ #category : #testing }
TRShape >> hasEventCallback [
	"Return true if at least one event callback has been added to the shape"
	^ announcer notNil and: [ announcer numberOfSubscriptions > 0 ]
]

{ #category : #accessing }
TRShape >> height [
	^ self encompassingRectangle height
]

{ #category : #testing }
TRShape >> includesPoint: aPoint [
	^ false
]

{ #category : #accessing }
TRShape >> indexInCanvas [
	"Return the index of myself in the list shapes, in the canvas"
	^ canvas privateIndexInCanvasOf: self
]

{ #category : #initialization }
TRShape >> initialize [
	super initialize.
	color := Color gray.
	strokePaint := Color black.
	matrix := AthensAffineTransform new.
	rotationAngleDegrees := 0.
	self position: 0 @ 0.
	session := Smalltalk session.
]

{ #category : #testing }
TRShape >> isFixed [
	"Return true if the shape is fixed, not subject to the camera therefore"
	^ self canvas fixedShapes includes: self
]

{ #category : #testing }
TRShape >> isInACanvas [
	^ canvas notNil
]

{ #category : #testing }
TRShape >> isMovable [
	"Return if the shape is not fixed, therefore movable."
	^ self canvas isMovableShape: self
]

{ #category : #testing }
TRShape >> isNotFixed [

	^ self isMovable
]

{ #category : #testing }
TRShape >> isVisible [
	"Return true if the element is being seen by the camera"
	^ self canvas camera isVisible: self
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
	session == Smalltalk session
		ifFalse: [ path := nil ].
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
	canvas ifNil: [ self error: 'Cannot push back since the it has not been added into a view or a canvas' ]. 
	canvas pushBack: self
	
	
]

{ #category : #actions }
TRShape >> pushBehind: aShape [
	canvas push: self behind: aShape
]

{ #category : #actions }
TRShape >> pushBehindAll: manyShapes [
	self canvas push: self behindAll: manyShapes
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

{ #category : #private }
TRShape >> resetPath [
	path := nil
]

{ #category : #transformations }
TRShape >> rotateByDegrees: angle [ 
	rotationAngleDegrees := rotationAngleDegrees + angle.
	matrix rotateByDegrees: angle 
]

{ #category : #transformations }
TRShape >> rotateToDegrees: anAngle [
	^ self rotateByDegrees: anAngle - rotationAngleDegrees.
]

{ #category : #accessing }
TRShape >> scale [
	^ matrix scale
]

{ #category : #transformations }
TRShape >> scaleBy: anInteger [ 
	matrix scaleBy: anInteger.
]

{ #category : #actions }
TRShape >> setAsFixed [
	self canvas 
		ifNil: [ self error: 'You should first insert the shape in the canvas before setting it as fixed'. ].
	self canvas setAsFixed: self.
	
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

{ #category : #private }
TRShape >> transformedEncompassingRectangle [
	"Not all shapes are alredy using matrix. 
	For that reason we have this method."
	| basicRectangle rotatedRectangle topLeft topRight bottomRight bottomLeft p1 p2 p3 p4 |
	basicRectangle := self basicEncompassingRectangle.
	topLeft := matrix transform: basicRectangle topLeft.
	topRight := matrix transform: basicRectangle topRight.
	bottomRight := matrix transform: basicRectangle bottomRight.
	bottomLeft := matrix transform: basicRectangle bottomLeft.
	
	p1 := OrderedCollection new add: topLeft x; add: topRight x; add: bottomRight x; add: bottomLeft x; yourself.
	p2 := OrderedCollection new add: topLeft y; add: topRight y; add: bottomRight y; add: bottomLeft y; yourself.
	p3 := OrderedCollection new add: topLeft x; add: topRight x; add: bottomRight x; add: bottomLeft x; yourself.
	p4 := OrderedCollection new add: topLeft y; add: topRight y; add: bottomRight y; add: bottomLeft y; yourself.
	
	rotatedRectangle := 
		(p1 min @ p2 min) corner:
		(p3 max @ p4 max).
	^ rotatedRectangle
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

{ #category : #events }
TRShape >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #accessing }
TRShape >> width [
	^ self encompassingRectangle width
]
