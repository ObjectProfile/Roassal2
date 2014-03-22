Class {
	#name : #TRCanvasExample,
	#superclass : #TRObject,
	#category : #'Trachel-Core'
}

{ #category : #animation }
TRCanvasExample >> animatedArc [
	"
	self new animatedArc
	"

	| v e angle timer |
	v := TRCanvas new.
	timer := VITimer new cycleLength: 2.
	timer repeat.
	angle := VIAnimatedValue new
					evaluator: [ :t | 0 interpolateTo: 360 at: t ];
					timer: timer;
					yourself.
					
	e := (TRArcShape new 
			alphaAngle: angle betaAngle: (angle + 30) innerRadius: 50 externalRadius: 80).
	v addShape: e.
	angle start.

	v addAnimation: (TRResetAllShapes new).
	v open
]

{ #category : #arcs }
TRCanvasExample >> arc [
	"
	self new arc
	"
	| c  shape|
	c := TRCanvas new.
	shape:= TRArcShape new.
	shape alphaAngle:10  betaAngle: 80  innerRadius: 30 externalRadius: 150. 
	shape color: Color blue.
	c addShape: shape.
	c open.
	

]

{ #category : #arcs }
TRCanvasExample >> arc0 [
	"
	self new arc0
	"
	| c shape |
	c := TRCanvas new.
	shape:= TRArcShape new.
	shape alphaAngle:0  betaAngle: 360  innerRadius: 0 externalRadius: 100. 
	shape color: Color blue.
	c addShape: shape.
	c open.
	

]

{ #category : #arcs }
TRCanvasExample >> arc2 [
	"
	self new arc
	"
	| c  shape1 shape2 shape3 shape4|
	c := TRCanvas new.
	shape1:= TRArcShape new.
	shape2:= TRArcShape new.
	shape3:= TRArcShape new.
	shape4:= TRArcShape new.
	shape1 alphaAngle:10  betaAngle: 80 innerRadius: 30 externalRadius: 150. 
	shape1 color: Color blue.
	shape2 alphaAngle:100  betaAngle: 170 innerRadius: 30 externalRadius: 150. 
	shape2 color: Color green.
	shape3 alphaAngle:190  betaAngle: 260 innerRadius: 30 externalRadius: 150. 
	shape3 color: Color yellow.
	shape4 alphaAngle:280  betaAngle: 350 innerRadius: 30 externalRadius: 150. 
	shape4 color: Color red.
	c addShape: shape1.c addShape: shape2. c addShape: shape3. c addShape: shape4.
	c open.
	

]

{ #category : #arcs }
TRCanvasExample >> arc3 [
	"
	self new arc3
	"
	| c  shape1 shape2 shape3 shape4|
	c := TRCanvas new.
	shape1:= TRArcShape new.
	shape2:= TRArcShape new.
	shape3:= TRArcShape new.
	shape4:= TRArcShape new.
	shape1 alphaAngle:5  betaAngle: 85 innerRadius: 30 externalRadius: 150. 
	shape1 color: Color blue.
	shape2 alphaAngle:95  betaAngle: 175 innerRadius: 30 externalRadius: 150. 
	shape2 color: Color green.
	shape3 alphaAngle:185  betaAngle: 265 innerRadius: 30 externalRadius: 150. 
	shape3 color: Color yellow.
	shape4 alphaAngle:275  betaAngle: 355 innerRadius: 30 externalRadius: 150. 
	shape4 color: Color red.
	c addShape: shape1.c addShape: shape2. c addShape: shape3. c addShape: shape4.
	c open.
	

]

{ #category : #arcs }
TRCanvasExample >> arc4 [
	"
	self new arc4
	"
	| c  shape1 shape2 shape3 shape4|
	c := TRCanvas new.
	shape1:= TRArcShape new.
	shape2:= TRArcShape new.
	shape3:= TRArcShape new.
	shape4:= TRArcShape new.
	shape1 alphaAngle:0  betaAngle: 90 innerRadius: 130 externalRadius: 150. 
	shape1 color: Color blue.
	shape2 alphaAngle:90  betaAngle: 180 innerRadius: 130 externalRadius: 150. 
	shape2 color: Color green.
	shape3 alphaAngle:180  betaAngle: 270 innerRadius: 130 externalRadius: 150. 
	shape3 color: Color yellow.
	shape4 alphaAngle:270  betaAngle: 360 innerRadius: 130 externalRadius: 150. 
	shape4 color: Color red.
	c addShape: shape1.c addShape: shape2. c addShape: shape3. c addShape: shape4.
	c open.
	

]

{ #category : #arcs }
TRCanvasExample >> arc5 [
	"
	self new arc5
	"
	| c  shape1 shape2 shape3 shape4|
	c := TRCanvas new.
	shape1:= TRArcShape new.
	shape2:= TRArcShape new.
	shape3:= TRArcShape new.
	shape4:= TRArcShape new.
	shape1 alphaAngle:0  betaAngle: 90 innerRadius: 0 externalRadius: 150. 
	shape1 color: Color blue.
	shape2 alphaAngle:90  betaAngle: 180 innerRadius: 0 externalRadius: 150. 
	shape2 color: Color green.
	shape3 alphaAngle:180  betaAngle: 270 innerRadius: 0 externalRadius: 150. 
	shape3 color: Color yellow.
	shape4 alphaAngle:270  betaAngle: 360 innerRadius: 0 externalRadius: 150. 
	shape4 color: Color red.
	c addShape: shape1.c addShape: shape2. c addShape: shape3. c addShape: shape4.
	c open.
	

]

{ #category : #arcs }
TRCanvasExample >> arc6 [
	"
	self new arc6
	"
	| c  shape shape2|
	c := TRCanvas new.
	shape:= TRArcShape new.
	shape alphaAngle:10  betaAngle: 80  innerRadius: 30 externalRadius: 150. 
	shape color: Color blue.
	shape2:=TRBoxShape new.
	shape2 rectangle: (shape topLeft corner: shape bottomRight).
	shape2 color: Color red.
	c addShape: shape.
	c addShape: shape2.
	c open.
	

]

{ #category : #arcs }
TRCanvasExample >> arc7 [
	"
	self new arc7
	"
	| c shape|
	c := TRCanvas new.
	1 to: 90 by: 10 do: [ :angle |
		shape:= TRArcShape new.
		shape alphaAngle: 0  betaAngle: (angle)  innerRadius: 30 externalRadius: 150. 
		shape color: (Color blue alpha: 0.2).
		c addShape: shape ].
	c open.
	

]

{ #category : #examples }
TRCanvasExample >> bezier [

	| t points |
	points := OrderedCollection new.
	points add: 50 @ 50.
	points add: 150 @ 20.
	points add: 120 @ 130.
	points add: 50 @ 150.
	points add: 80 @ 80.
	t := TRCanvas new.
	t addShape: (TRLineShape  new from: 50 @ 50 to: 130 @ 20).
	t addShape: (TRBezierShape new 
		points: points; 
			strokePaint: Color purple).
	t open
]

{ #category : #examples }
TRCanvasExample >> circle [
	"
	self new circle
	"
	| c  |
	c := TRCanvas new.
	c buildRectangle: (50 @ 50 corner: 80 @ 80) color: (Color blue alpha: 0.2).

	100 to: 200 by: 20 do: [ :i |
		 c buildCircleFrom: 50 @ 50 to: i @ 100 color: (Color red alpha: 0.1).
	].
	c openTitled: 'Example with transparent circles'.
	

]

{ #category : #examples }
TRCanvasExample >> circle2 [
	"
	self new circle2
	"

	| c circle line1 line2 |
	c := TRCanvas new.
	circle := TREllipseShape new from: -50 @ -50 to: 50 @ 50.
	circle color: (Color purple alpha: 0.3).
	line1 := TRLineShape new from: -50 @ 0 to: 50 @ 0.
	line2 := TRLineShape new from: 0 @ -50 to: 0 @ 50.
	line1 color: (Color blue alpha: 0.5).
	line2 color: (Color blue alpha: 0.5).
	
	c addShape: circle.
	c addShape: line1.
	c addShape: line2.
	c open
]

{ #category : #events }
TRCanvasExample >> event01 [

	"
	self new event01
	"
	| s1 s2 c |
	s1 := TRBoxShape new color: (Color blue alpha: 0.8); size: 80; strokePaint: nil.	
	s2 := TREllipseShape new size: 100; color: (Color green alpha: 0.8); strokePaint: nil.
	c := TRCanvas new.

	c addShape: s1.
	c addShape: s2.

	s1 when: TRMouseDragging do: [ :e | 
		s1 translateBy: e step.  
		e signalUpdate ].
	c open
]

{ #category : #'rotating labels' }
TRCanvasExample >> fiveLabelFlowers [
	"
	self new fiveLabelFlowers.
	"
	| t label box points |
	t := TRCanvas new.
	t color: Color white.

	points := OrderedCollection new.
	points add: 0 @ 0.
	points add: 150 @ 150.
	points add: -150 @ -150.
	points add: 150 @ -150.
	points add: -150 @ 150.
	points do: [ :position |
		1 to: 180 by: 25 do: [ :angle |
			box := TRBoxShape new.
			box from: position -1 to: position + 1.
			box color: (Color blue alpha: 0.5).
			t addShape: box.
			
			label := TRRotatedLabelShape new.
			label text: 'Hello World Bonjour Monde'.
			label color: Color black.
			label position: position.
			label angleInDegree: angle.
			t addShape: label ] ].
	
	t open
]

{ #category : #examples }
TRCanvasExample >> fixedRec [
	"
	self new fixedRec
	"

	| c r1 r2 colors |
	c := TRCanvas new.
	r1 := c buildRectangle: ((0 @ 0) extent: (150 @ 75)) color: Color red.
	r2 := c buildRectangle: ((0 @ 0) extent: (130 @ 50)) color: Color lightGreen.
	c buildLineFrom: 50 @ 50 to: 80 @ 80 color: Color lightGreen.
	
	colors := Array with: Color red with: Color blue with: Color white.
	r1 when: TRMouseClick do: [ :event | event shape color: colors atRandom. c signalUpdate ].
	r2 when: TRMouseClick do: [ :event | r2 color: colors atRandom. c signalUpdate ].	
		
	r2 setAsFixed.
	
	c when: TRMouseDragging do: [ :event | c camera translateBy: event step negated. c signalUpdate ].
	c open
]

{ #category : #examples }
TRCanvasExample >> label [
	"
	self new label
	"
	| c |
	c := TRCanvas new.
	c addShape: (TRLabelShape new fontSize: 5).
	c addShape: (TRLabelShape new fontSize: 25; position: 20 @ 20).
	c open
]

{ #category : #menu }
TRCanvasExample >> menu1 [
	"
	self new menu1
	"
	| canvas |
	canvas := TRCanvas new.
	canvas addMenu: '+ box' callback: [ canvas addShape: (TRBoxShape new color: (Color purple alpha: 0.1); from: (400 atRandom @ 400 atRandom) extent: (100 atRandom @ 100 atRandom)). canvas signalUpdate ].

	canvas addMenu: '+ circle' callback: [ canvas addShape: (TREllipseShape new color: (Color blue alpha: 0.1); from: (400 atRandom @ 400 atRandom) extent: (100 atRandom @ 100 atRandom)). canvas signalUpdate ].	
	canvas camera translateTo: 250 @ 250.
	canvas open
]

{ #category : #events }
TRCanvasExample >> mouseMove [
	"
	self new mouseMove
	"
	| c lbl |
	c := TRCanvas new.
	lbl := TRLabelShape new text: 'pos'.
	c addShape: lbl.
	
	c when: TRMouseMove do: [ :evt | lbl text: (c camera fromPixelToSpace: evt position) printString. c signalUpdate ].
	c open
]

{ #category : #examples }
TRCanvasExample >> rec1 [
	"
	self new rec1
	"

	| c |
	c := TRCanvas new.
	c buildRectangle: ((50 @ 50) extent: (150 @ 75)) color: Color red.
	c buildRectangle: ((80 @ 80) extent: (150 @ 75)) color: Color lightGreen.
	c buildLineFrom: 50 @ 50 to: 80 @ 80 color: Color lightGreen.
	c open
]

{ #category : #examples }
TRCanvasExample >> text [
	"
	self new text
	"
	| c label rec |
	c := TRCanvas new.
	label := TRLabelShape new.
	rec := TRBoxShape new color: Color white.
	rec fromRectangle: label encompassingRectangle.
	c addShape: rec.
	c addShape: label.
	c open
]
