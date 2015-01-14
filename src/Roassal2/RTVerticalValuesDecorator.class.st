Class {
	#name : #RTVerticalValuesDecorator,
	#superclass : #RTAbstractLineDecorator,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #'as yet unclassified' }
RTVerticalValuesDecorator >> render [	
	| position offset tickSize |
	offset := -30 @ 0.
	tickSize := 5.
	values do: [ :aValue |
		position := builder getPixelPositionOf: 0 @ aValue.
		self label: aValue asString on: position + offset.
		
		self shape line color: Color gray.
		self lineFrom: position to: position - (tickSize @ 0) ]
		
]
