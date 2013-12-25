Class {
	#name : #RTLine,
	#superclass : #RTAbstractLine,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTLine >> renderOn: trachelCanvas for: anEdge [
	"w := self widthFor: anEdge."
	self halt.
	^ trachelCanvas buildLineFrom: anEdge from position to: anEdge to position color: (self colorFor: anEdge)
]

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
