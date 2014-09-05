"
A RTCharterBuilder is a builder to chart data points.

Instance Variables
	allPointElements:		<Object>
	axisConfiguration:		<Object>
	extent:		<Object>
	lastAddedElements:		<Object>
	maxX:		<Object>
	maxY:		<Object>
	minX:		<Object>
	minY:		<Object>

allPointElements
	- xxxxx

axisConfiguration
	- xxxxx

extent
	- xxxxx

lastAddedElements
	- xxxxx

maxX
	- xxxxx

maxY
	- xxxxx

minX
	- xxxxx

minY
	- xxxxx

"
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
		'allPointElements',
		'axisConfiguration'
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
RTCharterBuilder >> axisConfiguration [
	"Return an instance of RTAxisConfiguration. This method is useful to let a script to particularize the axis"
	^ axisConfiguration
]

{ #category : #utility }
RTCharterBuilder >> axisLineFrom: aPositionFrom to: aPositionTo [
	| edge ex2 ex1 |		
	ex1 := (RTBox new size: 0) element.
	ex2 := (RTBox new size: 0) element.
	ex2 translateTo: (aPositionTo).
	ex1 translateTo: (aPositionFrom).
	edge := RTLine edgeFrom: ex1 to: ex2.
	view add: ex1; add: ex2.
	view add: edge
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
	axisConfiguration 
		positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ];
		minValue: ((minX > 0) ifTrue: [ 0 ] ifFalse: [ minX ]);
		maxValue: maxX.	
	axisConfiguration axisFrom: 0 @ centralPoint y to: extent x @ centralPoint y
]

{ #category : #'public axis' }
RTCharterBuilder >> axisXTitled: aTitle [
	axisConfiguration title: aTitle.
	self axisX
]

{ #category : #'public axis' }
RTCharterBuilder >> axisXWithNumberOfTicks: nbOfTicks [
	| config centralPoint |
	config := RTAxisConfiguration new
					builder: self;
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((minX > 0) ifTrue: [ 0 ] ifFalse: [ minX ]);
					maxValue: maxX;					
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ].
	centralPoint := self centralPoint.
	config axisFrom: 0 @ centralPoint y to: extent x @ centralPoint y
]

{ #category : #'public axis' }
RTCharterBuilder >> axisY [
	| centralPoint |
	centralPoint := self centralPoint.
	axisConfiguration 
		positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (40 @ 0) ];
		minValue: ((minY > 0) ifTrue: [ 0 ] ifFalse: [ minY ]);
		maxValue: maxY.	

	axisConfiguration axisFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
]

{ #category : #'public axis' }
RTCharterBuilder >> axisYTitled: aTitle [
	axisConfiguration title: aTitle.
	self axisY
]

{ #category : #'public axis' }
RTCharterBuilder >> axisYWithNumberOfTicks: nbOfTicks [
	| config centralPoint |
	config := RTAxisConfiguration new
					builder: self;
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((minY > 0) ifTrue: [ 0 ] ifFalse: [ minY ]);
					maxValue: maxY;
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (40 @ 0) ].
	centralPoint := self centralPoint.
	config axisFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
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

{ #category : #accessing }
RTCharterBuilder >> extent [
	^ extent
]

{ #category : #accessing }
RTCharterBuilder >> extent: aValue [
	extent := aValue
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
	"barWidth := (extent x - ((lastAddedElements size + 2) * 10)/ (lastAddedElements size + 2)) - 10."
	barWidth := (extent x / lastAddedElements size) asInteger - (lastAddedElements size * 3).
	barWidth := barWidth max: 10.
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
		self setUpInteractionFor: bar.
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
	allPointElements := OrderedCollection new.
	
	self resetAxisConfiguration
]

{ #category : #utility }
RTCharterBuilder >> leftPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self axisPointFor: minX @ 0
]

{ #category : #'public axis' }
RTCharterBuilder >> newAxisConfiguration [
	"Return an instance of RTAxisConfiguration. This method is useful to let a script to particularize the axis"
	self resetAxisConfiguration.
	^ axisConfiguration
]

{ #category : #public }
RTCharterBuilder >> points: objects [
	"the argument is a collection of objects. Any objects may be provided here"
	lastAddedElements := self elementsOn: objects.
	view addAll: lastAddedElements.
	self setUpInteractionFor: lastAddedElements.
	allPointElements add: lastAddedElements.
]

{ #category : #'public axis' }
RTCharterBuilder >> resetAxisConfiguration [
	axisConfiguration := RTAxisConfiguration new.
	axisConfiguration builder: self
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
