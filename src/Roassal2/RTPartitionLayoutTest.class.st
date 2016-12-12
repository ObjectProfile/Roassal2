Class {
	#name : #RTPartitionLayoutTest,
	#superclass : #TestCase,
	#instVars : [
		'elements'
	],
	#category : #'Roassal2-Layouts-Tests'
}

{ #category : #tests }
RTPartitionLayoutTest >> setUp [
	| v eb |
	super setUp.
	
	v := RTView new.
	elements := RTBox elementsOn: (2 to: 10).
	v addAll: elements.
	
	eb := RTEdgeBuilder new.
	eb view: v.
	eb connectFrom: [ :vv | vv // 2 ].
	
]

{ #category : #tests }
RTPartitionLayoutTest >> testBasic [

	| l |
	l := RTPartitionLayout new
			withinGroup: RTTreeLayout new;
			forGroups: RTVerticalLineLayout new.
	l on: elements.
	self assert: (elements elementFromModel: 3) position y > (elements elementFromModel: 8) position y
]

{ #category : #tests }
RTPartitionLayoutTest >> testBasic02 [
	| l |
	l := RTPartitionLayout new.
	l on: elements.
]
