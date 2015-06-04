Class {
	#name : #RTScaleLinear,
	#superclass : #RTScale,
	#instVars : [
		'clamp',
		'output',
		'input'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTScaleLinear >> clamp: x [
	clamp := x.
	self rescale.
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> domain: x [
	super domain: x.
	self rescale.
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> initialize [
	super initialize.
	domain := {0. 1}.
	range := {0. 1}.
	clamp := false.
	interpolate := RTInterpolator.
	self rescale.
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> invert: y [
	^ input scale: y
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> range: r [
	super range: r.
	self rescale.
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> rescale [
	| linear |
	linear := (domain size min: range size ) > 2
		ifTrue: [ RTScalePolylinear ]
		ifFalse: [ RTScaleBilinear ].
	uninterpolate := clamp
		ifTrue: [ RTUninterpolateClamp ]
		ifFalse: [ RTUninterpolateNumber ].
	output := linear new domain: domain; range: range; 
		uninterpolate: uninterpolate; interpolate: interpolate.
	output rescale.
	input := linear new domain: range; range: domain;
		uninterpolate: uninterpolate; interpolate: RTInterpolator.
	input rescale.
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> scale: x [
	^ output scale: x.
]
