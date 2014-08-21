"
A RTNullNodeTest is a test class for testing the behavior of RTNullNode
"
Class {
	#name : #RTNullNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'node1'
	],
	#category : 'Roassal2-Builder-Sunburst'
}

{ #category : #running }
RTNullNodeTest >> setUp [
	node1:=RTNullNode new.
]

{ #category : #tests }
RTNullNodeTest >> testHasChildren [
	self deny: node1 hasChildren
]
