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

{ #category : #public }
RTCharterBuilder >> allPoints [
	^ allPointElements flatCollect: #yourself
]

{ #category : #public }
RTCharterBuilder >> allX: metricAsBlockOrSymbol [
	| vs |
	RTMetricNormalizer new
		elements: self allPoints;
		normalizeX: metricAsBlockOrSymbol min: 0 max: extent x minValue: 0.

	"We compute the min and the max, useful for labelling"
	vs := self allPoints collect: [ :e | metricAsBlockOrSymbol rtValue: e model ].
	minX := minX min: vs min.
	maxX := maxX max: vs max.


]

{ #category : #public }
RTCharterBuilder >> allY: metricAsBlockOrSymbol [
	| vs |
	RTMetricNormalizer new
		elements: self allPoints;
		normalizeY: metricAsBlockOrSymbol min: 0 max: extent y negated minValue: 0.
		
	"We compute the min and the max, useful for labelling"
	vs := self allPoints collect: [ :e | metricAsBlockOrSymbol rtValue: e model ].
	minY := minY min: vs min.
	maxY := maxY max: vs max.


]

{ #category : #'public axis' }
RTCharterBuilder >> axisTo: aPosition configuration: config [
	"config is an instance of RTAxisConfiguration"

	| tickShape ticks labelShape labelValues labels nbOfTicks nbOfLabels tickIntervalForLabel labelledTicks minValue maxValue |
	"We add the ticks"
	nbOfTicks := config numberOfTicks.
	nbOfLabels := config numberOfLabels.
	minValue := config minValue.
	maxValue := config maxValue.
	self rawAxisTo: aPosition.
	tickShape := RTBox new
		height: 10;
		width: 5.
	ticks := tickShape elementsOn: (0 to: nbOfTicks).
	ticks rotateByDegrees: aPosition angle radiansToDegrees abs.
	view addAll: ticks.
	RTMetricNormalizer new
		elements: ticks;
		normalizePosition: [ :v | v @ v ] min: 0 @ 0 max: aPosition.	"We add the labels"
	nbOfLabels = 0
		ifTrue: [ ^ self ].
	tickIntervalForLabel := config tickIntervalForLabel.
	minX > 0
		ifTrue: [ minX := 0 ].
	labelledTicks := (1 to: ticks size by: tickIntervalForLabel) collect: [ :i | ticks at: i ].
	labelValues := (0 to: nbOfLabels) collect: [ :i | minValue + (i * (maxValue - minValue) / nbOfLabels) ].
	labelShape := RTLabel new text: [ :i | self getStringFromNumber: (labelValues at: i + 1) ].
	labels := labelShape elementsOn: (0 to: nbOfLabels).
	labels withIndexDo: [ :label :i | config moveLabel: label againstTick: (labelledTicks at: i) ].
	view addAll: labels.
	labels do: [ :e | e trachelShape pushBack ]
]

{ #category : #'public axis' }
RTCharterBuilder >> axisX [
	self rawAxisTo: extent x @ 0 
]

{ #category : #'public axis' }
RTCharterBuilder >> axisXNoLabelledWithNumberOfTicks: nbOfTicks [
	| config |
	config := RTAxisConfiguration new
					numberOfTicks: nbOfTicks;
					minValue: ((minX > 0) ifTrue: [ 0 ] ifFalse: [ minX ]);
					maxValue: maxX.
	self axisTo: extent x @ 0 configuration: config.
	
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
RTCharterBuilder >> axisY [
	self rawAxisTo: 0 @ extent y negated
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

{ #category : #public }
RTCharterBuilder >> connectDot [
	self connectDotColor: Color lightGray
]

{ #category : #public }
RTCharterBuilder >> connectDotColor: aColor [
	self connectDotUsing: (RTLine new color: aColor)
]

{ #category : #public }
RTCharterBuilder >> connectDotUsing: aLineShape [
	| t |
	t := lastAddedElements first.
	lastAddedElements allButFirst
		do: [ :tt | 
			view add: (aLineShape edgeFrom: t to: tt).
			t := tt ]
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
RTCharterBuilder >> curveColor: aColor [
	"connect the points in the order they have been added"

	^ self curveUsing: (RTLine new color: aColor)
]

{ #category : #public }
RTCharterBuilder >> curveUsing: aLineShape [
	"connect the points in the order they have been added"

	| models |
	"This is highly inefficent."
	models := lastAddedElements collect: #model.
	RTMetricNormalizer new
		elements: lastAddedElements;
		normalizeX: [ :m | models indexOf: m ] min: 0 max: extent x.
	minX := 0.
	maxX := models size - 1.
	self connectDotUsing: aLineShape
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
	self new exampleHistogram
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
RTCharterBuilder >> exampleSimpleHistogram [
	"
	self new exampleSimpleHistogram
	"
	| b |
	b := RTCharterBuilder new.
	b extent: 300 @ 100.
	b points: #(5 10 20 3 12).
	b y: #yourself min: 0 max: 50.
	b shape rectangle color: Color blue.
	b stackX.
	b histogram.
	
	b axisX.
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

{ #category : #public }
RTCharterBuilder >> histogram [
	"Draw an histogram"
	
	| barWidth |
	barWidth := (extent x - ((lastAddedElements size + 2) * 10)/ (lastAddedElements size + 2)) - 10.
	self histogramBarWidth: barWidth
]

{ #category : #public }
RTCharterBuilder >> histogramBarWidth: barWidth [
	"Draw an histogram"
	
	| bar |
	lastAddedElements do: [ :el |
		bar := (shapeBuilder current height: el position y abs; width: barWidth) elementOn: el model.
		bar translateTo: el position x @ (el position y / 2).
		bar announcer: el announcer.
		view add: bar ]  
]

{ #category : #initialization }
RTCharterBuilder >> initialize [
	super initialize.
	extent := 100 @ 100.
	minY := self defaultMaxValue.
	maxY := self defaultMinValue.
	minX := self defaultMaxValue.
	maxX := self defaultMinValue.
	
	"Collection of collection of elements"
	allPointElements := OrderedCollection new
]

{ #category : #public }
RTCharterBuilder >> points: objects [
	"the argument is a collection of objects. Any objects may be provided here"
	lastAddedElements := self elementsOn: objects.
	view addAll: lastAddedElements.
	self setUpInteractionFor: lastAddedElements.
	allPointElements add: lastAddedElements.
]

{ #category : #utility }
RTCharterBuilder >> rawAxisTo: aPosition [
	| edge ex2 ex1 |
	ex1 := RTBox element.
	ex2 := RTBox element.
	ex2 translateTo: aPosition.
	edge := RTLine edgeFrom: ex1 to: ex2.
	view add: edge
]

{ #category : #public }
RTCharterBuilder >> size: metricAsBlockOrSymbol min: minValue max: maxValue [

	self size: metricAsBlockOrSymbol min: minValue max: maxValue using: #yourself
]

{ #category : #public }
RTCharterBuilder >> size: metricAsBlockOrSymbol min: minValue max: maxValue using: transformation [

	RTMetricNormalizer new
		elements: lastAddedElements;
		normalizeSize: metricAsBlockOrSymbol min: minValue max: maxValue using: transformation
]

{ #category : #public }
RTCharterBuilder >> stackX [

	maxX := allPointElements inject: 0 into: [ :m :cs | m max: cs size ].
	allPointElements do: [ :points | 
		RTMetricNormalizer new
			elements: points;
			normalizeElementX: [ :o | (points indexOf: o) ] min: 0 max: extent x minValue: 0 maxValue: maxX
	].
]

{ #category : #public }
RTCharterBuilder >> x: metricAsBlockOrSymbol [

	| vs |
	RTMetricNormalizer new
		elements: lastAddedElements;
		normalizeX: metricAsBlockOrSymbol min: 0 max: extent x minValue: 0.
		
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

	self y: metricAsBlockOrSymbol min: minY max: maxY
]

{ #category : #public }
RTCharterBuilder >> y: metricAsBlockOrSymbol min: aMin max: aMax [

	minY := aMin.
	maxY := aMax.

	RTMetricNormalizer new
		elements: lastAddedElements;
		normalizeY: [ :model | (metricAsBlockOrSymbol rtValue: model) / maxY ] min: 0 max: extent y negated minValue: 0.

]
