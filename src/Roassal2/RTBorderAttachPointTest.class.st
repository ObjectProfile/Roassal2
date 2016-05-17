Class {
	#name : #RTBorderAttachPointTest,
	#superclass : #RTAttachPointTest,
	#instVars : [
		'attachPoint',
		'el'
	],
	#category : #'Roassal2-Core-Tests'
}

{ #category : #running }
RTBorderAttachPointTest >> setUp [
	super setUp.
	attachPoint := RTBorderAttachPoint new
]

{ #category : #tests }
RTBorderAttachPointTest >> testBoxBorderPoint [
	| from to via |
	from := GRectangle origin: 0 @ 0 corner: 20 @ 10.
	to := GRectangle origin: 10 @ 30 corner: 20 @ 40.
	via := GLineSegment from: from center to: to center.
	self assert: (attachPoint borderPointFrom: from to: to via: via) equals: (65 / 6) @ 10.
	self assert: (attachPoint borderPointFrom: to to: from via: via) equals: (85 / 6) @ 30
]

{ #category : #tests }
RTBorderAttachPointTest >> testEllipseBorderPoint [
	| from to via |
	from := GEllipse center: 10 @ 5 a: 5 b: 2.5.
	to := GEllipse center: 15 @ 35 a: 5 b: 5.
	via := GLineSegment from: from center to: to center.
	self assert: (attachPoint borderPointFrom: from to: to via: via) equals: (65 / 6) @ 10.
	self assert: (attachPoint borderPointFrom: to to: from via: via) equals: (85 / 6) @ 30
]

{ #category : #tests }
RTBorderAttachPointTest >> testGeometryBox [
	el := RTBox new
		width: 20;
		height: 30;
		element.
	el translateTo: 20 @ 30.
	self
		assert: (attachPoint geometryFor: el)
		equals: (GRectangle origin: 10 @ 15 corner: 30 @ 45)
]

{ #category : #tests }
RTBorderAttachPointTest >> testGeometryEllipse [
	el := RTEllipse new
		width: 20;
		height: 30;
		element.
	el translateTo: 20 @ 30.
	self assert: (attachPoint geometryFor: el) equals: (GEllipse center: 20 @ 30 a: 10 b: 15)
]
