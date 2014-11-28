Class {
	#name : #RTStackedDataSetTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #tests }
RTStackedDataSetTest >> testDefault [

	| ds |
	ds := RTStackedDataSet new.
	self assert: ds numberOfPoints equals: 0
]
