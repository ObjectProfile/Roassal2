Class {
	#name : #RTEdgeBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'view',
		'elements'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #running }
RTEdgeBuilderTest >> setUp [

	view := RTView new.
	elements := RTBox elementsOn: (1 to: 10).
	view addAll: elements. 
]

{ #category : #tests }
RTEdgeBuilderTest >> testDefault [
	self assert: view numberOfEdges equals: 0
]

{ #category : #tests }
RTEdgeBuilderTest >> testFrom [

	| v es |
	v := RTView new.

	es := (RTEllipse new size: 20) elementsOn: (1 to: 2).
	v addAll: es.
	RTEdgeBuilder new
		view: v;
		objects: (1 to: 2) from: 1 to: 2;
		build.

	es @ RTPopup.
	RTTreeLayout on: es.

	self assert: v edges size equals: 1.
	self assert: v edges first from position equals: (15.0@15.0).
	self assert: v edges first to position equals: (15.0@55.0).
]

{ #category : #tests }
RTEdgeBuilderTest >> testFromAll [

	| v es |
	v := RTView new.

	es := (RTEllipse new size: 20) elementsOn: (1 to: 2).
	v addAll: es.
	
	self assert: v edges size equals: 0.
	RTEdgeBuilder new
		view: v;
		objects: (1 to: 2) fromAll: (Array with: 1) to: 2.

	es @ RTPopup.
	RTTreeLayout on: es.

	self assert: v edges size equals: 1.
	self assert: v edges first from position equals: (15.0@15.0).
	self assert: v edges first to position equals: (15.0@55.0).
]

{ #category : #tests }
RTEdgeBuilderTest >> testInit [
	| eb |
	eb := RTEdgeBuilder new.
	self deny: eb shouldAllowRepetition.
	eb allowRepetition.
	self assert: eb shouldAllowRepetition.
]

{ #category : #tests }
RTEdgeBuilderTest >> testSimple [

	RTEdgeBuilder new
		view: view;
		fromElementAssociations: (Array 
									with: elements first -> elements second
									with: elements second -> elements third).
	self assert: view numberOfEdges equals: 2
]

{ #category : #tests }
RTEdgeBuilderTest >> testSimple2 [

	RTEdgeBuilder new
		view: view;
		fromAssociations: (Array 
									with: 1 -> 2
									with: 2 -> 3
									with: 5 -> 6).
	self assert: view numberOfEdges equals: 3
]

{ #category : #tests }
RTEdgeBuilderTest >> testSimple3 [

	RTEdgeBuilder new
		view: view;
		objects: #(1 2 3 6) from: #yourself to: [ :v | v + 1 ].
	self assert: view numberOfEdges equals: 4.
	self assert: (view edges collect: [ :e | e from model -> e to model ]) asArray equals: ((Array new: 4) at: 1 put: (1->2); at: 2 put: (2->3); at: 3 put: (3->4); at: 4 put: (6->7); yourself)
]

{ #category : #tests }
RTEdgeBuilderTest >> testSimple4 [

	RTEdgeBuilder new
		view: view;
		objects: #(1 2 3 6) from: #yourself to: [ :v | v + 1 ] scope: #(1 2 3 6).
	self assert: view numberOfEdges equals: 2.
	self assert: (view edges collect: [ :e | e from model -> e to model ]) asArray equals: ((Array new: 2) at: 1 put: (1->2); at: 2 put: (2->3); yourself)
]

{ #category : #tests }
RTEdgeBuilderTest >> testSimple5 [

	RTEdgeBuilder new
		view: view;
		objects: #(1 2 3 6) from: #yourself toAll: [ :v | Array with: v + 1 with: v + 2 ].
		
	self assert: view numberOfEdges equals: 16.

]

{ #category : #tests }
RTEdgeBuilderTest >> testSimple6 [

	RTEdgeBuilder new
		view: view;
		object: 1 fromAll: (Array with: 2) to: 3.
		
		
	self assert: view numberOfEdges equals: 1.

]
