Class {
	#name : #RTVerticalMaxValueDecorator,
	#superclass : #RTAbstractVerticalValuesDecorator,
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #drawing }
RTVerticalMaxValueDecorator >> render [	
	self add: self datasetValues max. 
	super render.

]
