Class {
	#name : #RTDirectedLine,
	#superclass : #RTLine,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTDirectedLine >> pointsFrom: from To: to [

	| point mid   |
	mid := (to + from) / 2.
	point := from + ((mid - from) rightRotated).
	"(to - from) abs / 2"
	^ { from . point . to }



"	| point1 point2 mid   |
	mid := ((to x + from x) / 2) @ ((to y + from y) / 2).
	point1 := from rotateBy: (Float pi /16) about: mid.
	point2 := from rotateBy: (15*(Float pi /16)) about: mid.	
	^ {from.
	point1.
	point2.
	to}
"
]

{ #category : #hooks }
RTDirectedLine >> trachelShapeFor: anEdge [
	| shape points fromP toP |
	shape := TRBezierShape new.
	shape width: width.
	fromP := attachPoint startingPointOf: anEdge.
	toP := attachPoint endingPointOf: anEdge.
	points := self pointsFrom: fromP To: toP.
	shape points: points color: (self colorFor: anEdge).
	^ shape
]

{ #category : #'as yet unclassified' }
RTDirectedLine >> updateFor: edge trachelShape: trachelShape [
	trachelShape points: (self pointsFrom: (attachPoint startingPointOf: edge) To: (attachPoint endingPointOf: edge)).
	trachelShape color: (self colorFor: edge).
	trachelShape width: (self widthFor: edge).
	trachelShape resetPath

]
