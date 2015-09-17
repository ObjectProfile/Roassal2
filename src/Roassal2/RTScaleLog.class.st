Class {
	#name : #RTScaleLog,
	#superclass : #RTScaleLinear,
	#instVars : [
		'linear',
		'base',
		'positive'
	],
	#category : #'Roassal2-Scaling'
}

{ #category : #accessing }
RTScaleLog >> base: number [
	base := number.
	linear domain: (domain collect: [:n | self lg: n ]).
]

{ #category : #accessing }
RTScaleLog >> clamp: x [
	 linear clamp: x
]

{ #category : #accessing }
RTScaleLog >> domain: arr [
	positive := arr first >= 0.
	domain := arr.
	linear domain: (arr collect: [:n | self lg: n]).
]

{ #category : #initialization }
RTScaleLog >> initialize [
	super initialize.
	linear := RTScaleLinear new domain: #(0 1).
	base := 10.
	positive := true.
	domain := #(1 10). 
]

{ #category : #accessing }
RTScaleLog >> interpolate: x [
	linear interpolate: x
]

{ #category : #transformations }
RTScaleLog >> invert: x [
	^ self pow: (linear invert: x).
]

{ #category : #'math functions' }
RTScaleLog >> lg: x [
	"logarithm"
	^ (positive 
		ifTrue: [ (x < 0 ifTrue: [ 0 ] ifFalse: [ x ]) ln ]
		ifFalse: [ (x > 0 ifTrue: [ 0 ] ifFalse: [ 0 - x ] ) ln negated ])
		/ (base ln).
]

{ #category : #utilities }
RTScaleLog >> nice [
	"TODO"
]

{ #category : #'math functions' }
RTScaleLog >> pow: x [
	^ positive  
		ifTrue: [ base raisedTo: x ]
		ifFalse: [ (base raisedTo: x negated) negated ].
		
]

{ #category : #accessing }
RTScaleLog >> range: x [
	linear range: x
]

{ #category : #accessing }
RTScaleLog >> scale: x [
	^ linear scale: (self lg: x)
]

{ #category : #utilities }
RTScaleLog >> ticks [
	"TODO"
]
