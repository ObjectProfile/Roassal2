Class {
	#name : #VIAnimatedValueTest,
	#superclass : #TRTest,
	#category : #'Trachel-Viva'
}

{ #category : #tests }
VIAnimatedValueTest >> testAddingWithNumber [

	| t |
	t := VIAnimatedValue new.
	t evaluator: [ :timE | 5 ].

	self assert: t value equals: 5.
	self assert: (t + 4) value equals: 9.
	self assert: (4 + t) value equals: 9
]

{ #category : #tests }
VIAnimatedValueTest >> testBasic [
	| t |
	t := VIAnimatedValue new.
	t evaluator: [ :time | 0 interpolateTo: 100 at: time ].
	self assert: t value equals: 0
]

{ #category : #tests }
VIAnimatedValueTest >> testBasicWithOutEvaluator [
	| t  |
	t := VIAnimatedValue new.
	self assert: t value equals: 0
]

{ #category : #tests }
VIAnimatedValueTest >> testBasicWithTimer [
	| t timer |
	t := VIAnimatedValue new.
	t evaluator: [ :time | 0 interpolateTo: 100 at: time ].
	timer := VITimer new cycleLength: 2.
	t timer: timer.
	self assert: t value equals: 0
]

{ #category : #tests }
VIAnimatedValueTest >> testPoint [
	| t1 t2 p |
	t1 := VIAnimatedValue new.
	t2 := VIAnimatedValue new.
	p := t1 @ t2.
	self assert: p class equals: VIAnimatedPoint.
]
