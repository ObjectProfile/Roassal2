Class {
	#name : #RTCircleAttachPointTest,
	#superclass : #RTTest,
	#category : #'Roassal2-AttachPoint-Tests'
}

{ #category : #tests }
RTCircleAttachPointTest >> testSamePoint [

	| e1 e2 e ap |
	e1 := RTBox element.
	e2 := RTBox element.
	e := RTLine edgeFrom: e1 to: e2.
	ap := RTCircleAttachPoint new.
	self assert: ((ap basicStartingPointOf: e) x closeTo: 0).
	self assert: ((ap basicStartingPointOf: e) y closeTo: 2.5).
	self assert: ((ap basicEndingPointOf: e) x closeTo: 0).
	self assert: ((ap basicEndingPointOf: e) y closeTo: 2.5).

]
