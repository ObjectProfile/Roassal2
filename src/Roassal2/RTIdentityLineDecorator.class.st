Class {
	#name : #RTIdentityLineDecorator,
	#superclass : #RTAbstractLineDecorator,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #drawing }
RTIdentityLineDecorator >> render [	 
	| min max |
	min := builder getPixelPositionOf: builder minX @ builder minY.
	max := builder getPixelPositionOf: builder maxX @ builder maxY.

	self lineFrom: min to: max
]
