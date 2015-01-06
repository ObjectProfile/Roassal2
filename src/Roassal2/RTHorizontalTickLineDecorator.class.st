Class {
	#name : #RTHorizontalTickLineDecorator,
	#superclass : #RTAbstractTickLineDecorator,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #drawing }
RTHorizontalTickLineDecorator >> render [	
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
		]
]
