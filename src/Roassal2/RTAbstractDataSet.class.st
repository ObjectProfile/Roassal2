Class {
	#name : #RTAbstractDataSet,
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
		'interaction',
		'elementActions'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #public }
RTAbstractDataSet >> adjustMinAndMaxValues [
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
RTAbstractDataSet >> barShape [
	shouldHaveHistogramBars := true.
	^ histogramBuilder
]

{ #category : #accessing }
RTAbstractDataSet >> builder: aBuilder [
	builder := aBuilder 
]

{ #category : #'min and max' }
RTAbstractDataSet >> computeMinAndMax [
	self computeMinAndMaxForX.
	self computeMinAndMaxForY.
]

{ #category : #'min and max' }
RTAbstractDataSet >> computeMinAndMaxForX [
	| computed |
	computed := points collect: x.
	minX := computed min.
	maxX := computed max.

	(minX < 0 and: [maxX < 0]) ifTrue: [ maxX := 0 ].
	(minX > 0 and: [maxX > 0]) ifTrue: [ minX := 0 ].
	


]

{ #category : #'min and max' }
RTAbstractDataSet >> computeMinAndMaxForY [
	| computed |
	computed := points collect: y.
	minY := computed min.
	maxY := computed max.
	
	(minY < 0 and: [maxY < 0]) ifTrue: [ maxY := 0 ].
	(minY > 0 and: [maxY > 0]) ifTrue: [ minY := 0 ].
	
]

{ #category : #ssl }
RTAbstractDataSet >> connect [
	shouldConnect := true
]

{ #category : #'as yet unclassified' }
RTAbstractDataSet >> connectColor: aColor [
	^ self connectUsing: (RTLine new color: aColor)
]

{ #category : #'as yet unclassified' }
RTAbstractDataSet >> connectUsing: aShape [
	lineBuilder shape: aShape.
	self connect
]

{ #category : #initialization }
RTAbstractDataSet >> defaultMaxValue [
	^ 1000000
]

{ #category : #initialization }
RTAbstractDataSet >> defaultMinValue [
	^ -1000000
]

{ #category : #'as yet unclassified' }
RTAbstractDataSet >> dotShape [
	^ dotBuilder
]

{ #category : #public }
RTAbstractDataSet >> dotSize: metricAsBlockOrSymbol min: minValue max: maxValue using: transformation [

	elementActions add: [ :elements |
		RTMetricNormalizer new
			elements: elements;
			normalizeSize: metricAsBlockOrSymbol min: minValue max: maxValue using: transformation ]
]

{ #category : #public }
RTAbstractDataSet >> highlightIf: aOneArgBlock using: secondOneArgBlock [
	"
	aOneArgBlock is the a one-arg condition
	If true, secondOneArgBlock is then used for the label
	"

	elementActions add: [ :elements |
		elements do: [ :element |
		(aOneArgBlock rtValue: element model) ifTrue: [ 
			element @ (RTLabelled new text: [ :model | secondOneArgBlock rtValue: model ]; setAsHighlightable).
		] ] ]
]

{ #category : #initialization }
RTAbstractDataSet >> initialize [
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
	shouldHaveHistogramBars := false.
	
	elementActions := OrderedCollection new.
]

{ #category : #accessing }
RTAbstractDataSet >> interaction [
	^ interaction
]

{ #category : #accessing }
RTAbstractDataSet >> lineShape [
	^ lineBuilder
]

{ #category : #accessing }
RTAbstractDataSet >> maxX [
	^ maxX
]

{ #category : #accessing }
RTAbstractDataSet >> maxX: anObject [
	maxX := anObject
]

{ #category : #accessing }
RTAbstractDataSet >> maxY [
	^ maxY
]

{ #category : #accessing }
RTAbstractDataSet >> maxY: anObject [
	maxY := anObject
]

{ #category : #accessing }
RTAbstractDataSet >> minX [
	^ minX
]

{ #category : #accessing }
RTAbstractDataSet >> minX: anObject [
	minX := anObject
]

{ #category : #accessing }
RTAbstractDataSet >> minY [
	^ minY
]

{ #category : #accessing }
RTAbstractDataSet >> minY: anObject [
	minY := anObject
]

{ #category : #accessing }
RTAbstractDataSet >> numberOfPoints [
	"Return the number of points the dataset is representing"
	^ points size
]

{ #category : #accessing }
RTAbstractDataSet >> points [
	^ points
]

{ #category : #accessing }
RTAbstractDataSet >> points: objects [
	points := objects
]

{ #category : #hooks }
RTAbstractDataSet >> renderDotAndLinesIn: aView [

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
			
	elementActions do: [ :act | act rtValue: elements ].
			
	self renderLinesFor: elements in: aView
]

{ #category : #hooks }
RTAbstractDataSet >> renderHistogramIn: aView [

	| elements  |
	elements := histogramBuilder elementsOn: points.
		
	builder view addAll: elements.
	interaction setUpElements: elements.
	
	  
			RTMetricNormalizer new
				elements: elements;
				normalizeElementX: [ :element | (elements indexOf: element) + 1 ] 
					min: 0
					max: builder extent x 
					minValue: 1 
					maxValue: elements size + 1 .
	"RTMetricNormalizer new
		elements: elements;
		normalizeX: [ :model | x rtValue: model ]
			min: 0
			max: builder extent x
			minValue: minX
			maxValue: maxX."
			
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
RTAbstractDataSet >> renderIn: aView [

	"This is a bit ugly. Maybe having a class hierarchy would be better"
	shouldHaveHistogramBars 
		ifTrue: [ self renderHistogramIn: aView ]
		ifFalse: [ self renderDotAndLinesIn: aView ]
]

{ #category : #'as yet unclassified' }
RTAbstractDataSet >> renderLinesFor: elements in: aView [
	| t |
	shouldConnect ifFalse: [ ^ self ].

	t := elements first.
	elements allButFirst
		do: [ :tt | 
			aView add: (lineBuilder edgeFrom: t to: tt).
			t := tt ]
]

{ #category : #'as yet unclassified' }
RTAbstractDataSet >> resetMinAndMax [

	minY := self defaultMaxValue.
	maxY := self defaultMinValue.
	minX := self defaultMaxValue.
	maxX := self defaultMinValue.

]

{ #category : #accessing }
RTAbstractDataSet >> shouldConnect [
	^ shouldConnect
]

{ #category : #accessing }
RTAbstractDataSet >> x: blockOrSymbol [
	x := blockOrSymbol
]

{ #category : #accessing }
RTAbstractDataSet >> y: blockOrSymbol [
	y := blockOrSymbol
]
