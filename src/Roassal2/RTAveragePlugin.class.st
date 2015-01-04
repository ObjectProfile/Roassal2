Class {
	#name : #RTAveragePlugin,
	#superclass : #RTAbstractGrapherPlugin,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #drawing }
RTAveragePlugin >> render [
	| values average from to |
	values := self datasetValues.
	average := values average.
	from := builder getPixelPositionOf: builder minX @ average.
	to := builder getPixelPositionOf: builder maxX @ average.
	self lineFrom: from to: to
]
