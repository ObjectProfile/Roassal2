"
A RTNodeTest is a test class for testing the behavior of RTNode
"
Class {
	#name : #RTNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'node1',
		'node2',
		'node3',
		'node4',
		'node5',
		'node6',
		'node7',
		'node8'
	],
	#category : 'Roassal2-Builder-Sunburst'
}

{ #category : #running }
RTNodeTest >> setUp [
	node1:=RTNode new.
	node2:=RTNode new.
	node3:=RTNode new.
	node4:=RTNode new.
	node5:=RTNode new.
	node6:=RTNode new.
	node7:=RTNode new.
	node8:=RTNode new.
]

{ #category : #tests }
RTNodeTest >> testDepth [
	self assert: node1 depth = 0.
	self assert: node2 depth = 0.
	self assert: node3 depth = 0.
	node1 addChild: node2.
	node1 addChild: node3.
	self assert: node2 depth = 1.
	self assert: node3 depth = 1.
]

{ #category : #tests }
RTNodeTest >> testHasChildren [
	self deny: node1 hasChildren .
	self deny: node2 hasChildren .
	self deny: node3 hasChildren .
	node1 addChild: node2.
	node1 addChild: node3.
	self assert: node1 hasChildren.
	self deny: node2 hasChildren.
	self deny: node3 hasChildren.
	node2 addChild: node4.
	node2 addChild: node5.
	self assert: node1 hasChildren.
	self assert: node2 hasChildren.
	self deny: node3 hasChildren.
	
]

{ #category : #tests }
RTNodeTest >> testMaxDepth [
	self assert: node1 maxDepth = 0.
	self assert: node2 maxDepth = 0.
	self assert: node3 maxDepth = 0.
	node1 addChild: node2.
	node1 addChild: node3.
	self assert: node1 maxDepth = 1.
	self assert: node2 maxDepth = 1.
	self assert: node3 maxDepth = 1.
	node2 addChild: node4.
	node2 addChild: node5.
	self assert: node1 maxDepth = 2.
	self assert: node2 maxDepth = 2.
	self assert: node3 maxDepth = 1.
	
]
