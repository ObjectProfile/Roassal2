Class {
	#name : #RTAverageDecorator,
	#superclass : #RTAbstractGrapherDecorator,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #drawing }
RTAverageDecorator >> render [
	| values average from to |
	values := self datasetValues.
	average := values average.
	from := builder getPixelPositionOf: builder minX @ average.
	to := builder getPixelPositionOf: builder maxX @ average.
	self lineFrom: from to: to
]
