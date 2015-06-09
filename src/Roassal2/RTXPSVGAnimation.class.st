Class {
	#name : #RTXPSVGAnimation,
	#superclass : #RTAnimation,
	#instVars : [
		'curves0',
		'curves1',
		'animatedValue'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTXPSVGAnimation >> curvesFor: index [
	| t res acurves bcurves c2 |
	t := animatedValue value.
	acurves := curves0 at: index.
	bcurves := curves1 at: index .
	res := Array new: acurves size.
	
	acurves doWithIndex: [ :c1 :i | 
		c2 := bcurves at: i.
		res at: i put: c1 key -> (Array with: (c1 value first interpolateTo: c2 value first at: t))  ].
	
	^ res
]

{ #category : #'as yet unclassified' }
RTXPSVGAnimation >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #'as yet unclassified' }
RTXPSVGAnimation >> on: elements during: seconds path: aBlock [
	
	| time |
	element := (elements isKindOf: RTGroup)
		ifTrue: [ elements] 
		ifFalse: [ RTGroup new add: elements ].
	curves0 := element collect: [ :e | e trachelShape curves ].
	curves1 := element collect: [ :e | e trachelShape path:( aBlock rtValue: e); curves.].
	time := curves0 size = curves1 size ifTrue: [ 0 max: seconds ] ifFalse: [ 0 ].
	animatedValue := VIAnimatedValue new
		evaluator: [ :t | t ];
		timer: (VITimer new cycleLength: time);
		yourself.
		
]

{ #category : #'as yet unclassified' }
RTXPSVGAnimation >> refresh [
	element doWithIndex: [ :e :i |
		e trachelShape
			curves: (self curvesFor: i);
			computePath.
		].
	element signalUpdate.

	
]

{ #category : #'as yet unclassified' }
RTXPSVGAnimation >> start [
	animatedValue start
]
