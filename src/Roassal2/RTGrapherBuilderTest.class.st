Class {
	#name : #RTGrapherBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'b'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #running }
RTGrapherBuilderTest >> setUp [
	super setUp.
	b := RTGrapherBuilder new
]

{ #category : #tests }
RTGrapherBuilderTest >> testDefault [
	self deny: b areAxisDefined
]

{ #category : #tests }
RTGrapherBuilderTest >> testGetMaxNumberOfPoints [
	| ds |
	self assert: b getMaxNumberOfPoints equals: 0.
	
	ds := RTDataSet new.
	ds points: (1 to: 5).
	b add: ds.
	
	self assert: b getMaxNumberOfPoints equals: 5.
	
	ds := RTDataSet new.
	ds points: (1 to: 10).
	b add: ds.

	self assert: b getMaxNumberOfPoints equals: 10.
]

{ #category : #tests }
RTGrapherBuilderTest >> testIgnoringEmptyDataSets [

	| ds |
	self assert: b numberOfDataSets equals: 0.
	
	ds := RTDataSet new.
	b add: ds.
	self assert: b numberOfDataSets equals: 0.
	
	ds := RTDataSet new.
	ds points: #(1).
	b add: ds.
	self assert: b numberOfDataSets equals: 1.

]
