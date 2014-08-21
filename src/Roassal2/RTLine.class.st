Class {
	#name : #RTLine,
	#superclass : #RTAbstractLine,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTLine >> trachelShapeFor: anEdge [
	| shape |
	shape := TRLineShape new.
	shape width: width.
	shape from: (attachPoint startingPointOf: anEdge) to: (attachPoint endingPointOf: anEdge).
	shape color: (self colorFor: anEdge).
	^ shape
]
