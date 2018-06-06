"
I scale using pow function
"
Class {
	#name : #RTScalePow,
	#superclass : #RTScaleLinear,
	#instVars : [
		'exponent',
		'powp',
		'powb',
		'linear'
	],
	#category : #'Roassal2-Builder-Grapher-Scaling'
}

{ #category : #accessing }
RTScalePow >> exponent [
	^ exponent
]

{ #category : #accessing }
RTScalePow >> exponent: x [
	exponent := x.
	powp exponent: exponent.
	powb exponent: 1/exponent.
	linear domain: (domain collect: [ :i | powp scale: i ])
]

{ #category : #initialization }
RTScalePow >> initialize [
	super initialize.
	linear := self class linear.
	exponent := 1.
	domain := #(0 1).
	powp := RTScalePowPow exponent: exponent.
	powb := RTScalePowPow exponent: 1 / exponent.
]

{ #category : #transformations }
RTScalePow >> invert: x [
	^ powb scale: (linear invert: x)
]

{ #category : #hooks }
RTScalePow >> rescale [
]

{ #category : #accessing }
RTScalePow >> scale: x [
	^ linear scale: (powp scale: x)
]
