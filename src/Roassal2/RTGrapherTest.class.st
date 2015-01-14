Class {
	#name : #RTGrapherTest,
	#superclass : #RTTest,
	#instVars : [
		'b'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #tests }
RTGrapherTest >> testDefault [
	b := RTGrapher new.
	self assert: b minX equals: 0.
	self assert: b maxX equals: 0.
	self assert: b minY equals: 0.
	self assert: b maxY equals: 0.

]

{ #category : #tests }
RTGrapherTest >> testDefault02 [
	b := RTGrapher new.
	b maxX: 2.
	b minX: -2.
	b maxY: 5.
	b minY: -1.
	self assert: b minX equals: -2.
	self assert: b maxX equals: 2.
	self assert: b minY equals: -1.
	self assert: b maxY equals: 5.

]

{ #category : #tests }
RTGrapherTest >> testExtent [

	b := RTGrapher new.
	b extent: 50 @ 30.
	self assert: b extent equals: 50 @ 30
]

{ #category : #tests }
RTGrapherTest >> testNumberOfPlugins [

	self assert: RTGrapher new numberOfDecorators equals: 0.
	b := RTGrapher new.
	b addDecorator: (RTVerticalLineDecorator new).
	self assert: RTGrapher new numberOfDecorators equals: 0.
]

{ #category : #tests }
RTGrapherTest >> testNumberOfPlugins01 [

	self assert: RTGrapher new numberOfDecorators equals: 0.

]

{ #category : #tests }
RTGrapherTest >> testNumberOfPlugins02 [

	b := RTGrapher new.
	b addDecorator: (RTVerticalLineDecorator new).
	self assert: b numberOfDecorators equals: 1.
]

{ #category : #tests }
RTGrapherTest >> testSimple [

	| ds |
	b := RTGrapher new.

	ds := RTDataSet new.
	ds interaction popupText.
	ds points: #(3 4 5 6).
	ds x: #yourself.
	ds y: #yourself.
	b add: ds.

	b build.
	
	self assert: ds maxX equals: 6.
	
	self assert: b minX equals: 0.
	self assert: b maxX equals: 6.
	self assert: b minY equals: 0.
	self assert: b maxY equals: 6.
]

{ #category : #tests }
RTGrapherTest >> testSimple02 [

	| ds |
	b := RTGrapher new.

	ds := RTDataSet new.
	ds points: (-100 to: 100 by: 0.1).
	ds y: [ :x | (0.1 * (x + 30)) sin  ].
	ds noDot.
	ds interaction popupText: 'sinus'.
	ds connectColor: Color blue.
	b add: ds.

	b minY: -2.
	b maxY: 2.
	b build.
]

{ #category : #tests }
RTGrapherTest >> testSimple03 [

| ds |
b := RTGrapher new.

	ds := RTDataSet new.
	ds points: (-100 to: 100 by: 0.1).
	ds y: [ :x | (0.1 * (x + 30)) sin  ].
	ds noDot.
	ds interaction popupText: 'sinus'.
	ds connectColor: Color blue.
	b add: ds.
	
	ds := RTDataSet new.
	ds points: (-100 to: 100 by: 0.1).
	ds y: [ :x | (0.1 * (x + 30)) sin * 2 ].
	ds noDot.
	ds interaction popupText: 'sinus 2'.
	ds connectColor: Color red.
	b add: ds.

b minY: -2.
b maxY: 2.
b minX: -150.

b axisX 
	numberOfTicks: 5;
	numberOfLabels: 2.
b build.
]

{ #category : #'test labels' }
RTGrapherTest >> testTitleOnAxes [

	| ds labels |
	b := RTGrapher new.
	ds := RTDataSet new.
	ds points: #(1 2).
	b add: ds.

	b axisX noTick; title: 'hello'.
	b axisY noLabel; title: 'world'.
	b build.
	
	labels := b view elements elements select: [ :el | el shape class == RTLabel ].
	self assert: (labels anySatisfy: [ :e | e trachelShape text = 'hello' ]).
	self assert: (labels anySatisfy: [ :e | e trachelShape text = 'world' ]).
]

{ #category : #'test labels' }
RTGrapherTest >> testTitleOnAxes02 [

	| ds labels |
	b := RTGrapher new.
	ds := RTDataSet new.
	ds points: #(1 2).
	b add: ds.

	b axisX title: 'hello'.
	b axisY title: 'world'.
	b build.
	
	labels := b view elements elements select: [ :el | el shape class == RTLabel ].
	self assert: (labels anySatisfy: [ :e | e trachelShape text = 'hello' ]).
	self assert: (labels anySatisfy: [ :e | e trachelShape text = 'world' ]).
]
