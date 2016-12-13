Class {
	#name : #RTDataSetLabelDecorator,
	#superclass : #RTAbstractGrapherDecorator,
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #hooks }
RTDataSetLabelDecorator >> render [
	| lbl |
	builder datasets
		do: [ :dataSet | 
			lbl := RTLabel new
				color: Color red;
				elementOn: dataSet label.
			self view add: lbl.
			TRConstraint stick: lbl onTheRightOf: dataSet elements last ]
]
