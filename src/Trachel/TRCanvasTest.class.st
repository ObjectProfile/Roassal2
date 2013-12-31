Class {
	#name : #TRCanvasTest,
	#superclass : #TRTest,
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

{ #category : #tests }
TRCanvasTest >> testBox [
	| rec box |
	rec := (50 @ 50 extent: 100 @ 50).
	box := canvas buildRectangle: rec color: Color purple.
	self assert: box rectangle center = rec center.

	box extent: 20 @ 20.
	self assert: box rectangle center = rec center.
]

{ #category : #camera }
TRCanvasTest >> testCamera [

	self assert: canvas camera position = (0 @ 0)
]

{ #category : #tests }
TRCanvasTest >> testCanvas [
	| box |
	box := canvas buildRectangle: ( (5 @ 5) extent: (5 @ 5) ) color: Color red.
	self assert: box canvas == canvas.
	self assert: box athensCanvas == canvas athensCanvas.
	self assert: canvas ~~ canvas athensCanvas.
]

{ #category : #events }
TRCanvasTest >> testCanvasAndEvent [

	| c f |
	c := TRCanvas new.
	f := false.
	c on: TRMouseClick do: [ :event | f := true ].
	self deny: f.
	c announce: TRMouseMove.
	self deny: f.
	c announce: TRMouseClick.
	self assert: f
]

{ #category : #tests }
TRCanvasTest >> testCircle [

	| c  |
	c := TRCanvas new.
	100 to: 200 by: 20 do: [ :i |
		 c buildCircleFrom: 50 @ 50 to: i @ 100 color: (Color red alpha: 0.2).
	].
	self assert: c numberOfShapes = (100 to: 200 by: 20) size 
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

	box translateBy: 10 @ 10.
	
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
TRCanvasTest >> testInitialization [

	| circle |
	circle := TREllipseShape new.
	self assert: circle rectangle = TRAbstractBoxShape nullRectangle
]

{ #category : #tests }
TRCanvasTest >> testLabelShapes [

	| label1 label2 rec |
	label1 := TRLabelShape new.
	label1 text: 'hello'.
	label2 := TRLabelShape new.
	label2 text: 'hello world'.
	self assert: label2 width > label1 width.
	
	rec := label1 encompassingRectangle.
	self assert: rec center = (0 @ 0).
]

{ #category : #tests }
TRCanvasTest >> testLabelShapesHeight [

	| label1 label2 |
	label1 := TRLabelShape new.
	label1 text: 'hello'.
	label2 := TRLabelShape new.
	label2 text: 'hello world'.
	self assert: label2 height = label1 height
]

{ #category : #tests }
TRCanvasTest >> testLine [
	| line |
	line := canvas buildLineFrom: 2 @ 3 to: 13 @ 15 color: Color blue.
	self assert: line from = (2 @ 3).
	self assert: line to = (13 @ 15).
	
	line translateBy: 3 @ 4.
	self assert: line from = (5 @ 7).
	self assert: line to = (16 @ 19).

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

{ #category : #tests }
TRCanvasTest >> testShapingElement [

	| circle |
	circle := canvas buildCircleFrom: 20 @ 20 to: 100 @ 80 color: Color red.

	self assert: circle rectangle = ((20 @ 20) corner: (100 @ 80)).
	
	circle translateBy: -20 @ -20.
	self assert: circle rectangle = ((0 @ 0) corner: (80 @ 60)).
]
