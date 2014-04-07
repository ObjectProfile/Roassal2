Class {
	#name : #RTArrowedLine,
	#superclass : #RTLine,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTArrowedLine >> trachelShapeFor: anEdge [
	| shape |
	shape := TRArrowedLineShape new.
	shape width: width.
	shape from: anEdge from position to: anEdge to position color: (self colorFor: anEdge).
	^ shape
]
