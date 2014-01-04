Class {
	#name : #RTLine,
	#superclass : #RTAbstractLine,
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTLine >> trachelShape [
	|  shape aPoint anotherPoint aColor |
	shape := TRLineShape new.
	shape from: aPoint to: anotherPoint color: aColor.
	^ shape
]

{ #category : #'as yet unclassified' }
RTLine >> trachelShapeFor: anEdge [
	| shape |
	shape := TRLineShape new.
	shape from: anEdge from position to: anEdge to position color: (self colorFor: anEdge).
	^ shape
]
