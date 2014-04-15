Class {
	#name : #RTDirectedLine,
	#superclass : #RTLine,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTDirectedLine >> pointsFrom: from To: to [
	| point1 point2 dist1 dist2 mid  points |
	mid := ((to x + from x) / 2) @ ((to y + from y) / 2).
	point1 := from rotateBy: (Float pi /16) about: mid.
	point2 := from rotateBy: (15*(Float pi /16)) about: mid.	
	dist1 := point1 dist: mid.
	dist2 := point2 dist: mid. 	
	"point1 := point1 + (dist1/2).
	point2 := point2 + (dist1/2)."
	points := {from.
	point1.
	point2.
	to} asOrderedCollection.
	^ points
]

{ #category : #hooks }
RTDirectedLine >> trachelShapeFor: anEdge [
	| shape points fromP toP |
	shape := TRBezierShape new.
	shape width: width.
	fromP := anEdge from position.
	toP := anEdge to position.
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
