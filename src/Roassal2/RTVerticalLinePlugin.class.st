Class {
	#name : #RTVerticalLinePlugin,
	#superclass : #RTAbstractLinePlugin,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #drawing }
RTVerticalLinePlugin >> render [	
	| from to |
	values do: [ :aValue |
		from := builder getPixelPositionOf: aValue @ builder minY.
		to := builder getPixelPositionOf: aValue @ builder maxY.
		self lineFrom: from to: to ]
		
	
]
