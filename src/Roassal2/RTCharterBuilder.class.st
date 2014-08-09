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

{ #category : #public }
RTCharterBuilder >> adjustMinAndMaxValues [
	minY > 0
		ifTrue: [ minY := 0 ].
	maxY < 0
		ifTrue: [ maxY := 0 ].
		
	minX > 0
		ifTrue: [ minX := 0 ].
	maxX < 0
		ifTrue: [ maxX := 0 ].
]

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
	"THIS METHOD PROBABLY DOES NOT WORK."
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
	"We compute the min and the max, useful for labelling"
	vs := self allPoints collect: [ :e | metricAsBlockOrSymbol rtValue: e model ].
	minY := minY min: vs min.
	maxY := maxY max: vs max.

	self adjustMinAndMaxValues.
	
	"We normalize the things"
	RTMetricNormalizer new
		elements: self allPoints;
		normalizeY: [ :model | (metricAsBlockOrSymbol rtValue: model) ] min: 0 max: extent y negated minValue: minY maxValue: maxY.

]

{ #category : #'public axis' }
RTCharterBuilder >> axisFrom: fromPosition to: toPosition configuration: config [
	"config is an instance of RTAxisConfiguration"

	| tickShape ticks labelShape labelValues labels nbOfTicks nbOfLabels tickIntervalForLabel labelledTicks minValue maxValue centralPoint |
	"We add the ticks"
	nbOfTicks := config numberOfTicks.
	nbOfLabels := config numberOfLabels.
	minValue := config minValue.
	maxValue := config maxValue.
	self rawAxisFrom: fromPosition to: toPosition.
	tickShape := RTBox new height: 10; width: 5.
	ticks := tickShape elementsOn: (0 to: nbOfTicks).
	ticks rotateByDegrees: (toPosition - fromPosition) angle radiansToDegrees abs.
	view addAll: ticks.
	
	centralPoint := self centralPoint.
	RTMetricNormalizer new
		elements: ticks;
		normalizePosition: [ :v | v @ v ] min: fromPosition max: toPosition.	

	"We add the labels"
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

{ #category : #utility }
RTCharterBuilder >> axisPointFor: aPoint [
	"Return the position in the view to have the 0 @ 0"
	| centralPointX centralPointY |
	centralPointX := aPoint x + ((extent x - aPoint x) * ((aPoint x - minX) / (maxX - minX))) asInteger.
	centralPointY := aPoint y + ((extent y - aPoint y) * ((aPoint y - minY) / (maxY - minY))) asInteger.
	^ centralPointX @ centralPointY negated.

]

{ #category : #'public axis' }
RTCharterBuilder >> axisX [
	| centralPoint |
	centralPoint := self centralPoint.
	self rawAxisFrom: 0 @ centralPoint y to: extent x @ centralPoint y 
]

{ #category : #'public axis' }
RTCharterBuilder >> axisXWithNumberOfTicks: nbOfTicks [
	| config centralPoint |
	config := RTAxisConfiguration new
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((minX > 0) ifTrue: [ 0 ] ifFalse: [ minX ]);
					maxValue: maxX;					
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ].
	centralPoint := self centralPoint.
	self axisFrom: 0 @ centralPoint y to: extent x @ centralPoint y configuration: config.
	
]

{ #category : #'public axis' }
RTCharterBuilder >> axisY [
	| centralPoint |
	centralPoint := self centralPoint.
	self rawAxisFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
	
]

{ #category : #'public axis' }
RTCharterBuilder >> axisYWithNumberOfTicks: nbOfTicks [
	| config centralPoint |
	config := RTAxisConfiguration new
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((minY > 0) ifTrue: [ 0 ] ifFalse: [ minY ]);
					maxValue: maxY;
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (40 @ 0) ].
	centralPoint := self centralPoint.
	self axisFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated configuration: config.
	
]

{ #category : #utility }
RTCharterBuilder >> bottomPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self axisPointFor: 0 @ minY
]

{ #category : #utility }
RTCharterBuilder >> centralPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self axisPointFor: 0 @ 0
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

	"This is highly inefficent."
	RTMetricNormalizer new
		elements: lastAddedElements;
		normalizeElementX: [ :element | lastAddedElements indexOf: element ] min: 0 max: extent x minValue: 1 maxValue: lastAddedElements size.
	minX := 0.
	maxX := lastAddedElements size - 1.
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

{ #category : #'public highlight' }
RTCharterBuilder >> highlightIf: aConditionalBlock using: aBlock [

	self allPoints do: [ :element |
		(aConditionalBlock rtValue: element model) ifTrue: [ 
			element @ (RTLabelled new text: [ :model | aBlock rtValue: model ]; setAsHighlightable).
		]
	]
]

{ #category : #'public highlight' }
RTCharterBuilder >> highlightIf: aConditionalBlock using: aBlock lowColor: lowColor color: highColor [

	self allPoints do: [ :element |
		(aConditionalBlock rtValue: element model) ifTrue: [ 
			element @ (RTLabelled new 
							lowColor: lowColor;
							text: [ :model | aBlock rtValue: model ]; setAsHighlightable).
		]
	]
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

{ #category : #utility }
RTCharterBuilder >> leftPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self axisPointFor: minX @ 0
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
RTCharterBuilder >> rawAxisFrom: aPositionFrom to: aPositionTo [
	| edge ex2 ex1 |
	"centralPoint := extent x / 2 @ extent y negated / 2."
"	centralPointX := minX + ((maxX - minX) * ( (t - minValue) / (extent x - minValue))) asInteger.
"			
	ex1 := (RTBox new size: 0) element.
	ex2 := (RTBox new size: 0) element.
	ex2 translateTo: (aPositionTo).
	ex1 translateTo: (aPositionFrom).
	edge := RTLine edgeFrom: ex1 to: ex2.
	view add: ex1; add: ex2.
	view add: edge
]

{ #category : #utility }
RTCharterBuilder >> rawAxisTo: aPosition [
	| edge ex2 ex1 centralPointX centralPointY centralPoint |
	"centralPoint := extent x / 2 @ extent y negated / 2."
"	centralPointX := minX + ((maxX - minX) * ( (t - minValue) / (extent x - minValue))) asInteger.
"		
	centralPointX := 0 + ((extent x - 0) * ( (0 - minX) / (maxX - minX))) asInteger.
	centralPointY := 0 + ((extent y - 0) * ( (0 - minY) / (maxY - minY))) asInteger.
	centralPoint := centralPointX @ centralPointY negated.
	
	ex1 := (RTBox new size: 0) element.
	ex2 := (RTBox new size: 0) element.
	ex2 translateTo: (centralPoint + aPosition).
	ex1 translateTo: (centralPoint).
	edge := RTLine edgeFrom: ex1 to: ex2.
	view add: ex1; add: ex2.
	view add: edge
]

{ #category : #utility }
RTCharterBuilder >> rightPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self axisPointFor: maxX @ 0
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
			normalizeElementX: [ :o | (points indexOf: o) - 1 ] min: 0 max: extent x minValue: -1 maxValue: maxX - 1
	].
]

{ #category : #utility }
RTCharterBuilder >> topPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self axisPointFor: 0 @ maxY
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
	maxY := aMax.	"Ensure that 0 is between [ minY ; maxY ]"
	self adjustMinAndMaxValues.
	RTMetricNormalizer new
		elements: lastAddedElements;
		normalizeY: [ :model | metricAsBlockOrSymbol rtValue: model ]
			min: 0
			max: extent y negated
			minValue: minY
			maxValue: maxY
]
