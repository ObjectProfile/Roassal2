Class {
	#name : #RTVerticalMinValueDecorator,
	#superclass : #RTAbstractVerticalValuesDecorator,
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #drawing }
RTVerticalMinValueDecorator >> render [	
	self add: self datasetValues min. 
	super render.

]
