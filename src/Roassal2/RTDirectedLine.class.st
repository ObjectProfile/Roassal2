Class {
	#name : #RTDirectedLine,
	#superclass : #RTLine,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTDirectedLine >> pointsFrom: from To: to [
	| point mid dist points |
	mid := ((to x + from x) / 2) @ ((to y + from y) / 2).
	from x > to x
		ifTrue: [
			point := from rotateBy: (Float pi /2) about: mid.
			dist := point dist: mid. 
			point := point + (dist/2).
			points := {from.
			point.
			to} asOrderedCollection ]
		ifFalse: [  
			point := from rotateBy: (Float pi /2) about: mid.
			dist := point dist: mid.
			point := point - (dist/2).
			points := {to.
			point.
			from} asOrderedCollection ].
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
