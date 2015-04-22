Class {
	#name : #RTVerticalAllValuesDecorator,
	#superclass : #RTAbstractVerticalValuesDecorator,
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #drawing }
RTVerticalAllValuesDecorator >> render [	
	self addAll: self datasetValues asSet. 
	super render.

]
