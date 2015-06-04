Class {
	#name : #RTScaleLinear,
	#superclass : #RTScale,
	#instVars : [
		'range',
		'domain',
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
	domain := x.
	self rescale.
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> initialize [
	super initialize.
	domain := {0. 1}.
	range := {0. 1}.
	clamp := false. 
	self rescale.
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> invert: y [
	^ input scale: y
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> range: r [
	range := r.
	self rescale.
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> rescale [
	| linear uninterpolate |
	linear := (domain size min: range size ) > 2
		ifTrue: [ RTScalePolylinear ]
		ifFalse: [ RTScaleBilinear ].
	uninterpolate := clamp
		ifTrue: [ RTUninterpolateClamp ]
		ifFalse: [ RTUninterpolateNumber ].
	output := 1.
	input := 2.
]

{ #category : #'as yet unclassified' }
RTScaleLinear >> scale: x [
	output scale: x.
]
