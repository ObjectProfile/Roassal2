Class {
	#name : #TRCanvasExample,
	#superclass : #Object,
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRCanvasExample >> animationTest [
	"
	self new animationTest
	"
	| canvas circle |
	canvas := TRCanvas new.
	circle := canvas buildCircleFrom: 50 @ 50 to: 100 @ 80 color: (Color purple alpha: 0.2).
	canvas addAnimation: (RTLinearMove to: 100 @ 100 during: 2000 on: circle). 
	canvas open
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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
