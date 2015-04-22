Class {
	#name : #RTHorizontalLineDecorator,
	#superclass : #RTAbstractLineDecorator,
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #drawing }
RTHorizontalLineDecorator >> render [	
	| from to |
	values do: [ :aValue |
		from := builder getPixelPositionOf: builder minX @ aValue.
		to := builder getPixelPositionOf: builder maxX @ aValue.
		self lineFrom: from to: to ]
		
	
]
