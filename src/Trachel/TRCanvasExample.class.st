Class {
	#name : #TRCanvasExample,
	#superclass : #Object,
	#category : #Trachel
}

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
	c open.
	

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
	r1 on: TRMouseClick do: [ :event | event shape color: colors atRandom. c signalUpdate ].
	r2 on: TRMouseClick do: [ :event | r2 color: colors atRandom. c signalUpdate ].	
		
	r2 setAsFixed.
	
	c on: TRMouseDragging do: [ :event | c camera translateBy: event step negated. c signalUpdate ].
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
