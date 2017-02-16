Class {
	#name : #RTScaleLinear,
	#superclass : #RTScale,
	#instVars : [
		'clamp',
		'output',
		'input'
	],
	#category : #'Roassal2-Builder-Grapher-Scaling'
}

{ #category : #accessing }
RTScaleLinear >> clamp: x [
	clamp := x.
	self rescale.
]

{ #category : #accessing }
RTScaleLinear >> domain: x [
	super domain: x.
	self rescale.
]

{ #category : #initialization }
RTScaleLinear >> initialize [
	super initialize.
	domain := #(0 1).
	range := #(0 1).
	clamp := false.
	interpolate := RTInterpolator.
	self rescale.
]

{ #category : #transformations }
RTScaleLinear >> invert: y [
	^ input scale: y
]

{ #category : #accessing }
RTScaleLinear >> range: r [
	super range: r.
	self rescale.
]

{ #category : #hooks }
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

{ #category : #accessing }
RTScaleLinear >> scale: x [
	^ output scale: x.
]
