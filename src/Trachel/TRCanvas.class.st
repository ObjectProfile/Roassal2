Class {
	#name : #TRCanvas,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'shapes',
		'extent',
		'animations',
		'morph',
		'camera'
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
TRCanvas >> addShape: shape [
	shapes add: shape.
	shape canvas: self
]

{ #category : #events }
TRCanvas >> announce: anEvent [

	"Do it later"
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
TRCanvas >> extent [
	"size of the canvas"
	^ extent
]

{ #category : #accessing }
TRCanvas >> extent: aPoint [
	"Set of the size of the canvas. Useful, for example, when the window is resized"
	extent := aPoint
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
	animations := OrderedCollection new.
	camera := TRCamera forCanvas: self
]

{ #category : #animations }
TRCanvas >> numberOfAnimations [
	"Return the number of animations contained in the canvas"
	^ animations size
]

{ #category : #accessing }
TRCanvas >> numberOfShapes [
	"Return the number of displayed shapes"
	^ shapes size
]

{ #category : #'instance creation' }
TRCanvas >> open [ 
	morph := TRMorph new 
		canvas: self;
		extent: canvas extent. 
	morph openInWindow
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

{ #category : #accessing }
TRCanvas >> shapeForPosition: position [
	shapes do: [ :s | 
		(s includesPoint: position) ifTrue: [ ^ s ] ].
	^ self
]

{ #category : #accessing }
TRCanvas >> shapes [
	"Return the list of shapes"
	^ shapes
]

{ #category : #updating }
TRCanvas >> signalUpdate [
	morph changed
]
