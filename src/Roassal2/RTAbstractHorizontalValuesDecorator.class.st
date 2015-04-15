Class {
	#name : #RTAbstractHorizontalValuesDecorator,
	#superclass : #RTAbstractValuesDecorator,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #drawing }
RTAbstractHorizontalValuesDecorator >> render [	
	| position offset tickSize |
	offset := 0 @ 30.
	tickSize := 5.

	values do: [ :aValue |
		position := builder getPixelPositionOf: aValue @ 0.
		self label: (labelConversion rtValue: aValue) asString on: position + offset.
		
		self shape line color: Color gray.
		self lineFrom: position to: position + (0 @ tickSize) ]
		
]
