"
Describe a cubic Bezier spline

Here is an example:

-=-=-=-=-=
v := RTView new.

s := RTEllipse new color: (Color red alpha: 0.4); size: 30.
e1 := s elementOn: 'Begin'.
e2 := s elementOn: 'End'.
e3 := s elementOn: 'Middle'.


lineShape := RTBezier3Line new.
lineShape controlElement: e3.

lineShape attachPoint: (RTShorterDistanceAttachPoint instance).
edge := lineShape edgeFrom: e1 to: e2.

v add: e1; add: e2; add: e3; add: edge.

e1 @ RTDraggable.
e2 @ RTDraggable.
e3 @ RTDraggable.

e2 translateBy: 80 @ 50.
e3 translateBy: 40 @ 25.

v 
-=-=-=-=-=
"
Class {
	#name : #RTBezier3Line,
	#superclass : #RTAbstractLine,
	#instVars : [
		'controlElement'
	],
	#category : #'Roassal2-Shapes'
}

{ #category : #accessing }
RTBezier3Line >> controlElement [
	^ controlElement
]

{ #category : #accessing }
RTBezier3Line >> controlElement: anElement [
	controlElement := anElement
]

{ #category : #private }
RTBezier3Line >> controlPointFor: cp1 and: cp3 [
	| mid dx dy l vector vectorNorm vectorNormInverse distanceFromMidPoint |
	mid := (cp1 + cp3)/2.
	dx := cp3 x - cp1 x.
	dy := cp3 y - cp1 y.
	l := ((dx*dx) + (dy* dy)) sqrt asFloat.
	vector := dx asFloat @ dy asFloat.
	(vector isZero and: [ l isZero ])
		ifTrue: [ ^ 0@0 ].
	vectorNorm := vector/l.
	
	vectorNormInverse := vectorNorm y negated @ vectorNorm x.
	"distanceFromMidpoint :=  (0.5 - pairEdges.length / 2 + i) * stepSize."
	distanceFromMidPoint := -20.
	^ (mid x + (vectorNormInverse x * distanceFromMidPoint))@
	(mid y + (vectorNormInverse y * distanceFromMidPoint))
]

{ #category : #hooks }
RTBezier3Line >> trachelShapeClass [
	^ TRBezier3Shape

]

{ #category : #rendering }
RTBezier3Line >> updateFor: edge trachelShape: trachelShape [
	| cp1 cp2 cp3 |
	trachelShape isNil
		ifTrue: [ ^ self ].
	cp1 := attachPoint startingPointOf: edge.
	cp3 := attachPoint endingPointOf: edge.
	cp2 := controlElement
		ifNil: [ self controlPointFor: cp1 and: cp3 ]
		ifNotNil: [ controlElement isPoint
				ifTrue: [ controlElement ]
				ifFalse: [ controlElement position ] ].
	trachelShape points: (Array with: cp1 with: cp2 with: cp3).
	trachelShape color: (self colorFor: edge).
	trachelShape width: (self widthFor: edge).
	trachelShape resetPath.
	^ trachelShape
]
