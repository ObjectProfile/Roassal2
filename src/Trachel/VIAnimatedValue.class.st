"
A VIAnimatedValue is A representation of some property value animated in certain kind of time.

The main idea is you can change some property in some time.
in evaluator, recibe a block to handle as f(t).


"
Class {
	#name : #VIAnimatedValue,
	#superclass : #Object,
	#instVars : [
		'evaluator',
		'timer',
		'finishCallback'
	],
	#category : #'Trachel-Viva'
}

{ #category : #grouping }
VIAnimatedValue >> + aValue [

	^ [ self value + aValue value ]

"	self error: 'Not supported yet'"

"	^VIAnimatedGroup new 
		add:self;
		add:aVIAnimatedValue."
]

{ #category : #secuence }
VIAnimatedValue >> , aVIAnimatedValue [ 
	self error: 'Not yet supported'
"	^VIAnimatedSecuence new
		add:self;
		add:aVIAnimatedValue.
	"
]

{ #category : #grouping }
VIAnimatedValue >> - aValue [

	^ [ self value - aValue value ]

]

{ #category : #actions }
VIAnimatedValue >> animatedPoint: aPoints [
	| pnts |
	pnts := aPoints asSortedCollection.
	self evaluator: [ :t |
		| inicial fin |
		inicial := nil.
		fin := nil.
		
		pnts do:[ :e | 
	 	    e key <= t 
			ifTrue: [ inicial:= e ] 
			ifFalse:[fin isNil ifTrue:[fin:= e] ]
	 	].
		inicial value interpolateTo: fin value at: t.
	 ].
]

{ #category : #actions }
VIAnimatedValue >> animatedValue: values [
	| val fraction currentValue |
	fraction := 1.0 / (values size -1).
	currentValue:= 0.
	self animatedPoint: 
		(values collect: [ :e | val := currentValue -> e. currentValue:= currentValue + fraction. val]).
]

{ #category : #accessing }
VIAnimatedValue >> animationDidFinish [
	timer value = 1.0
		ifTrue: [ finishCallback value ].
]

{ #category : #accessing }
VIAnimatedValue >> evaluator [
	
	^ evaluator
]

{ #category : #accessing }
VIAnimatedValue >> evaluator: anObject [
	evaluator := anObject
]

{ #category : #accessing }
VIAnimatedValue >> finishCallback: anObject [
	finishCallback := anObject
]

{ #category : #testing }
VIAnimatedValue >> hasCompleted [
	^ timer value = 1.0
]

{ #category : #actions }
VIAnimatedValue >> initialize [
	super initialize.
	timer := VITimer new.
]

{ #category : #actions }
VIAnimatedValue >> reset [
	timer reset
]

{ #category : #actions }
VIAnimatedValue >> start [
	timer start
]

{ #category : #actions }
VIAnimatedValue >> stop [
	timer stop
]

{ #category : #accessing }
VIAnimatedValue >> timer [
	^ timer
]

{ #category : #accessing }
VIAnimatedValue >> timer: anObject [
	timer := anObject
]

{ #category : #accessing }
VIAnimatedValue >> value [
	" evaluate the value of receiver at current time "
	self animationDidFinish.
	^ evaluator value: timer value
]
