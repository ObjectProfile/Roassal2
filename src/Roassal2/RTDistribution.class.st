"
frequency distrubution of a collection.

number of classes defined by default in #defaultNumberOfIntervals, a common calcul to have an optimized number of classes.

"
Class {
	#name : #RTDistribution,
	#superclass : #Object,
	#instVars : [
		'numbers',
		'numberMax',
		'nbOfIntervals',
		'numberMin',
		'interval',
		'strategyBlock'
	],
	#category : #'Roassal2-Utility'
}

{ #category : #public }
RTDistribution class >> on: anArray [ 
	^ self new on: anArray
]

{ #category : #computing }
RTDistribution >> amountOfDifferentValues [
	^ numbers asSet size
]

{ #category : #public }
RTDistribution >> annotatedFrequency [
	"Return a list of elements, each following the template:
	{numberOfV . v} "
	| fr result |
 
	fr := self frequencyMin: numbers min max: numbers max amountOfIntervals: self defaultNumberOfIntervals.
	
	result := fr collect: [ :f | { f size. f } ].
	
	^ result asArray
]

{ #category : #public }
RTDistribution >> annotatedFrequencyMin: numMin max: numMax amountOfIntervals: aNbOfIntervals [
	"	Return a list of elements, each following the template:
	{numberOfElementOfV . V} "
	| fr result |
	 
	fr := self frequencyMin: numMin max: numMax amountOfIntervals: aNbOfIntervals.
	
	result := fr collect: [ :f | { f size. f } ].
	
	^ result asArray
	
]

{ #category : #public }
RTDistribution >> annotatedFrequencyWithAmountOfIntervals: aSmallInteger [ 
	^ self annotatedFrequencyMin: numbers min max: numbers max amountOfIntervals: aSmallInteger
]

{ #category : #computing }
RTDistribution >> defaultNumberOfIntervals [
	^ (numbers size) log * 3.3 + 1 
]

{ #category : #public }
RTDistribution >> defaultStrategyBlock [
	"This block define which bucket to store in, a given number"
	self strategyBlock: 
		[ :number |
			number = numberMax
				ifTrue: nbOfIntervals
				ifFalse: [ ((number - numberMin) / interval) floor + 1] 
			]
]

{ #category : #public }
RTDistribution >> deprecatedAnnotatedFrequencyMin: numMin max: numMax amountOfIntervals: aNbOfIntervals [
	"Return a list of elements, each following the template:
	{ c1 . c2 . elements that are between c1 and c2 }
	{ c2 . c3 . elements that are between c2 and c3 }
	...
	
	We have c1 <= c2 <= c3 <= ...
	c1 = numberMin
	cN = numberMax
	N = nbOfIntervals
	 "
	| running tmp result |
	self numberMax: numMax.
	self numberMin: numMin.
	self nbOfIntervals: aNbOfIntervals.
	interval := ((numberMax + 1 - numberMin) / nbOfIntervals).
	running := numberMin.
	
	tmp := numbers copy.
	result := OrderedCollection new.
	[ running asFloat <= numberMax ] whileTrue: [ 
		| c |
		c := tmp select: [ :v | v >= running and: [ v < (running + interval) ]].
		result add: (Array with: running with: interval + running with: c asArray).
		tmp := tmp copyWithoutAll: c.
		running := running + interval ].
	
	^ result asArray
	
]

{ #category : #public }
RTDistribution >> frequency [
	^ self frequencyWithAmountOfIntervals: self defaultNumberOfIntervals.
]

{ #category : #public }
RTDistribution >> frequencyMin: numMin max: numMax amountOfIntervals: aNbOfIntervals [
	| tmp result bucketFor |
	self numberMax: numMax.
	self numberMin: numMin.
	self nbOfIntervals: aNbOfIntervals.
	
	self interval: (numberMax - numberMin) / (nbOfIntervals floor).
	
	bucketFor := [ :number |
		number = numberMax
			ifTrue: nbOfIntervals
			ifFalse: [ ((number - numberMin) / interval) floor + 1] 
			].
	tmp := numbers copy.
	result := (1 to: nbOfIntervals) collect: [ :i | OrderedCollection new ].
	tmp do: [ :num | (result at: (bucketFor value: num)) add: num ].
	^ result asArray
]

{ #category : #public }
RTDistribution >> frequencyWithAmountOfIntervals: aSmallInteger [ 
	^ self frequencyMin: numbers min max: numbers max amountOfIntervals: aSmallInteger
]

{ #category : #public }
RTDistribution >> initialize [
	super initialize.
	self defaultStrategyBlock.
]

{ #category : #public }
RTDistribution >> interval: aSize [
	interval := aSize
]

{ #category : #public }
RTDistribution >> nbOfIntervals: aNumber [
	nbOfIntervals := aNumber 
]

{ #category : #public }
RTDistribution >> numberMax: aNumber [
	numberMax := aNumber 
]

{ #category : #public }
RTDistribution >> numberMin: aNumber [
	numberMin := aNumber 
]

{ #category : #public }
RTDistribution >> on: collectionOfNumbers [
	self assert: (collectionOfNumbers isNotEmpty).
	numbers := collectionOfNumbers sort.
]

{ #category : #public }
RTDistribution >> strategyBlock [
	^ strategyBlock
]

{ #category : #public }
RTDistribution >> strategyBlock: aBlock [
"This block define which bucket to store in, a given number"
	strategyBlock := aBlock 
]
