"
A RTDynamicStackedGrapherTest is a test class for testing the behavior of RTDynamicStackedGrapher
"
Class {
	#name : #RTDynamicStackedGrapherTest,
	#superclass : #TestCase,
	#category : #'Roassal2-Builder-Grapher-Tests'
}

{ #category : #tests }
RTDynamicStackedGrapherTest >> testBarPosition [

	| b e5 e4 |
	b := RTDynamicStackedGrapher new.
	b maxY: 10.
	b add: 5.
	b add: 4.
	b build.
	
	e5 := b view elementFromModel: 5.
	e4 := b view elementFromModel: 4.
	self assert: e5 position equals: 0 @ 0.
]

{ #category : #tests }
RTDynamicStackedGrapherTest >> testEmbeddedInComposer [

	| a1 a2 composer a b |
	a1:= { {'x' . 10 }. { 'y' . 20 } . { 'z' . 100 } }.
	a2 := { {'x' . 30 }. { 'y' . 20 } . { 'z' . 10 } }.

	composer := RTComposer new.
	    a := RTDynamicStackedGrapher new.
	    a numberOfBars: a1 size.
	    a minY: -200; maxY: 200.
	    a view: composer view.
	    a y: #yourself.
	    a barShape color: (Color blue alpha: 0.3).
	    a addAll: (a1 collect: #second).
		a build.
	composer group: #first.

	    b := RTDynamicStackedGrapher new.
	    b numberOfBars: a2 size.
	    b minY: -200; maxY: 200.
	    b view: composer view.
	    b y: #yourself.
	    b barShape color: (Color blue alpha: 0.3).
		 b addAll: (a2 collect: #second).
		b build.
	composer group: #second.

	composer move: #first onTheLeftOf: #second.
	composer nameGroup: #first as: 'aFirstName'.
	composer nameGroup: #second as: 'aSecondName'.
	composer setGeneralTitle: 'aGeneralTitle'.

	composer view addMenu: 'Left' callback: [ a add: 200 atRandom ].
	composer view addMenu: 'Right' callback: [ b add: 200 atRandom ].

	self assert: b centerElement position equals: 0 @ 0.
	self assert: a centerElement position ~= (0 @ 0).

]

{ #category : #tests }
RTDynamicStackedGrapherTest >> testNumberOfBars [

	self assert: RTDynamicStackedGrapher new numberOfBars equals: RTDynamicStackedGrapher new defaultNumberOfBars 
]
