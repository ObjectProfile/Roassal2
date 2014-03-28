Class {
	#name : #RTGraphBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'b'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #running }
RTGraphBuilderTest >> setUp [
	super setUp.
	b := RTGraphBuilder new
]

{ #category : #tests }
RTGraphBuilderTest >> testEdge [

	b node
		if: [ :o | true ] shape: (RTEllipse new size: 10; color: Color blue).

	b edge
		if: [ :obj | obj = 1 ] connectedTo: [ :o | o + 1 ] shape: (RTLine new color: Color blue).
	b addAll: (1 to: 2).
	
	self assert: b view numberOfElements = 2.
	self assert: b view numberOfEdges = 1.

]

{ #category : #tests }
RTGraphBuilderTest >> testNode [

	| e4 e6 |
	b node
		if: [ :obj | obj < 5 ] shape: (RTEllipse new size: 10; color: Color blue);
		if: [ :obj | obj >= 5 ] shape: (RTEllipse new size: 10; color: Color red).
	b addAll: (1 to: 10).
	
	self assert: b view numberOfElements = 10.

	e4 := b view elementFromModel: 4.
	self assert: e4 shape class == RTEllipse.
	self assert: e4 trachelShape color = Color blue.
	
	e6 := b view elementFromModel: 6.
	self assert: e6 shape class == RTEllipse.
	self assert: e6 trachelShape color = Color red.
]
