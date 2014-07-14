Class {
	#name : #RTCharterBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'extent',
		'lastAddedElements',
		'minY',
		'maxY',
		'minX',
		'maxX',
		'allPointElements'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #accessing }
RTCharterBuilder >> allPointElements [
	^ allPointElements
]

{ #category : #'public axis' }
RTCharterBuilder >> axisTo: aPosition configuration: config [
	"config is an instance of RTAxisConfiguration"
	| ex1 ex2 edge tickShape ticks labelShape labelValues labels nbOfTicks nbOfLabels tickIntervalForLabel labelledTicks minValue maxValue |
	nbOfTicks := config numberOfTicks.
	nbOfLabels := config numberOfLabels.
	tickIntervalForLabel := config tickIntervalForLabel.
	minValue := config minValue.
	maxValue := config maxValue.
	
	ex1 := RTBox element.
	ex2 := RTBox element.
	ex2 translateTo: aPosition.
	edge := RTLine edgeFrom: ex1 to: ex2.
	view add: edge.
	
	
	"We add the ticks"
	tickShape := RTBox new height: 10; width: 5.
	ticks := tickShape elementsOn: (0 to: nbOfTicks).
	ticks rotateByDegrees: aPosition angle radiansToDegrees abs.
	view addAll: ticks.
	RTMetricNormalizer new
		elements: ticks;
		normalizePosition: [ :v | v @ v ] min: 0 @ 0 max: aPosition.
		
	"We add the labels"
	nbOfLabels = 0 ifTrue: [ ^ self ].
	
	minX > 0 ifTrue: [ minX := 0 ].
	labelledTicks := (1 to: ticks size by: tickIntervalForLabel) collect: [ :i | ticks at: i ].
	
	labelValues := (0 to: nbOfLabels) collect: [ :i | minValue + (i * (maxValue - minValue) / nbOfLabels) ].
	labelShape := RTLabel new text: [ :i | self getStringFromNumber: (labelValues at: i + 1) ].
	labels := labelShape elementsOn: (0 to: nbOfLabels).
	labels withIndexDo: [ :label :i | config moveLabel: label againstTick: (labelledTicks at: i) ].
	view addAll: labels.
	
]

{ #category : #'public axis' }
RTCharterBuilder >> axisXWithNumberOfTicks: nbOfTicks [
	| config |
	config := RTAxisConfiguration new
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((minX > 0) ifTrue: [ 0 ] ifFalse: [ minX ]);
					maxValue: maxX;					
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ].
	self axisTo: extent x @ 0 configuration: config.
	
]

{ #category : #'public axis' }
RTCharterBuilder >> axisYWithNumberOfTicks: nbOfTicks [
	| config |
	config := RTAxisConfiguration new
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((minY > 0) ifTrue: [ 0 ] ifFalse: [ minY ]);
					maxValue: maxY;
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (40 @ 0) ].
	self axisTo: 0 @ extent y negated configuration: config.
	
]

{ #category : #hooks }
RTCharterBuilder >> createView [

	^ super createView @ RTDraggableView
]

{ #category : #public }
RTCharterBuilder >> curve [
	"connect the points in the order they have been added"
	^ self curveUsing: RTLine new
]

{ #category : #public }
RTCharterBuilder >> curveUsing: aLineShape [
	"connect the points in the order they have been added"

	| models t |
	"This is highly inefficent."
	models := lastAddedElements collect: #model.
	RTMetricNormalizer new
		elements: lastAddedElements;
		normalizeX: [ :m | models indexOf: m ] min: 0 max: extent x.
		
	minX := 0. 
	maxX := models size - 1.
	
	t := lastAddedElements first.
	lastAddedElements allButFirst do: [ :tt |
		view add: (aLineShape edgeFrom: t to: tt).
		t := tt ]
]

{ #category : #initialization }
RTCharterBuilder >> defaultMaxValue [
	^ 1000000
]

{ #category : #initialization }
RTCharterBuilder >> defaultMinValue [
	^ -1000000
]

{ #category : #examples }
RTCharterBuilder >> exampleHistogram [
	"
	self new exampleLineCurve
	"
	| b |
	b := RTCharterBuilder new.
	b y: #numberOfMethods width: 100.
	b size: #numberOfVariable min: 5 max: 15.
	b points: (RTObject withAllSubclasses sortedAs: #numberOfMethods).
	b histogram.
	b open
]

{ #category : #examples }
RTCharterBuilder >> exampleLineCurve [
	"
	self new exampleLineCurve
	"
	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 300.
	b shape ellipse fillColor: (Color blue alpha: 0.3).
	b points: (RTObject withAllSubclasses sortedAs: #numberOfMethods).
	b y: #numberOfMethods.

	b curve.
	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
	b open
]

{ #category : #examples }
RTCharterBuilder >> exampleLineCurve2 [
	"
	self new exampleLineCurve2
	"
	| b |
	b := RTCharterBuilder new.
	b extent: 400 @ 300.

	b shape ellipse fillColor: (Color green alpha: 0.3).
	b points: (RTObject withAllSubclasses sortedAs: #numberOfMethods).
	b y: #numberOfLinesOfCode.
	b curve.

	
	b shape ellipse fillColor: (Color blue alpha: 0.3).
	b points: (RTObject withAllSubclasses sortedAs: #numberOfMethods).
	b y: #numberOfMethods.
	b curve.
		
	
	b axisXWithNumberOfTicks: 4.
	b axisYWithNumberOfTicks: 4.
	b open
]

{ #category : #examples }
RTCharterBuilder >> exampleSimpleScatterPlot [
	"
	self new exampleSimpleScatterPlot
	"
	| b |
	b := RTCharterBuilder new.
	b shape ellipse color: (Color blue alpha: 0.3).
	b interaction popup.
	b points: RTObject withAllSubclasses.
	b x: #numberOfLinesOfCode.
	b y: #numberOfMethods.
	b size: #numberOfVariables min: 5 max: 15.

	b open
]

{ #category : #examples }
RTCharterBuilder >> exampleSimpleScatterPlotWithAxis [
	"
	self new exampleSimpleScatterPlotWithAxis
	"
	| b |
	b := RTCharterBuilder new.
	b extent: 300 @ 300.
	b shape ellipse color: (Color blue alpha: 0.3).
	b interaction popup.
	b points: RTObject withAllSubclasses.
	b x: #numberOfLinesOfCode.
	b y: #numberOfMethods.
	b size: #numberOfVariables min: 10 max: 25.

	b axisXWithNumberOfTicks: 4; axisYWithNumberOfTicks: 4.
	b open
]

{ #category : #examples }
RTCharterBuilder >> exampleSimpleScatterPlotWithRandomValues [
	"
	self new exampleSimpleScatterPlotWithRandomValues
	"
	| b |
	b := RTCharterBuilder new.
	b extent: 300 @ 300.
	b shape ellipse color: (Color blue alpha: 0.3).
	b interaction popup.
	b points: ((1 to: 50) collect: [:v | (v / 2) asInteger atRandom @ v atRandom ]).
	b x: #x.
	b y: #y.
	b axisXWithNumberOfTicks: 4; axisYWithNumberOfTicks: 4.
	b open
]

{ #category : #accessing }
RTCharterBuilder >> extent [
	^ extent
]

{ #category : #accessing }
RTCharterBuilder >> extent: aValue [
	extent := aValue
]

{ #category : #utility }
RTCharterBuilder >> getStringFromNumber: aNumber [
	^ (aNumber asFloat round: 2) asString
]

{ #category : #initialization }
RTCharterBuilder >> initialize [
	super initialize.
	extent := 100 @ 100.
	minY := self defaultMaxValue.
	maxY := self defaultMinValue.
	minX := self defaultMaxValue.
	maxX := self defaultMinValue.
	allPointElements := OrderedCollection new
]

{ #category : #public }
RTCharterBuilder >> points: objects [
	"the argument is a collection of objects. Any objects may be provided here"
	lastAddedElements := self elementsOn: objects.
	view addAll: lastAddedElements.
	self setUpInteractionFor: lastAddedElements.
	allPointElements addAll: lastAddedElements.
]

{ #category : #public }
RTCharterBuilder >> size: metricAsBlockOrSymbol min: minValue max: maxValue [

	RTMetricNormalizer new
		elements: lastAddedElements;
		normalizeSize: metricAsBlockOrSymbol min: minValue max: maxValue
]

{ #category : #public }
RTCharterBuilder >> x: metricAsBlockOrSymbol [

	| vs |
	RTMetricNormalizer new
		elements: lastAddedElements;
		normalizeX: metricAsBlockOrSymbol min: 0 max: extent x.
		
	vs := lastAddedElements collect: [ :e | metricAsBlockOrSymbol rtValue: e model ].
	minX := minX min: vs min. 
	maxX := maxX max: vs max.
]

{ #category : #public }
RTCharterBuilder >> y: metricAsBlockOrSymbol [

	| vs |
	vs := lastAddedElements collect: [ :e | metricAsBlockOrSymbol rtValue: e model ].
	minY := minY min: vs min.
	maxY := maxY max: vs max.

	RTMetricNormalizer new
		elements: allPointElements;
		normalizeY: [ :model | (metricAsBlockOrSymbol rtValue: model) / maxY ] min: 0 max: extent y negated.
	
	"@@ we need to readjust the elements that have been present before we add lastAddedElements"
]
