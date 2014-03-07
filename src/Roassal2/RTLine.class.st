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
	shape from: anEdge from position to: anEdge to position color: (self colorFor: anEdge).
	^ shape
]
