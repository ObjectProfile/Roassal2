Class {
	#name : #RTCircleTest,
	#superclass : #RTTest,
	#instVars : [
		'circle'
	],
	#category : #'Roassal2-AttachPoint-Tests'
}

{ #category : #tests }
RTCircleTest >> testIncludesPoint [
	circle := RTCircle center: 10 @ 10 radius: 10.
	self assert: (circle includesPoint: 10 @ 0).
	self assert: (circle includesPoint: 20 @ 10).
	self assert: (circle includesPoint: 10 @ 20).
	self assert: (circle includesPoint: 0 @ 10).
	self deny: (circle includesPoint: 0 @ 0).
	self deny: (circle includesPoint: 20 @ 0).
	self deny: (circle includesPoint: 20 @ 20).
	self deny: (circle includesPoint: 0 @ 20)
]

{ #category : #tests }
RTCircleTest >> testIntersectCircleIntersect [
	| circleLeft circleRight |
	circleLeft := RTCircle center: 0 @ 0 radius: 10.
	circleRight := RTCircle center: 10 @ 10 radius: 10.
	self assert: ((circleLeft intersectCircle: circleRight) first closeTo: 10 @ 0).
	self assert: ((circleLeft intersectCircle: circleRight) second closeTo: 0 @ 10)
]

{ #category : #tests }
RTCircleTest >> testIntersectCircleNot [
	| circleLeft circleRight |
	circleLeft := RTCircle center: 0 @ 0 radius: 10.
	circleRight := RTCircle center: 30 @ 0 radius: 10.
	self assert: (circleLeft intersectCircle: circleRight) isEmpty
]

{ #category : #tests }
RTCircleTest >> testIntersectCircleTouch [
	| circleLeft circleRight |
	circleLeft := RTCircle center: 0 @ 0 radius: 10.
	circleRight := RTCircle center: 20 @ 0 radius: 10.
	self assert: (circleLeft intersectCircle: circleRight) equals: {(10 @ 0)}
]

{ #category : #tests }
RTCircleTest >> testNew [
	self should: [ RTCircle new ] raise: Error.
	circle := RTCircle center: 0 @ 0 radius: 10.
	self assert: circle center equals: 0 @ 0.
	self assert: circle radius equals: 10
]
