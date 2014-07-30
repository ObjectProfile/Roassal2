Class {
	#name : #RTMultiLineTest,
	#superclass : #RTTest,
	#instVars : [
		'e1',
		'e2',
		'v'
	],
	#category : #'Roassal2-Core'
}

{ #category : #running }
RTMultiLineTest >> setUp [
	super setUp.
	e1 := RTBox element.
	e2 := RTBox element.
	v := RTView new
]

{ #category : #tests }
RTMultiLineTest >> testOrthoVerticalLine [

	| eb |
	v addAll: (RTBox elementsOn: Collection withAllSubclasses).

	eb := RTEdgeBuilder new.
	eb shape orthoVerticalLine.
	eb view: v.
	eb	objects: Collection withAllSubclasses
		from: #superclass
		to: #yourself;
		build.

	RTTreeLayout on: v elements.
	v
]

{ #category : #tests }
RTMultiLineTest >> testStraight [
	"The default is a straight line"
	| lineShape edge |
	lineShape := RTMultiLine new.
	edge := lineShape edgeFrom: e1 to: e2.
	v add: edge.
	self assert: v canvas numberOfShapes equals: 1
]

{ #category : #tests }
RTMultiLineTest >> testVerticalOrthogonal [
	"The default is a straight line"
	| lineShape edge |
	lineShape := RTMultiLine new.
	lineShape orthoVertical.
	edge := lineShape edgeFrom: e1 to: e2.
	v add: edge.
	self assert: v canvas numberOfShapes equals: 3
]
