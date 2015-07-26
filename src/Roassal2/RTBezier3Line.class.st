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

{ #category : #hooks }
RTBezier3Line >> trachelShapeClass [
	^ TRBezier3Shape

]

{ #category : #rendering }
RTBezier3Line >> updateFor: edge trachelShape: trachelShape [
	trachelShape isNil ifTrue: [ ^ self ].
	
	trachelShape points: (Array with: (attachPoint startingPointOf: edge) with: (controlElement position) with: (attachPoint endingPointOf: edge)).
	trachelShape color: (self colorFor: edge).
	trachelShape width: (self widthFor: edge).
	trachelShape resetPath.
	^ trachelShape
	
]
