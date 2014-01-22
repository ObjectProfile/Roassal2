Class {
	#name : #TRCanvas,
	#superclass : #TRObject,
	#instVars : [
		'canvas',
		'shapes',
		'fixedShapes',
		'extent',
		'animations',
		'morph',
		'camera',
		'announcer',
		'color'
	],
	#category : #Trachel
}

{ #category : #animations }
TRCanvas >> addAnimation: anAnimation [
	animations add: anAnimation.
	anAnimation addedIn: self.
	anAnimation start
]

{ #category : #building }
TRCanvas >> addFixedShape: shape [
	fixedShapes add: shape.
	shape canvas: self
]

{ #category : #menu }
TRCanvas >> addMenu: aTitle callback: aBlock [
	| lbl index |
	index := fixedShapes inject: 0 into: [ :s :e | s max: (e encompassingRectangle topRight x + 10) ].
	lbl := TRLabelShape new text: aTitle; leftPosition: index @ 20.
	lbl color: Color black.
	lbl on: TRMouseClick do: [ :event | aBlock value ].
	lbl on: TRMouseEnter do: [ :event | lbl color: Color blue. self signalUpdate ].
	lbl on: TRMouseLeave do: [ :event | lbl color: Color black. self signalUpdate ].
	self addFixedShape: lbl
]

{ #category : #building }
TRCanvas >> addShape: shape [
	shape addedIn: self
]

{ #category : #events }
TRCanvas >> announce: anEvent [
	self announcer announce: anEvent
]

{ #category : #events }
TRCanvas >> announcer [
	announcer isNil ifTrue: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #events }
TRCanvas >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
TRCanvas >> athensCanvas [
	^ canvas
]

{ #category : #building }
TRCanvas >> buildCircleFrom: aPoint to: anotherPoint color: aColor [
	| shape |
	shape := TREllipseShape new.
	shape from: aPoint to: anotherPoint color: aColor.
	self addShape: shape.
	^ shape
]

{ #category : #building }
TRCanvas >> buildLineFrom: aPoint to: anotherPoint color: aColor [
	|  shape |
	shape := TRLineShape new.
	shape from: aPoint to: anotherPoint color: aColor.
	self addShape: shape.
	^ shape
]

{ #category : #'instance creation' }
TRCanvas >> buildMorph [
	morph := TRMorph new
		canvas: self;
		extent: canvas extent.
	^ morph
]

{ #category : #building }
TRCanvas >> buildRectangle: aRectangle color: aColor [
	| shape |
	shape := TRBoxShape new.
	shape fromRectangle: aRectangle color: aColor.
	self addShape: shape.
	^ shape
]

{ #category : #accessing }
TRCanvas >> camera [
	^ camera
]

{ #category : #accessing }
TRCanvas >> color [
	^ color
]

{ #category : #accessing }
TRCanvas >> color: aColor [
	color := aColor.
	self signalUpdate
]

{ #category : #accessing }
TRCanvas >> extent [
	"size of the canvas"
	^ extent
]

{ #category : #accessing }
TRCanvas >> extent: aPoint [
	"Set of the size of the canvas. Useful, for example, when the window is resized"
	extent := aPoint.
	self announce: TRResizeCanvasEvent
]

{ #category : #accessing }
TRCanvas >> fixedShapes [
	^ fixedShapes
]

{ #category : #animations }
TRCanvas >> hasAnimation [
	"True is at least one animation is running"
	^ animations notEmpty
]

{ #category : #initialization }
TRCanvas >> initialize [
	super initialize.
	extent := 500 @ 500.
	canvas := AthensCairoSurface extent: extent.
	shapes := OrderedCollection new.
	fixedShapes := OrderedCollection new.
	animations := OrderedCollection new.
	camera := TRCamera forCanvas: self.
	color := Color lightGray.
]

{ #category : #testing }
TRCanvas >> isFixedShape: aShape [
	^ fixedShapes includes: aShape
]

{ #category : #testing }
TRCanvas >> isMovableShape: aShape [
	^ shapes includes: aShape
]

{ #category : #animations }
TRCanvas >> numberOfAnimations [
	"Return the number of animations contained in the canvas"
	^ animations size
]

{ #category : #accessing }
TRCanvas >> numberOfFixedShapes [
	"Return the number of displayed shapes"
	^ fixedShapes size
]

{ #category : #accessing }
TRCanvas >> numberOfShapes [
	"Return the number of displayed nonfixed shapes"
	^ shapes size 
]

{ #category : #events }
TRCanvas >> on: event do: aBlock [
	self announcer on: event do: aBlock
]

{ #category : #'instance creation' }
TRCanvas >> open [
	^ self openInWindowSized: 500 @ 500
]

{ #category : #'instance creation' }
TRCanvas >> openInWindowSized: anExtentAsPoint [
	| window |
	self buildMorph.
	window := morph openInWindow.
	window extent: anExtentAsPoint.
	^ window
]

{ #category : #'instance creation' }
TRCanvas >> openInWindowSized: anExtentAsPoint titled: aTitle [
	| window |
	window := self openInWindowSized: anExtentAsPoint.
	window setLabel: aTitle.
	^ window
]

{ #category : #'instance creation' }
TRCanvas >> openTitled: aTitle [
	^ self openInWindowSized: 500 @ 500 titled: aTitle
]

{ #category : #animations }
TRCanvas >> playAnimations [
	| shouldClean |
	shouldClean := false.
	animations do: [ :animation | 
		animation refresh. 
		animation hasCompleted ifTrue: [ shouldClean := true ] ].
	
	shouldClean ifTrue: [ 
		animations := animations reject: [ :animation | animation hasCompleted ] ].
]

{ #category : #building }
TRCanvas >> privateAdd: shape [
	shapes add: shape
]

{ #category : #actions }
TRCanvas >> pushBack: aShape [
	shapes remove: aShape.
	shapes addFirst: aShape
]

{ #category : #actions }
TRCanvas >> pushFront: aShape [
	shapes remove: aShape.
	shapes addLast: aShape
]

{ #category : #actions }
TRCanvas >> removeFixedShape: aShape [
	fixedShapes := fixedShapes copyWithout: aShape
]

{ #category : #building }
TRCanvas >> removeShape: shape [
	shapes remove: shape ifAbsent: [ self removeFixedShape: shape ].
	shape canvas: nil
]

{ #category : #actions }
TRCanvas >> setAsFixed: aShape [

	self removeShape: aShape.
	self addFixedShape: aShape.
	

]

{ #category : #accessing }
TRCanvas >> shapeForPosition: position [


	fixedShapes reverseDo: [ :s | 
		(s includesPoint: position) ifTrue: [ ^ s ] ].

	shapes reverseDo: [ :s | 
		(s includesPoint: position) ifTrue: [ ^ s ] ].
	^ self
]

{ #category : #accessing }
TRCanvas >> shapeForPositionInPixels: position [
	"position is in pixel, it corresponds to the physical location in the window.
	e.g., 0 @ 0 is top left of the window"
	fixedShapes reverseDo: [ :s | 
		(s includesPoint: position) ifTrue: [ ^ s ] ].

	shapes reverseDo: [ :s | 
		(s includesPoint: (self camera fromPixelToSpace: position)) ifTrue: [ ^ s ] ].
	^ self
]

{ #category : #accessing }
TRCanvas >> shapes [
	"Return the list of shapes"
	^ shapes asArray
]

{ #category : #updating }
TRCanvas >> signalUpdate [
	morph changed
]

{ #category : #accessing }
TRCanvas >> topLeft [

	^ morph
		ifNil:[ 0@0 ]
		ifNotNil: [ morph topLeft ]
]
