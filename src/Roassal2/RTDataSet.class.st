Class {
	#name : #RTDataSet,
	#superclass : #RTObject,
	#instVars : [
		'points',
		'x',
		'y',
		'builder',
		'dotBuilder',
		'lineBuilder',
		'minX',
		'maxX',
		'minY',
		'maxY',
		'shouldConnect',
		'interaction'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #'as yet unclassified' }
RTDataSet >> adjustMinAndMaxValues [
	"Values are adjusted to always have 0 @ 0 in the chart"
	minY > 0
		ifTrue: [ minY := 0 ].
	maxY < 0
		ifTrue: [ maxY := 0 ].
		
	minX > 0
		ifTrue: [ minX := 0 ].
	maxX < 0
		ifTrue: [ maxX := 0 ].
]

{ #category : #'as yet unclassified' }
RTDataSet >> builder: aBuilder [
	builder := aBuilder 
]

{ #category : #'as yet unclassified' }
RTDataSet >> computeMinAndMax [
	self computeMinAndMaxForX.
	self computeMinAndMaxForY.
]

{ #category : #'as yet unclassified' }
RTDataSet >> computeMinAndMaxForX [
	| computed |
	computed := points collect: x.
	minX := computed min.
	maxX := computed max.


]

{ #category : #'as yet unclassified' }
RTDataSet >> computeMinAndMaxForY [
	| computed |
	computed := points collect: y.
	minY := computed min.
	maxY := computed max.


]

{ #category : #'as yet unclassified' }
RTDataSet >> connect [
	shouldConnect := true
]

{ #category : #'as yet unclassified' }
RTDataSet >> connectColor: aColor [
	^ self connectUsing: (RTLine new color: aColor)
]

{ #category : #'as yet unclassified' }
RTDataSet >> connectUsing: aShape [
	lineBuilder shape: aShape.
	self connect
]

{ #category : #'as yet unclassified' }
RTDataSet >> defaultMaxValue [
	^ 1000000
]

{ #category : #'as yet unclassified' }
RTDataSet >> defaultMinValue [
	^ -1000000
]

{ #category : #'as yet unclassified' }
RTDataSet >> dotShape [
	^ dotBuilder
]

{ #category : #'as yet unclassified' }
RTDataSet >> initialize [
	super initialize.
	points := #().
	x := #yourself.
	y := #yourself.
	self resetMinAndMax.
	
	dotBuilder := RTShapeBuilder new.
	dotBuilder circle size: 5.
	
	lineBuilder := RTShapeBuilder new.
	interaction := RTInteractionBuilder new.
	shouldConnect := false
]

{ #category : #'as yet unclassified' }
RTDataSet >> interaction [
	^ interaction
]

{ #category : #'as yet unclassified' }
RTDataSet >> lineShape [
	^ lineBuilder
]

{ #category : #accessing }
RTDataSet >> maxX [
	^ maxX
]

{ #category : #accessing }
RTDataSet >> maxX: anObject [
	maxX := anObject
]

{ #category : #accessing }
RTDataSet >> maxY [
	^ maxY
]

{ #category : #accessing }
RTDataSet >> maxY: anObject [
	maxY := anObject
]

{ #category : #accessing }
RTDataSet >> minX [
	^ minX
]

{ #category : #accessing }
RTDataSet >> minX: anObject [
	minX := anObject
]

{ #category : #accessing }
RTDataSet >> minY [
	^ minY
]

{ #category : #accessing }
RTDataSet >> minY: anObject [
	minY := anObject
]

{ #category : #'as yet unclassified' }
RTDataSet >> points [
	^ points
]

{ #category : #'as yet unclassified' }
RTDataSet >> points: objects [
	points := objects
]

{ #category : #'as yet unclassified' }
RTDataSet >> renderIn: aView [

	| elements |
	elements := dotBuilder elementsOn: points.
	builder view addAll: elements.
	interaction setUpElements: elements.
	
"	self computeMinAndMax.
	self adjustMinAndMaxValues.
"	RTMetricNormalizer new
		elements: elements;
		normalizeX: [ :model | x rtValue: model ]
			min: 0
			max: builder extent x
			minValue: minX
			maxValue: maxX.
			
	RTMetricNormalizer new
		elements: elements;
		normalizeY: [ :model | y rtValue: model ]
			min: 0
			max: builder extent y negated
			minValue: minY
			maxValue: maxY.
			
	self renderLinesFor: elements in: aView
]

{ #category : #'as yet unclassified' }
RTDataSet >> renderLinesFor: elements in: aView [
	| t |
	shouldConnect ifFalse: [ ^ self ].
	t := elements first.
	elements allButFirst
		do: [ :tt | 
			aView add: (lineBuilder edgeFrom: t to: tt).
			t := tt ]
]

{ #category : #'as yet unclassified' }
RTDataSet >> resetMinAndMax [

	minY := self defaultMaxValue.
	maxY := self defaultMinValue.
	minX := self defaultMaxValue.
	maxX := self defaultMinValue.

]

{ #category : #'as yet unclassified' }
RTDataSet >> shouldConnect [
	^ shouldConnect
]

{ #category : #'as yet unclassified' }
RTDataSet >> stackX [
	
]

{ #category : #'as yet unclassified' }
RTDataSet >> x: blockOrSymbol [
	x := blockOrSymbol
]

{ #category : #'as yet unclassified' }
RTDataSet >> y: blockOrSymbol [
	y := blockOrSymbol
]
