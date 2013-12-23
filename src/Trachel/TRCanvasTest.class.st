Class {
	#name : #TRCanvasTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas'
	],
	#category : #Trachel
}

{ #category : #running }
TRCanvasTest >> setUp [

	canvas := TRCanvas new
]

{ #category : #animations }
TRCanvasTest >> testAddingAnimation [
	canvas addAnimation: (RTLinearMove to: 50 @ 50 during: 2 on: RTBox element).
	self assert: canvas hasAnimation.
	self assert: canvas numberOfAnimations = 1
]

{ #category : #contains }
TRCanvasTest >> testContainsPoint1 [
	self assert: (canvas shapeForPosition: 20 @ 20) == canvas
]

{ #category : #contains }
TRCanvasTest >> testContainsPoint2 [
	| box |
	box := canvas buildRectangle: (15 @ 15 extent: 20 @ 20) color: Color gray.
	self assert: (canvas shapeForPosition: 20 @ 20) == box.
	self assert: (canvas shapeForPosition: 35 @ 35) == canvas.
	self assert: (canvas shapeForPosition: 15 @ 15) == box.
	self assert: (canvas shapeForPosition: 200 @ 200) == canvas.
]

{ #category : #contains }
TRCanvasTest >> testContainsPointAfterTranslation [
	| box |
	box := canvas buildRectangle: (0 @ 0 extent: 20 @ 20) color: Color gray.

	box translateTo: 10 @ 10.
	
	self assert: (canvas shapeForPosition: 10 @ 10) == box.
	self assert: (canvas shapeForPosition: 5 @ 5) == canvas.

]

{ #category : #tests }
TRCanvasTest >> testDefault [

	self assert: canvas shapes isEmpty
]

{ #category : #animations }
TRCanvasTest >> testDefaultAnimation [
	self deny: canvas hasAnimation.
	self assert: canvas numberOfAnimations = 0
]

{ #category : #tests }
TRCanvasTest >> testShape [
	| shape |
	shape := canvas buildRectangle: (5 @ 5 extent: 20 @ 20) color: Color gray.
	self assert: shape notNil.

]

{ #category : #events }
TRCanvasTest >> testShapeAndEvent [
	| shape t |
	shape := TRBoxShape new.
	t := false.
	shape on: TRMouseEnter do: [ :event | t := true ].
	self deny: t.
	shape announce: TRMouseEnter new.
	self assert: t
]

{ #category : #events }
TRCanvasTest >> testShapeAndSharedAnnouncer [
	| shape1 shape2 t |
	shape1 := TRBoxShape new.
	shape2 := TRLineShape new.
	shape1 announcer: shape2 announcer.
	
	t := 0.
	shape1 on: TRMouseLeave do: [ :event | t := t + 1 ].
	shape2 on: TRMouseEnter do: [ :event | t := t + 10 ].

	shape1 announce: TRMouseEnter new.
	shape2 announce: TRMouseLeave new.
	self assert: t = 11
]

{ #category : #tests }
TRCanvasTest >> testShapes [

	canvas buildRectangle: (5 @ 5 extent: 20 @ 20) color: Color gray.
	canvas buildRectangle: (5 @ 5 extent: 20 @ 20) color: Color gray.
	self assert: canvas shapes size = 2
]
