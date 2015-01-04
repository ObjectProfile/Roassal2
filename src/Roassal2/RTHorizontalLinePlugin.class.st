Class {
	#name : #RTHorizontalLinePlugin,
	#superclass : #RTAbstractLinePlugin,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #drawing }
RTHorizontalLinePlugin >> render [	
	| from to |
	values do: [ :aValue |
		from := builder getPixelPositionOf: builder minX @ aValue.
		to := builder getPixelPositionOf: builder maxX @ aValue.
		self lineFrom: from to: to ]
		
	
]
