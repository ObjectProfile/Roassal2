Class {
	#name : #RTVerticalMaxValueDecorator,
	#superclass : #RTAbstractVerticalValuesDecorator,
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #'as yet unclassified' }
RTVerticalMaxValueDecorator >> render [	
	self add: self datasetValues max. 
	super render.

]
