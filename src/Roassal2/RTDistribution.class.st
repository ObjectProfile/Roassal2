Class {
	#name : #RTDistribution,
	#superclass : #Object,
	#instVars : [
		'numbers'
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
	| answer s amountOfK |
	answer := OrderedCollection new.
	s := numbers asSet asSortedCollection: [ :a :b | a < b ].
	s do: [ :k |
		amountOfK := (numbers select: [ :vv | vv = k ]) size.
		answer add: (Array with: amountOfK with: k) ].
	^ answer asArray
]

{ #category : #public }
RTDistribution >> annotatedFrequencyMin: numberMin max: numberMax amountOfIntervals: nbOfIntervals [
	"Return a list of elements, each following the template:
	{ c1 . c2 . elements that are between c1 and c2 }
	{ c2 . c3 . elements that are between c2 and c3 }
	...
	
	We have c1 <= c2 <= c3 <= ...
	c1 = numberMin
	cN = numberMax
	N = nbOfIntervals
	 "

	| interval running tmp result |
	interval := ((numberMax + 1 - numberMin) / nbOfIntervals).
	running := numberMin.
	
	tmp := numbers copy.
	result := OrderedCollection new.
	[ running asFloat < numberMax ] whileTrue: [ 
		| c |
		c := tmp select: [ :v | v >= running and: [ v < (running + interval) ]].
		result add: (Array with: running with: interval + running with: c asArray).
		tmp := tmp copyWithoutAll: c.
		running := running + interval ].
	
	^ result asArray
	
]

{ #category : #public }
RTDistribution >> annotatedFrequencyWithAmountOfIntervals: aSmallInteger [ 
	^ self annotatedFrequencyMin: numbers min max: numbers max amountOfIntervals: aSmallInteger
]

{ #category : #public }
RTDistribution >> frequency [
	^ self frequencyWithAmountOfIntervals: self amountOfDifferentValues
]

{ #category : #public }
RTDistribution >> frequencyMin: numberMin max: numberMax amountOfIntervals: nbOfIntervals [

	| interval running tmp result |
	interval := ((numberMax + 1 - numberMin) / nbOfIntervals).
	running := numberMin.
	
	tmp := numbers copy.
	result := OrderedCollection new.
	[ running asFloat < numberMax ] whileTrue: [ 
		| c |
		c := tmp select: [ :v | v >= running and: [ v < (running + interval) ]].
		result add: c asArray.
		tmp := tmp copyWithoutAll: c.
		running := running + interval ].
	
	^ result asArray
	
]

{ #category : #public }
RTDistribution >> frequencyWithAmountOfIntervals: aSmallInteger [ 
	^ self frequencyMin: numbers min max: numbers max amountOfIntervals: aSmallInteger
]

{ #category : #public }
RTDistribution >> on: collectionOfNumbers [
	numbers := collectionOfNumbers
]
