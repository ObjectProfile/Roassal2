"
Add vertical line, one per tick.

Here is an example:
g := RTGrapher new.
d := RTData new.
d connectColor: Color blue.
d noDot.
d points: (-3.14 to: 3.14 by: 0.1).
d y: #sin.
d x: #yourself.
g add: d.
g addDecorator: (RTVerticalTickLineDecorator new).
g addDecorator: (RTHorizontalTickLineDecorator new).
g
"
Class {
	#name : #RTVerticalTickLineDecorator,
	#superclass : #RTAbstractTickLineDecorator,
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #hooks }
RTVerticalTickLineDecorator >> axis [
	^ builder getAxisX
]

{ #category : #drawing }
RTVerticalTickLineDecorator >> render [
	| xLine mm |
	mm := RTMetricNormalizer new.
	(self minValue to: self maxValue by: self step)
		do: [ :x | 
			xLine := mm
				getValue: x
				min: self fromPoint x
				max: self toPoint x
				minValue: self minValue
				maxValue: self maxValue.
			self lineFrom: xLine @ builder getAxisY fromPoint y to: xLine @ builder getAxisY toPoint y ]
]
