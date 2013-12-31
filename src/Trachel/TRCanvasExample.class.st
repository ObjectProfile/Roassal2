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
	| c |
	c := TRCanvas new.
	c addShape: (TRLabelShape new).
	c open
]
