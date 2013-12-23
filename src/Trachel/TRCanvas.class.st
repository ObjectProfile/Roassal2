Class {
	#name : #TRCanvas,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'shapes',
		'extent',
		'animations'
	],
	#category : #Trachel
}

{ #category : #animations }
TRCanvas >> addAnimation: anAnimation [
	animations add: anAnimation.
	anAnimation start
]

{ #category : #events }
TRCanvas >> announce: anEvent [

	"Do it later"
]

{ #category : #building }
TRCanvas >> buildCircleFrom: aPoint to: anotherPoint color: aColor [
	"Does not work for now"
	|  shape |
	shape := TREllipseShape new.
	shape canvas: canvas.
	shape from: aPoint to: anotherPoint color: aColor.
	shapes add: shape.
	^ shape
]

{ #category : #building }
TRCanvas >> buildLineFrom: aPoint to: anotherPoint color: aColor [

	|  shape |
	shape := TRLineShape new.
	shape canvas: canvas.
	shape from: aPoint to: anotherPoint color: aColor.
	shapes add: shape.
	^ shape
]

{ #category : #building }
TRCanvas >> buildRectangle: aRectangle color: aColor [

	|  shape |
	shape := TRBoxShape new.
	shape canvas: canvas.
	shape fromRectangle: aRectangle color: aColor.
	shapes add: shape.
	^ shape
]

{ #category : #accessing }
TRCanvas >> extent [
	^ extent
]

{ #category : #animations }
TRCanvas >> hasAnimation [
	^ animations notEmpty
]

{ #category : #initialization }
TRCanvas >> initialize [
	super initialize.
	extent := 500 @ 500.
	canvas := AthensCairoSurface extent: extent.
	shapes := OrderedCollection new.
	animations := OrderedCollection new
]

{ #category : #animations }
TRCanvas >> numberOfAnimations [
	^ animations size
]

{ #category : #accessing }
TRCanvas >> numberOfShapes [
	^ shapes size
]

{ #category : #'instance creation' }
TRCanvas >> open [ 
	TRMorph new 
		extent: canvas extent;
		canvas: self;
		openInWindow
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
