Class {
	#name : #TRCanvasTest,
	#superclass : #TRTest,
	#instVars : [
		'canvas'
	],
	#category : #'Trachel-Core'
}

{ #category : #running }
TRCanvasTest >> setUp [

	canvas := TRCanvas new
]

{ #category : #'fixed shape' }
TRCanvasTest >> testAccessing [
	| c r1 r2 |
	c := TRCanvas new.
	r1 := c buildRectangle: ((0 @ 0) extent: (150 @ 75)) color: Color red.
	r1 setAsFixed.
	
	r2 := c buildRectangle: ((0 @ 0) extent: (130 @ 50)) color: Color lightGreen.

	self assert: (c shapeForPositionInPixels: (0 @ 0)) = r1.
	self assert: (c shapeForPositionInPixels: (250 @ 250)) = r2.
]

{ #category : #tests }
TRCanvasTest >> testAddingAndRemoving [

	| box |
	box := TRBoxShape new from: 10 @ 10 to: 20 @ 20.
	canvas addShape: box.
	self assert: canvas numberOfShapes = 1.
	box remove.
	self assert: canvas numberOfShapes = 0.
]

{ #category : #'back and front' }
TRCanvasTest >> testBack [

	| s1 s2 s3 |
	s1 := TRBoxShape new size: 10.
	s2 := TRBoxShape new size: 10.
	s3 := TRBoxShape new size: 10.
	canvas addShape: s1; addShape: s2; addShape: s3.
	
	s1 pushBack.
	self assert: canvas shapes = (Array with: s1 with: s2 with: s3).
	
	s3 pushBack.
	self assert: canvas shapes = (Array with: s3 with: s1 with: s2).
]

{ #category : #tests }
TRCanvasTest >> testBezierShape [
	| b |
	b := TRBezierShape new points: (Array with: 10 @ 10 with: -20 @ 30 with: 50 @ -180).
	canvas addShape: b.
	b translateBy: 5 @ 6.
	self assert: b points = (Array with: 15 @ 16 with: -15 @ 36 with: 55 @ -174).

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
	c when: TRMouseClick do: [ :event | f := true ].
	self deny: f.
	c announce: TRMouseMove.
	self deny: f.
	c announce: TRMouseClick.
	self assert: f
]

{ #category : #events }
TRCanvasTest >> testCapturingEvents2 [
	| s1 s2 |
	 
	s1 := (TRBoxShape new size: 10).
	s2 := (TRBoxShape new size: 10).
	canvas addShape: s1.
	canvas addShape: s2. 
	self assert: (canvas shapeForPosition: 0 @ 0) == s2
]

{ #category : #label }
TRCanvasTest >> testCenteredLabelShapes [

	| label1 label2  |
	label1 := TRLabelShape new.
	label1 text: 'hello'.
	label1 position: 10 @ 10.

	label2 := TRLabelShape new.
	label2 text: 'hello'.
	label2 leftPosition: label1 encompassingRectangle leftCenter.
	
	"
	TRCanvas new addShape: label1; addShape: label2; open
	"

	self assert: label1 encompassingRectangle = label2 encompassingRectangle
]

{ #category : #shapes }
TRCanvasTest >> testChangingBoxHeight [
	| box |
	box := TRBoxShape new.
	self assert: box height = 0.
	box height: 15.
	self assert: box height = 15.
	box height: 20.
	self assert: box height = 20

]

{ #category : #shapes }
TRCanvasTest >> testChangingBoxWidth [
	| box |
	box := TRBoxShape new.
	self assert: box width = 0.
	box width: 15.
	self assert: box width = 15.
	box width: 20.
	self assert: box width = 20

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

{ #category : #composing }
TRCanvasTest >> testComposing [

	| s1 s2 c trCanvas |
	s1 := TRBoxShape new.
	s2 := TRBoxShape new.
	c := TRComposedShape with: s1 with: s2.
	trCanvas := TRCanvas new.
	trCanvas addShape: c.
	self assert: trCanvas numberOfShapes = 2.
	
	c remove.
	self assert: trCanvas numberOfShapes = 0.
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

{ #category : #label }
TRCanvasTest >> testDefaultFontSize [
	self assert: (TRLabelShape new fontSize = TRLabelShape new defaultFontSize)
]

{ #category : #'fixed shape' }
TRCanvasTest >> testFixedShapes [

	| s1 s2 |
	s1 := TRBoxShape new from: 10 @ 20 extent: 50 @ 40.
	s2 := TRBoxShape new from: 10 @ 20 extent: 50 @ 40.
	canvas addShape: s1; addShape: s2.
	
	self assert: s1 isNotFixed.
	self assert: s2 isNotFixed.
	
	s2 setAsFixed.
	self assert: s1 isNotFixed.
	self deny: s2 isNotFixed.
	
	s2 setAsNotFixed.
	self assert: s1 isNotFixed.
	self assert: s2 isNotFixed.

]

{ #category : #'back and front' }
TRCanvasTest >> testFront [

	| s1 s2 s3 |
	s1 := TRBoxShape new size: 10.
	s2 := TRBoxShape new size: 10.
	s3 := TRBoxShape new size: 10.
	canvas addShape: s1; addShape: s2; addShape: s3.
	
	self assert: canvas shapes = (Array with: s1 with: s2 with: s3).
	
	s1 pushFront.
	self assert: canvas shapes = (Array with: s2 with: s3 with: s1).
	
	s3 pushFront.
	self assert: canvas shapes = (Array with: s2 with: s1 with: s3).
]

{ #category : #tests }
TRCanvasTest >> testInitialization [

	| circle |
	circle := TREllipseShape new.
	self assert: circle rectangle = TRAbstractBoxShape nullRectangle
]

{ #category : #label }
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

{ #category : #label }
TRCanvasTest >> testLabelShapesAndColor [

	| label  |
	label := TRLabelShape new.
	label color: Color blue.
	self assert: label color = Color blue
]

{ #category : #label }
TRCanvasTest >> testLabelShapesAndIncludesPoint [

	| label rec |
	label := TRLabelShape new.
	label text: 'hello'.
	
	rec := label encompassingRectangle.
	self assert: (label includesPoint: rec topLeft).
	self assert: (label includesPoint: (rec bottomLeft - (0 @ 1))).
	self assert: (label includesPoint: rec topRight - (1 @ 0)).
	self assert: (label includesPoint: rec bottomRight - (1 @ 1)).
]

{ #category : #label }
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

{ #category : #shapes }
TRCanvasTest >> testPositionWithShapes [

	TRShape allSubclasses do: [ :c |
		self assert: c new position = (0 @ 0) ]
]

{ #category : #'fixed shape' }
TRCanvasTest >> testRemovingFixedElement [
	| c r |
	c := TRCanvas new.
	r := c buildRectangle: ((0 @ 0) extent: (150 @ 75)) color: Color red.
	r setAsFixed.

	self assert: c numberOfFixedShapes = 1.
	self assert: c numberOfShapes = 0.
	r remove.
	self assert: c numberOfShapes = 0.
	self assert: c numberOfFixedShapes = 0.
]

{ #category : #tests }
TRCanvasTest >> testRemovingLine [

	| line |
	line := TRLineShape new from: 50 @ 50 to: 100 @ 80.
	self deny: line isInACanvas.
	canvas addShape: line.
	self assert: line isInACanvas.
	
	line remove.
	self deny: line isInACanvas.
	
	line remove.
	self deny: line isInACanvas.

]

{ #category : #resizing }
TRCanvasTest >> testResizing [

	| t |
	t := false.
	canvas when: TRResizeCanvasEvent do: [ :evt | t := true ].
	canvas extent:  12 @ 12.
	self assert: t
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
	shape when: TRMouseEnter do: [ :event | t := true ].
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
	shape1 when: TRMouseLeave do: [ :event | t := t + 1 ].
	shape2 when: TRMouseEnter do: [ :event | t := t + 10 ].

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

{ #category : #'should be drawn' }
TRCanvasTest >> testShouldBeDrawn [

	self assert: (TRBoxShape new from: 0 @ 0 to: 10 @ 20) shouldBeDrawn.
	self deny: (TRBoxShape new from: 200 @ 0 to: 10 @ 0) shouldBeDrawn.
	self deny: (TRBoxShape new from: 200 @ 0 to: 200 @ 0) shouldBeDrawn.
	self deny: (TREllipseShape new from: 0 @ 0 to: 0 @ 0) shouldBeDrawn.
	self assert: (TREllipseShape new from: 10 @ 0 to: 50 @ 50) shouldBeDrawn
]

{ #category : #label }
TRCanvasTest >> testSizeAndLabels [

	| c l1 l2 |
	c := TRCanvas new.
	l1 := TRLabelShape new fontSize: 10.
	l2 := TRLabelShape new fontSize: 15; position: 20 @ 20.
	c addShape: l1.
	c addShape: l2.
	
	self assert: l1 font ~~ l2 font
	
]
