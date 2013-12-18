Class {
	#name : #TRCanvas,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'shapes',
		'extent'
	],
	#category : #Trachel
}

{ #category : #events }
TRCanvas >> announce: anEvent [

	"Do it later"
]

{ #category : #'as yet unclassified' }
TRCanvas >> buildCircleFrom: aPoint to: anotherPoint color: aColor [
	"Does not work for now"
	|  shape |
	shape := TRCircleShape new.
	shape canvas: canvas.
	shape from: aPoint to: anotherPoint color: aColor.
	shapes add: shape.
	^ shape
]

{ #category : #'as yet unclassified' }
TRCanvas >> buildLineFrom: aPoint to: anotherPoint color: aColor [

	|  shape |
	shape := TRLineShape new.
	shape canvas: canvas.
	shape from: aPoint to: anotherPoint color: aColor.
	shapes add: shape.
	^ shape
]

{ #category : #'as yet unclassified' }
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

{ #category : #initialization }
TRCanvas >> initialize [
	super initialize.
	extent := 500 @ 500.
	canvas := AthensCairoSurface extent: extent.
	shapes := OrderedCollection new
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
