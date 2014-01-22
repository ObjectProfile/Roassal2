"
A ROQuadTreeTest is xxxxxxxxx.

Instance Variables
	nodes:		<Object>
	quad:		<Object>

nodes
	- xxxxx

quad
	- xxxxx

"
Class {
	#name : #RTQuadTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'nodes',
		'quad'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #util }
RTQuadTreeTest >> isTrueLeaf: aQuad [

	aQuad isNil ifTrue: [ ^ false ].

	aQuad leaf ifTrue: [ ^ aQuad nodes allSatisfy: [ :e | e isNil ] ]
				ifFalse: [ ^ aQuad nodes anySatisfy: [ :e | self isTrueLeaf: e ] ]
]

{ #category : #running }
RTQuadTreeTest >> setUp [
	super setUp.
	nodes := OrderedCollection new.
	
	(0 to: 10) do: [ :e | nodes add: (RTElement new translateTo: e @ e); 
								add: (RTElement new translateTo: e @ (10 - e)) ].
	
	quad := RTQuadTree withAll: nodes.
]

{ #category : #tests }
RTQuadTreeTest >> testCreate [
	
	| quadrants points |
	points :=  Array with: 0@0 with: 0@5 with: 5@0 with: 5@5.
	
	nodes := points collect: [ :pos | RTElement new translateTo: pos ].
	quad := RTQuadTree withAll: nodes.
	
	quadrants := quad nodes.
	
	self assert: (quadrants at: 1) node position = (0@0).
	self assert: (quadrants at: 2) node position = (5@0).
	self assert: (quadrants at: 3) node position = (0@5).
	self assert: (quadrants at: 4) node position = (5@5)
]

{ #category : #tests }
RTQuadTreeTest >> testLeaf [

	self assert: (quad leaf ifTrue: [quad nodes allSatisfy: [ :e | e isNil ] ]
							ifFalse: [ quad nodes anySatisfy: [ :e | self isTrueLeaf: e ] ] )
]

{ #category : #tests }
RTQuadTreeTest >> testRectangle [
	| points |
	points := Array with:  0@5 with: 5@0 with: 10@5 with: 5@5.
	nodes := points collect: [ :e | RTElement new translateTo: e ].
	quad := RTQuadTree withAll: nodes.
	
	self assert: quad origin = (0@0).
	self assert: quad corner = (10@10)
]

{ #category : #tests }
RTQuadTreeTest >> testSquare [
	| points |
	points := Array with:  0@5 with: 5@0 with: 10@5 with: 5@5.	
	nodes := points collect: [ :pos | RTElement new translateTo: pos ].
	quad := RTQuadTree withAll: nodes.
	
	self assert: quad origin = (0@0).
	self assert: quad corner = (10@10)
]

{ #category : #util }
RTQuadTreeTest >> wellCreated: aQuad [

	aQuad leaf ifTrue: [ aQuad node isNil ifTrue: [ ^ true ]
										   ifFalse: [ ^ (Rectangle origin: aQuad origin corner: aQuad corner) contains: aQuad node position ] ] 
				ifFalse: [ aQuad node isNil ifTrue: [ ^ aQuad nodes allSatisfy: [ :e | self wellCreated: e ] ] 
										    ifFalse: [ ^ ((Rectangle origin: aQuad origin corner: aQuad corner) contains: aQuad node position) & (aQuad nodes allSatisfy: [ :e | self wellCreated: e ]) ] ]
]
