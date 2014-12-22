Class {
	#name : #RTDataSetTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #'as yet unclassified' }
RTDataSetTest >> testBasic [

	| charter |
	charter := RTGrapherBuilder new.
	charter add: (RTDataSet new points: #(#(1 2) #(3 4) #(2 5)); x: #first; y: #second).
	charter build.
]

{ #category : #'as yet unclassified' }
RTDataSetTest >> testDefault [
	self assert: RTDataSet new points isEmpty.
	self deny: RTDataSet new shouldConnect
]

{ #category : #'as yet unclassified' }
RTDataSetTest >> testNonTrivialGraph [

	| grapher dataSet |
	grapher := RTGrapherBuilder new.
	grapher extent: 300 @ 200.
	dataSet := RTDataSet new 
		points: RTObject withAllSubclasses; 
		x: #numberOfLinesOfCode; 
		y: #numberOfMethods.
	dataSet dotShape color: (Color red alpha: 0.3).
	grapher add: dataSet.
	grapher axisX; axisY.
	grapher build
	
]
