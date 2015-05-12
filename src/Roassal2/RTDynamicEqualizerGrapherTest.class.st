"
A RTDynamicEqualizerGrapherTest is a test class for testing the behavior of RTDynamicEqualizerGrapher
"
Class {
	#name : #RTDynamicEqualizerGrapherTest,
	#superclass : #TestCase,
	#instVars : [
		'b'
	],
	#category : #'Roassal2-Builder-Grapher-Tests'
}

{ #category : #running }
RTDynamicEqualizerGrapherTest >> setUp [
	super setUp.
	b := RTDynamicEqualizerGrapher new
]

{ #category : #tests }
RTDynamicEqualizerGrapherTest >> testBasic [
	self assert: b numberOfMetrics equals: 0
]

{ #category : #tests }
RTDynamicEqualizerGrapherTest >> testScenario01 [
 
	b maxY: 20.
	b minY: 20.
	b addName: 'X1' metric: [ :anArray | anArray first ].
	b addName: 'Y1' metric: [ :anArray | anArray second ].
	b addName: 'Z1' metric: [ :anArray | anArray third ].
	b addName: 'X2' metric: [ :anArray | anArray fourth ].
	b addName: 'Y2' metric: [ :anArray | anArray fifth ].
	b addName: 'Z2' metric: [ :anArray | anArray sixth ].

	self assert: b numberOfMetrics equals: 6.
	
	b object: #(1 2 3 4 5 6).
	
]
