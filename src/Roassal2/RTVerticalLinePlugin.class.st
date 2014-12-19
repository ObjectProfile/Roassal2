Class {
	#name : #RTVerticalLinePlugin,
	#superclass : #RTAbstractGrapherPlugin,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #drawing }
RTVerticalLinePlugin >> render [	
	| axis xLine mm |
	axis := builder getAxisX.
	mm := RTMetricNormalizer new.
	(axis minValue to: axis maxValue by: axis step) do: [ :x |
		xLine := mm
						getValue: x
						min: axis fromPoint x
						max: axis toPoint x
						minValue: axis minValue 
						maxValue: axis maxValue.
		self lineFrom: xLine @ builder getAxisY fromPoint y to: xLine @ builder getAxisY toPoint y
		].
		
		
	
]
