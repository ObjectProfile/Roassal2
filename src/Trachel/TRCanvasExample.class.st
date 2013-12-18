Class {
	#name : #TRCanvasExample,
	#superclass : #Object,
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRCanvasExample >> circle [
	"
	self new circle
	"

	| c  |
	c := TRCanvas new.
	c buildRectangle: (50 @ 50 corner: 80 @ 80 )color: (Color blue alpha: 0.2).

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

{ #category : #'as yet unclassified' }
TRCanvasExample >> rec2 [
	"
	self new rec2
	"

	| c shape |
	c := TRCanvas new.
	shape := c buildRectangle: ((50 @ 50) extent: (150 @ 75)) color: Color red.
	shape on: TRMouseEnter do: [ :evt | Transcript show: evt shape color printString; cr ].
	
	c buildRectangle: ((80 @ 80) extent: (150 @ 75)) color: Color lightGreen.
	c buildLineFrom: 50 @ 50 to: 80 @ 80 color: Color lightGreen.
	"c buildCircleFrom: 80 @ 80 to: 150 @ 75 color: Color blue."
	c open.
	

]
