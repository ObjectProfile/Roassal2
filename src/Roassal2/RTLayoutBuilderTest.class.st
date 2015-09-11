Class {
	#name : #RTLayoutBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'builder'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #running }
RTLayoutBuilderTest >> setUp [
	builder := RTLayoutBuilder new
]

{ #category : #tests }
RTLayoutBuilderTest >> testAddingPartition [
	builder for: #odd use: RTGridLayout new.
	self assert: builder hasPartition
]

{ #category : #tests }
RTLayoutBuilderTest >> testConditional [
	| v es eb lb |
	v := RTView new.
	es := RTBox elementsOn: (1 to: 20).
	v addAll: es.
	
	eb := RTEdgeBuilder new
				view: v;
				elements: (es copyFrom: 1 to: 10);
				connectTo: [ :aValue | aValue + 1 ].

	lb := RTLayoutBuilder new
				ifElement: #isConnected then: RTGridLayout new;
				else: RTTreeLayout new;
				overall: RTHorizontalLineLayout new.
	lb setUpElements: es.
	
	self assert: (es collect: #position) asArray equals: (((Array new: 20) at: 1 put: ((3.0@3.0)); at: 2 put: ((13.0@3.0)); at: 3 put: ((23.0@3.0)); at: 4 put: ((33.0@3.0)); at: 5 put: ((3.0@13.0)); at: 6 put: ((13.0@13.0)); at: 7 put: ((23.0@13.0)); at: 8 put: ((33.0@13.0)); at: 9 put: ((3.0@23.0)); at: 10 put: ((13.0@23.0)); at: 11 put: ((48.0@3.0)); at: 12 put: ((56.0@3.0)); at: 13 put: ((64.0@3.0)); at: 14 put: ((72.0@3.0)); at: 15 put: ((80.0@3.0)); at: 16 put: ((88.0@3.0)); at: 17 put: ((96.0@3.0)); at: 18 put: ((104.0@3.0)); at: 19 put: ((112.0@3.0)); at: 20 put: ((120.0@3.0)); yourself))
]

{ #category : #tests }
RTLayoutBuilderTest >> testDefault [
	self deny: builder hasPartition
]

{ #category : #tests }
RTLayoutBuilderTest >> testSugiyamaAndVerticalAttach [

	| e1 e2 edge |
	builder sugiyama.
	e1 := RTBox element.
	e2 := RTBox element.
	edge := RTLine edgeFrom: e1 to: e2.
	builder setUpElements: (Array with: e1 with: e2).

	self assert: edge shape attachPoint class equals: RTVerticalAttachPoint 
]

{ #category : #tests }
RTLayoutBuilderTest >> testTreeAndVerticalAttach [

	| e1 e2 edge |
	builder tree.
	e1 := RTBox element.
	e2 := RTBox element.
	edge := RTLine edgeFrom: e1 to: e2.
	builder setUpElements: (Array with: e1 with: e2).

	self assert: edge shape attachPoint class equals: RTVerticalAttachPoint 
]
