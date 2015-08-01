"
Continuous attach point which presumes both shapes are circles whose radius = half of width of encompassingRectangle

-=-=-=
v := RTView new.

e1 := (RTBox new size: 50) elementOn: 1.
e2 := (RTEllipse new size: 50) elementOn: 2.
v add: e1; add: e2.
e2 translateBy: 30 @ 60.

e1 @ RTDraggable.
e2 @ RTDraggable.

s := RTArrowedLine new color: Color black.
s attachPoint: RTCircleAttachPoint new.
l := s edgeFrom: e1 to: e2.
v add: l.

v
-=-=-=
"
Class {
	#name : #RTCircleAttachPoint,
	#superclass : #RTContinuousAttachPoint,
	#category : #'Roassal2-AttachPoint'
}

{ #category : #private }
RTCircleAttachPoint >> attachPointFor: anEdge from: fromRect to: toRect [
	| angle x y fromPoint toPoint offsetShift radius |
	offsetShift := self offsetNormalFor: anEdge.
	fromPoint := fromRect center + offsetShift.
	toPoint := toRect center + offsetShift.
	radius := fromRect width * 0.5.
	angle := (RTLineSegment from: fromPoint to: toPoint) angleInRad ifNil: [ 2 ].
	(toPoint dist: fromPoint) < (toRect width * 0.5 - radius)
		ifTrue: [ angle := angle + Float pi ].	"fromCircle is inside toCircle"
	offsetShift isZero
		ifFalse: [ radius := radius * (offsetShift r / radius) arcSin cos ].	"recalculates radius based on offset"
	x := radius * angle cos + fromPoint x.
	y := radius * angle sin + fromPoint y.
	^ x @ y
]

{ #category : #'public - hooks' }
RTCircleAttachPoint >> basicEndingPointOf: anEdge [
	^ self attachPointFor: anEdge from: anEdge to encompassingRectangle to: anEdge from encompassingRectangle
]

{ #category : #'public - hooks' }
RTCircleAttachPoint >> basicStartingPointOf: anEdge [
	^ self attachPointFor: anEdge from: anEdge from encompassingRectangle to: anEdge to encompassingRectangle
]
