Class {
	#name : #RTHorizontalLinePlugin,
	#superclass : #RTAbstractGrapherPlugin,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #drawing }
RTHorizontalLinePlugin >> render [	
	| axis yLine mm |
	axis := builder getAxisY.
	mm := RTMetricNormalizer new.
	(axis minValue to: axis maxValue by: axis step) do: [ :y |
		yLine := mm
						getValue: y
						min: axis fromPoint y 
						max: axis toPoint y
						minValue: axis minValue 
						maxValue: axis maxValue.
		self lineFrom: 	builder getAxisX fromPoint x @ yLine to: builder getAxisX toPoint x @ yLine.
		].
		
		
	
]
