Class {
	#name : #RTDataSetTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-Grapher-Tests'
}

{ #category : #tests }
RTDataSetTest >> testBasic [

	| charter |
	charter := RTGrapher new.
	charter add: (RTDataSet new points: #(#(1 2) #(3 4) #(2 5)); x: #first; y: #second).
	charter build.
]

{ #category : #tests }
RTDataSetTest >> testComputeMinAndMax [

	| b ds |
	b := RTGrapher new.

	ds := RTDataSet new.
	ds points: #(1 2 3).
	ds x: #yourself.
	ds y: #yourself.
	b add: ds.

	b maxY: 5.
	b build.
	
	self assert: b centralPoint equals: 0 @ 0.
	self assert: ds minX equals: 0.
	self assert: ds maxX equals: 3.
	
	self assert: b maxY equals: 5.
	self assert: ds minY equals: 0.
	self assert: ds maxY equals: 5.
]

{ #category : #tests }
RTDataSetTest >> testConnectColor [

	| b ds |
	b := RTGrapher new.

	ds := RTDataSet new.
	ds connectColor: Color blue.
	ds points: #(1 2 3).
	ds x: #yourself.
	ds y: #yourself.
	b add: ds.

	b build.
	
	self assert: b view numberOfEdges equals: 4.
	self assert: b view edges last trachelShape color equals: Color blue.
]

{ #category : #tests }
RTDataSetTest >> testDefault [
	self assert: RTDataSet new points isEmpty.
	self deny: RTDataSet new shouldConnect
]

{ #category : #tests }
RTDataSetTest >> testGetValues01 [
	| ds |
	ds := RTDataSet new.
	ds points: #(3 4 5).

	self assert: ds getValuesX equals: #(3 4 5).
	self assert: ds getValuesY equals: #(3 4 5).	
]

{ #category : #tests }
RTDataSetTest >> testGetValues02 [
	| ds |
	ds := RTDataSet new.
	ds points: #(3 4 5).
	ds x: [ :v | v + 2 ].
	ds y: [ :v | v + 3 ].

	self assert: ds getValuesX equals: #(5 6 7).
	self assert: ds getValuesY equals: #(6 7 8).	
]

{ #category : #tests }
RTDataSetTest >> testInteraction [

	| ds |
	ds := RTDataSet new.
	self assert: ds interaction class equals: RTInteractionBuilder
]

{ #category : #tests }
RTDataSetTest >> testNoDot [

	| b ds |
	b := RTGrapher new.

	ds := RTDataSet new.
	ds noDot.
	ds points: #(1 2 3).
	ds x: #yourself.
	ds y: #yourself.
	b add: ds.

	b build.
	
	self assert: (b view elementFromModel: 2) trachelShape width equals: 0.
	self assert: (b view elementFromModel: 2) trachelShape height equals: 0.
	
	"Axes"
	self assert: b view numberOfEdges equals: 2
]

{ #category : #tests }
RTDataSetTest >> testNonTrivialGraph [

	| grapher dataSet |
	grapher := RTGrapher new.
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

{ #category : #tests }
RTDataSetTest >> testlineShape [

	| ds |
	ds := RTDataSet new.
	self assert: ds lineShape class equals: RTShapeBuilder
]
