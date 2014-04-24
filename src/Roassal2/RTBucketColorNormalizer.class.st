"
A scale of elements is discretized into buckets where elements of each bucket is associated to an element. The buckets are formed by creating partitions uniformly.

"
Class {
	#name : #RTBucketColorNormalizer,
	#superclass : #RTAbstractNormalizer,
	#instVars : [
		'colorScheme',
		'numberOfBuckets',
		'scope',
		'buckets'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #examples }
RTBucketColorNormalizer class >> example [
	
	|n elements view|
	n := RTBucketColorNormalizer numberOfColors: 5 command: #asInteger scope: ($a to: $z).
	n colorScheme: 'Blues'.
	elements := (RTBox new size: 20; color: n) elementsOn: ($a to: $z).
	view := RTView new.
	view addAll: elements.
	RTGridLayout on: view elements.
	view open.

]

{ #category : #examples }
RTBucketColorNormalizer class >> example1 [
	
	|n elements view |
	n := RTBucketColorNormalizer numberOfColors: 5 scope: (1 to: 35).
	elements := (RTBox new size: 20; color: n) elementsOn: (1 to: 30).
	view := RTView new.
	view addAll: elements.
	RTGridLayout on: view elements.
	view open.

]

{ #category : #public }
RTBucketColorNormalizer class >> numberOfColors: anInteger command: aSymboOrBlock  scope: aCollection [

	^ self new
		numberOfBuckets: anInteger;
		command: aSymboOrBlock;
		scope: aCollection.
]

{ #category : #public }
RTBucketColorNormalizer class >> numberOfColors: anInteger scope: aCollection [

	^ self numberOfColors: anInteger command: #yourself  scope: aCollection
]

{ #category : #'as yet unclassified' }
RTBucketColorNormalizer >> bucketIndexOf: anObject [

	|value |
	value := command value: anObject.
	^ (self buckets collect: #first) detect: [ :step | value <= step ]. 
	
]

{ #category : #'as yet unclassified' }
RTBucketColorNormalizer >> buckets [

	^ buckets ifEmpty: [ self initializeBuckets. buckets ]
]

{ #category : #'as yet unclassified' }
RTBucketColorNormalizer >> colorScheme: aString [

	colorScheme := aString.
]

{ #category : #'as yet unclassified' }
RTBucketColorNormalizer >> defaultPalette [

	^ ColorPalette diverging colors: numberOfBuckets scheme:'RdBu'
]

{ #category : #initialize }
RTBucketColorNormalizer >> initialize [

	super initialize.
	buckets := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
RTBucketColorNormalizer >> initializeBuckets [
	
	|values min max delta  |
	values := scope collect: [:v | command rtValue: v].
	values sort: [ :a :b | a < b ].
	max := values max.
	min := values min.
	delta := (max - min)/numberOfBuckets.

	((min + delta) to: max by: delta) with: self palette do: [ :i :c |
			buckets add:  {i .  c}
		 ].
	buckets := buckets sort: [:a :b | a first < b first].
]

{ #category : #'as yet unclassified' }
RTBucketColorNormalizer >> numberOfBuckets: anInteger [

	numberOfBuckets := anInteger
]

{ #category : #'as yet unclassified' }
RTBucketColorNormalizer >> palette [

	^ colorScheme isNil 
		ifTrue: [ self defaultPalette ]
		ifFalse: [ (ColorPalette paletteFor: colorScheme) colors: numberOfBuckets scheme: colorScheme
			]
]

{ #category : #'as yet unclassified' }
RTBucketColorNormalizer >> rtValue: anObject [

	^ (self buckets detect: [ :pair | pair first = (self bucketIndexOf: anObject) ] ) second	

]

{ #category : #'as yet unclassified' }
RTBucketColorNormalizer >> scope: groupOfObjects [
	"The argument is used to determine the maximum value. Command is executed on each of elements of the group passed as argument"
	scope := groupOfObjects
]
