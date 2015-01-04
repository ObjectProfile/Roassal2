Class {
	#name : #RTVerticalTickLinePlugin,
	#superclass : #RTAbstractTickLinePlugin,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #drawing }
RTVerticalTickLinePlugin >> render [	
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
		]
]
