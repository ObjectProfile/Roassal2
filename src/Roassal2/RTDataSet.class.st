Class {
	#name : #RTDataSet,
	#superclass : #RTObject,
	#instVars : [
		'points',
		'x',
		'y',
		'builder',
		'dotBuilder',
		'histogramBuilder',
		'lineBuilder',
		'minX',
		'maxX',
		'minY',
		'maxY',
		'shouldHaveHistogramBars',
		'shouldConnect',
		'interaction'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #public }
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
RTDataSet >> barShape [
	shouldHaveHistogramBars := true.
	^ histogramBuilder
]

{ #category : #accessing }
RTDataSet >> builder: aBuilder [
	builder := aBuilder 
]

{ #category : #'min and max' }
RTDataSet >> computeMinAndMax [
	self computeMinAndMaxForX.
	self computeMinAndMaxForY.
]

{ #category : #'min and max' }
RTDataSet >> computeMinAndMaxForX [
	| computed |
	computed := points collect: x.
	minX := computed min.
	maxX := computed max.


]

{ #category : #'min and max' }
RTDataSet >> computeMinAndMaxForY [
	| computed |
	computed := points collect: y.
	minY := computed min.
	maxY := computed max.


]

{ #category : #ssl }
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

{ #category : #initialization }
RTDataSet >> defaultMaxValue [
	^ 1000000
]

{ #category : #initialization }
RTDataSet >> defaultMinValue [
	^ -1000000
]

{ #category : #'as yet unclassified' }
RTDataSet >> dotShape [
	^ dotBuilder
]

{ #category : #initialization }
RTDataSet >> initialize [
	super initialize.
	points := #().
	x := #yourself.
	y := #yourself.
	self resetMinAndMax.
	
	dotBuilder := RTShapeBuilder new.
	dotBuilder circle size: 5.
	
	"Maybe this can be lazily done"
	histogramBuilder := RTShapeBuilder new.
	histogramBuilder rectangle.
	
	"Maybe this can be lazily done"
	lineBuilder := RTShapeBuilder new.
	
	interaction := RTInteractionBuilder new.
	shouldConnect := false.
	shouldHaveHistogramBars := false
]

{ #category : #accessing }
RTDataSet >> interaction [
	^ interaction
]

{ #category : #accessing }
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

{ #category : #accessing }
RTDataSet >> points [
	^ points
]

{ #category : #accessing }
RTDataSet >> points: objects [
	points := objects
]

{ #category : #hooks }
RTDataSet >> renderDotAndLinesIn: aView [

	| elements |
	elements := dotBuilder elementsOn: points.
	builder view addAll: elements.
	interaction setUpElements: elements.
	
	RTMetricNormalizer new
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

{ #category : #hooks }
RTDataSet >> renderHistogramIn: aView [

	| elements  |
	elements := histogramBuilder elementsOn: points.
		
	builder view addAll: elements.
	interaction setUpElements: elements.
	
	RTMetricNormalizer new
		elements: elements;
		normalizeX: [ :model | x rtValue: model ]
			min: 0
			max: builder extent x
			minValue: minX
			maxValue: maxX.
			
	RTMetricNormalizer new
		elements: elements;
		normalizeHeight: [ :model | y rtValue: model ]
			min: 0
			max: builder extent y
			minValue: minY
			maxValue: maxY.
	
	TRConstraint alignFromBottom: elements.
	
"	elements do: [ :el |
		bar := (histogramBuilder current height: el position y abs; width: 10) elementOn: el model.
		bar translateTo: el position x @ (el position y / 2) ].
"	
	"self renderLinesFor: elements in: aView"
]

{ #category : #hooks }
RTDataSet >> renderIn: aView [

	"This is a bit ugly. Maybe having a class hierarchy would be better"
	shouldHaveHistogramBars 
		ifTrue: [ self renderHistogramIn: aView ]
		ifFalse: [ self renderDotAndLinesIn: aView ]
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

{ #category : #accessing }
RTDataSet >> shouldConnect [
	^ shouldConnect
]

{ #category : #public }
RTDataSet >> stackX [
	self x: [ :aPoint | points indexOf: aPoint ]
]

{ #category : #accessing }
RTDataSet >> x: blockOrSymbol [
	x := blockOrSymbol
]

{ #category : #accessing }
RTDataSet >> y: blockOrSymbol [
	y := blockOrSymbol
]
