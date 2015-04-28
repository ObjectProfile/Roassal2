Class {
	#name : #RTShowEdgeTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Core-Tests'
}

{ #category : #tests }
RTShowEdgeTest >> testBasic [

	| v es |
	v := RTView new.
	es := (RTEllipse new + RTLabel) elementsOn: (1 to: 5).
	v addAll: es.
	RTCircleLayout on: es.

	es first @ (RTShowEdge new connectTo: [:vvvv| Array with: 2 ]).

	self assert: v numberOfEdges = 0.
	es first announce: TRMouseEnter.
	self assert: v numberOfEdges = 1.
	
	es first announce: TRMouseLeave.
	self assert: v numberOfEdges = 0.
]

{ #category : #tests }
RTShowEdgeTest >> testBasic2 [

	| v es |
	v := RTView new.
	es := (RTEllipse new + RTLabel) elementsOn: (1 to: 5).
	v addAll: es.
	RTCircleLayout on: es.

	es @ (RTShowEdge new connectTo: [:vvvv| Array with: vvvv + 1 ]).

	self assert: v numberOfEdges = 0.
	es third announce: TRMouseEnter.
	self assert: v numberOfEdges = 1.
	
	es third announce: TRMouseLeave.
	self assert: v numberOfEdges = 0.
]
