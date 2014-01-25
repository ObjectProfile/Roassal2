"
A ROConstraintTest is xxxxxxxxx.

Instance Variables
	element1:		<Object>
	element2:		<Object>
	view:		<Object>

element1
	- xxxxx

element2
	- xxxxx

view
	- xxxxx

"
Class {
	#name : #TRConstraintTest,
	#superclass : #TRTest,
	#instVars : [
		'element1',
		'element2',
		'view',
		'canvas',
		'shape1',
		'shape2'
	],
	#category : #'Trachel-Core'
}

{ #category : #running }
TRConstraintTest >> setUp [
	super setUp.
	canvas := TRCanvas new.
	shape1 := TRBoxShape new size: 50.
	shape2 := TRBoxShape new size: 10.
	canvas addShape: shape1.
	canvas addShape: shape2.
]

{ #category : #sticking }
TRConstraintTest >> testStickAbove [

	TRConstraint stick: shape2 above: shape1.
	self assert: shape1 center = (0 @ 0).
	self assert: shape2 center = (0 @ -30).
	
	shape1 translateBy: 10 @ 10.
	self assert: shape1 center = (10 @ 10).
	self assert: shape2 center = (10 @ -20).

]

{ #category : #sticking }
TRConstraintTest >> testStickBelow [

	TRConstraint stick: shape2 below: shape1.
	self assert: shape1 center = (0 @ 0).
	self assert: shape2 center = (0 @ 30).

	shape1 translateBy: 10 @ 10.
	self assert: shape1 center = (10 @ 10).
	self assert: shape2 center = (10 @ 40).

]

{ #category : #sticking }
TRConstraintTest >> testStickToTheCenter [

	TRConstraint 
		stick: shape1 onTheCenterOf: shape2.
		
	self assert: shape1 center = (0 @ 0).
	self assert: shape2 center = (0 @ 0).

	shape2 translateBy: 10 @ 15.
	self assert: shape1 center = (10 @ 15).
	self assert: shape2 center = (10 @ 15).

]
