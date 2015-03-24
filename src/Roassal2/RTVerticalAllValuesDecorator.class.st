Class {
	#name : #RTVerticalAllValuesDecorator,
	#superclass : #RTAbstractVerticalValuesDecorator,
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #drawing }
RTVerticalAllValuesDecorator >> render [	
	self addAll: self datasetValues asSet. 
	super render.

]
