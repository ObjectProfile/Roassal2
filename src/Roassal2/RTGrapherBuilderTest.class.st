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

{ #category : #tests }
RTGrapherBuilderTest >> testWithStrangeValues [

	| graphBuilder ds |
	graphBuilder := RTGrapherBuilder new.
	graphBuilder extent: 300 @ 200.

	ds := RTStackedDataSet new.
	ds dotShape rectangle size: 0.
	ds points: #(1 3 7 0 6).

	ds y: [ :c | c asInteger ].
	ds barShape rectangle 
	   width: 10;
	   color: Color blue.

	graphBuilder add: ds.
	graphBuilder newAxisConfiguration plain.
	graphBuilder axisYWithNumberOfTicks: 0.
	graphBuilder newAxisConfiguration plain.
	graphBuilder axisXWithNumberOfTicks: 0.
	graphBuilder build.
	
	self assert: (graphBuilder view elements collect: #position) asArray equals: ((Array new: 11) at: 1 put: ((0@0)); at: 2 put: ((0@ -200)); at: 3 put: ((0@0)); at: 4 put: ((0@0)); at: 5 put: ((300@0)); at: 6 put: ((0@0)); at: 7 put: ((50@ -14.0)); at: 8 put: ((100@ -42.5)); at: 9 put: ((150@ -100.0)); at: 10 put: ((200@0.0)); at: 11 put: ((250@ -85.5)); yourself)
]
