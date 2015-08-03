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
		'shape2',
		'originShape',
		'conformingShape'
	],
	#category : #'Trachel-Tests'
}

{ #category : #running }
TRConstraintTest >> setUp [
	super setUp.
	canvas := TRCanvas new.
	shape1 := TRBoxShape new size: 50.
	shape2 := TRBoxShape new size: 10.
	canvas addShape: shape1.
	canvas addShape: shape2.
	
	(originShape := TRBoxShape new) extent: 10 @ 10.
	(conformingShape := TRBoxShape new) extent: 20 @ 20
]

{ #category : #resizing }
TRConstraintTest >> testResizingHeight [

	self assert: shape1 height equals: 50.
	self assert: shape2 height equals: 10.
	
	TRConstraint useHeightOf: shape1 for: (Array with: shape2).

	self assert: shape1 height equals: 50.
	self assert: shape2 height equals: 50.

]

{ #category : #resizing }
TRConstraintTest >> testResizingToMaxWidth [

	self assert: shape1 width equals: 50.
	self assert: shape2 width equals: 10.
	
	TRConstraint setAllToMaxWidth: (Array with: shape2 with: shape1).

	self assert: shape1 width equals: 50.
	self assert: shape2 width equals: 50.

]

{ #category : #resizing }
TRConstraintTest >> testResizingWidth [

	self assert: shape1 width equals: 50.
	self assert: shape2 width equals: 10.
	
	TRConstraint useWidthOf: shape1 for: (Array with: shape2).

	self assert: shape1 width equals: 50.
	self assert: shape2 width equals: 50.

]
