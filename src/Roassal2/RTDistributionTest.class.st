"
A GETDistributionTest is a test class for testing the behavior of GETDistribution
"
Class {
	#name : #RTDistributionTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Utility'
}

{ #category : #tests }
RTDistributionTest >> testAnnotatedFrequency [
	| set d f |
	set := #(2 2 2 5 5).
	d := RTDistribution on: set.
	f := d annotatedFrequency.
	self assert: d amountOfDifferentValues = 2.
	self assert: f = (Array with: {3. (OrderedCollection with:2 with:2 with:2)} with: {0. (OrderedCollection new)} with: {2. (OrderedCollection with:5 with:5)})

]

{ #category : #tests }
RTDistributionTest >> testBasic [

	| numbers distribution values |
	numbers := #(5 2 1 8 1 2 4 8 1 9 7 3 7).
	distribution := RTDistribution on: numbers.
	values := distribution frequencyMin: 1 max: 9 amountOfIntervals: 3.
	
	self assert: values size = 3.
	self assert: values first = ((numbers select: [ :n | n < 4 ]) asOrderedCollection).
	self assert: values second = ((numbers select: [ :n | n >= 4 and: [ n < 6 ] ]) asOrderedCollection).
	self assert: values third = ((numbers select: [ :n | n >= 6 ]) asOrderedCollection).
]

{ #category : #tests }
RTDistributionTest >> testBasic2 [

	| numbers distribution values |
	numbers := #(5 2 1 8 1 2 4 8 1 9 7 3 7).
	distribution := RTDistribution on: numbers.
	values := distribution frequencyWithAmountOfIntervals: 3.
	
	self assert: values size = 3.
	self assert: values first = ((numbers select: [ :n | n < 4 ]) asOrderedCollection).
	self assert: values second = ((numbers select: [ :n | n >= 4 and: [ n < 6 ] ]) asOrderedCollection).
	self assert: values third = ((numbers select: [ :n | n >= 6 ]) asOrderedCollection).
]

{ #category : #tests }
RTDistributionTest >> testFrequency [
	| set d f |
	set := #(3 31 17 17 20 50 9 32 47 2 8 36 30 33 49 31 18 25 21 31 1 37 1 40 46 16 18 20 30 29 4 49 31 45 25 44 12 16 23 27 5 41 20 23 29 17 7 20 13 11).
	d := RTDistribution on: set.
	
	self assert: d amountOfDifferentValues = set asSet size.
	
	f := d frequency.
	self assert: f size = 6.
]

{ #category : #tests }
RTDistributionTest >> testFrequencyOfObjects [
	| set d f |
	set := {'yes'. 'yes'. 'no'. 'maybe'. 'no'. 'maybe'. 'maybe'. 'yes'. 'no'. 'maybe'. 'yes'. 'maybe'.}.
	d := RTDistribution on: set.
	
	self assert: d amountOfDifferentValues = set asSet size.
	
	f := d annotatedFrequencyWithAmountOfIntervals: d amountOfDifferentValues.
	self assert: f size = 3.
	self assert: f = (Array with: {4. (OrderedCollection with:'yes' with:'yes' with:'yes' with:'yes')} with: {3. (OrderedCollection with:'no' with:'no' with:'no')} with: {5. (OrderedCollection with:'maybe' with:'maybe' with:'maybe' with:'maybe' with:'maybe')})
]

{ #category : #tests }
RTDistributionTest >> testFrequencyWithSetSize [
	| set d f |
	set := #(3 31 17 17 20 50 9 32 47 2 8 36 30 33 49 31 18 25 21 31 1 37 1 40 46 16 18 20 30 29 4 49 31 45 25 44 12 16 23 27 5 41 20 23 29 17 7 20 13 11).
	d := RTDistribution on: set.
	
	self assert: d amountOfDifferentValues = set asSet size.
	
	f := d frequencyWithAmountOfIntervals: set asSet size.
	self assert: f size = set asSet size.
]
