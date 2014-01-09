Class {
	#name : #RTLayoutTest,
	#superclass : #RTTest,
	#instVars : [
		'view'
	],
	#category : #'Roassal2-Core'
}

{ #category : #running }
RTLayoutTest >> setUp [
	super setUp.
	view := RTView new.
	
	1 to: 20 do: [ :i | view add: (RTBox elementOn: i) ]
]

{ #category : #tests }
RTLayoutTest >> testCluster [
	view := RTView new.
	view addAll: ((RTEllipse new size: 10) elementsOn: (Collection withAllSubclasses)).
	RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself inView: view.
	RTClusterLayout on: view elements edges: view edges.

]

{ #category : #tests }
RTLayoutTest >> testHorizontalLineLayout [

	| answer |
	RTHorizontalLineLayout on: view elements.
	answer := ((Array new: 20) at: 1 put: ((5@5)); at: 2 put: ((20@5)); at: 3 put: ((35@5)); at: 4 put: ((50@5)); at: 5 put: ((65@5)); at: 6 put: ((80@5)); at: 7 put: ((95@5)); at: 8 put: ((110@5)); at: 9 put: ((125@5)); at: 10 put: ((140@5)); at: 11 put: ((155@5)); at: 12 put: ((170@5)); at: 13 put: ((185@5)); at: 14 put: ((200@5)); at: 15 put: ((215@5)); at: 16 put: ((230@5)); at: 17 put: ((245@5)); at: 18 put: ((260@5)); at: 19 put: ((275@5)); at: 20 put: ((290@5)); yourself).
	self assert: (view elements collect: #position) asArray = answer
]

{ #category : #tests }
RTLayoutTest >> testTreelLineLayout [

	| answer  |
	 
	RTEdge buildEdgesFromObjects: (1 to: 20) from: [ :v | v // 2 ] to: #yourself inView: view.	
	RTTreeLayout on: view elements edges: view edges.

	answer := ((Array new: 20) at: 1 put: ((41.0@5)); at: 2 put: ((25.0@30)); at: 3 put: ((65.0@30)); at: 4 put: ((17.0@55)); at: 5 put: ((41.0@55)); at: 6 put: ((57.0@55)); at: 7 put: ((73.0@55)); at: 8 put: ((9.0@80)); at: 9 put: ((25.0@80)); at: 10 put: ((37.0@80)); at: 11 put: ((45.0@80)); at: 12 put: ((53.0@80)); at: 13 put: ((61.0@80)); at: 14 put: ((69.0@80)); at: 15 put: ((77.0@80)); at: 16 put: ((5.0@105)); at: 17 put: ((13.0@105)); at: 18 put: ((21.0@105)); at: 19 put: ((29.0@105)); at: 20 put: ((37.0@105)); yourself).
	self assert: (view elements collect: #position) asArray = answer
]
