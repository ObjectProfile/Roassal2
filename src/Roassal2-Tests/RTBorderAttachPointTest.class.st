Class {
	#name : #RTBorderAttachPointTest,
	#superclass : #RTAttachPointTest,
	#instVars : [
		'attachPoint',
		'el'
	],
	#category : #'Roassal2-Tests-Core'
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
	via := GLine through: from center and: to center.
	self assert: (attachPoint borderPointFrom: from to: to via: via) asPoint equals: (65 / 6) @ 10.
	self assert: (attachPoint borderPointFrom: to to: from via: via) asPoint equals: (95 / 6) @ 40
]

{ #category : #tests }
RTBorderAttachPointTest >> testEllipseWithArrowArc [
	| v els line1 line2 e1 e2|
	v := RTView new.
	els := RTEllipse new 
		color: Color gray; 
		borderColor: Color black; 
		size: 20; 
		elementsOn: #(A B).
	els @ RTDraggable.
	v addAll: els.

	els second translateBy: 100 @ 0.

	line1 := RTArcLine new 
		distance: -10;
		withBorderAttachPoint;
		filledNarrowArrowHead; 
		color: Color red.
	line2 := RTArcLine new 
		distance: -10;
		withBorderAttachPoint;
		filledNarrowArrowHead; 
		color: Color blue.
	e1 := line1 edgeFrom: els first to: els last.
	e2 := line2 edgeFrom: els second to: els first.
	
	v add: e1; add: e2.
	
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
	self
		assert: (attachPoint geometryFor: el) 
		equals: (GEllipse
			center: (20 @ 30) asGPoint
			vertex: (30@30) asGPoint
			coVertex: (20@45) asGPoint)
]

{ #category : #tests }
RTBorderAttachPointTest >> testGeometryRoundedBox [
	el := RTRoundedBox new
		width: 80;
		height: 40;
		borderRadius: 10;
		element.
	self
		assert: (attachPoint geometryFor: el)
		equals: (GRectangle origin: -40 @ -20 corner: 40 @ 20)
]
