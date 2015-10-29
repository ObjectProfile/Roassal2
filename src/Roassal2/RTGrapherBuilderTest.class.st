Class {
	#name : #RTGrapherBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'b'
	],
	#category : #'Roassal2-Builder-Grapher-Tests'
}

{ #category : #running }
RTGrapherBuilderTest >> setUp [
	super setUp.
	b := RTGrapher new
]

{ #category : #tests }
RTGrapherBuilderTest >> testCentralPoint [

	| ds  |
	b := RTGrapher new.

	ds := RTData new.
	ds interaction popupText.
	ds points: #(1 2 3).
	ds x: #yourself.
	ds y: #yourself.
	b add: ds.


	b minY: -2.
	
	b build.
	
	self assert: b centralPoint equals: 0 @ -80.
	self assert: b getAxisX fromPoint equals: 0 @ -80

]

{ #category : #tests }
RTGrapherBuilderTest >> testDefault [
	self deny: b isXAxisDefined.
	self deny: b isYAxisDefined.
]

{ #category : #tests }
RTGrapherBuilderTest >> testGetMaxNumberOfPoints [
	| ds |
	self assert: b getMaxNumberOfPoints equals: 0.
	
	ds := RTData new.
	ds points: (1 to: 5).
	b add: ds.
	
	self assert: b getMaxNumberOfPoints equals: 5.
	
	ds := RTData new.
	ds points: (1 to: 10).
	b add: ds.

	self assert: b getMaxNumberOfPoints equals: 10.
]

{ #category : #tests }
RTGrapherBuilderTest >> testIgnoringEmptyDataSets [

	| ds |
	self assert: b numberOfDataSets equals: 0.
	
	ds := RTData new.
	b add: ds.
	self assert: b numberOfDataSets equals: 0.
	
	ds := RTData new.
	ds points: #(1).
	b add: ds.
	self assert: b numberOfDataSets equals: 1.

]

{ #category : #tests }
RTGrapherBuilderTest >> testIsAxisDefined [

	b := RTGrapher new.
	b add: (RTData new points: #(1 2 3); x: #yourself; y: #yourself).
	
	self deny: b isXAxisDefined.
	self deny: b isYAxisDefined.
	
	b axisXWithNumberOfTicks: 2.
	self assert: b isXAxisDefined.
	self deny: b isYAxisDefined.

	b axisY.
	self assert: b isXAxisDefined.
	self assert: b isYAxisDefined.

	b build.
	self assert: b getAxisX step equals: 3 / 2.
]

{ #category : #tests }
RTGrapherBuilderTest >> testStepOnXAxis [

	b := RTGrapher new.
	b add: (RTData new points: #(1 2 3)).
	b axisXWithNumberOfTicks: 2.
	b build.
	self assert: b getAxisX step equals: 3 / 2.
]

{ #category : #tests }
RTGrapherBuilderTest >> testWithStrangeValues [

	| graphBuilder ds |
	graphBuilder := RTGrapher new.
	graphBuilder extent: 300 @ 200.

	ds := RTData new.
	ds dotShape rectangle size: 0.
	ds points: #(1 3 7 0 6).

	ds y: [ :c | c asInteger ].
	ds barShape rectangle 
	   width: 10;
	   color: Color blue.

	graphBuilder add: ds.
	graphBuilder axisX noLabel; noTick.
	graphBuilder axisY noLabel; noTick.
	graphBuilder build.
	
	self assert: (graphBuilder view elements collect: #position) asArray equals: ((Array new: 9) at: 1 put: ((0@0)); at: 2 put: ((0@ -200)); at: 3 put: ((0@0)); at: 4 put: ((300@0)); at: 5 put: ((50@ -12.5)); at: 6 put: ((100@ -37.5)); at: 7 put: ((150@ -87.5)); at: 8 put: ((200@0.0)); at: 9 put: ((250@ -75.0)); yourself)
]
