"
A data set for which each element has to be plotted using two functions, one against the X-axis and another against the Y-axis), is modelled using the class RTData. 

-=-=-=
""Since no x: and y: have been specified, it simply lines up all the values""
b := RTGrapher new.
ds := RTData new. 
ds dotShape color: Color red. 
ds points: #(5 1 20 8).
b add: ds.
b.
-=-=-=

-=-=-=
b := RTGrapher new.
ds := RTData new. 
ds dotShape color: Color red. 
ds points: #(5 1 20 8).
ds y: [ :x | x * x ].
b add: ds.
b.
-=-=-=

-=-=-=
b := RTGrapher new.
ds := RTData new. 
ds dotShape color: Color red. 
ds points: (1 to: 100).
ds y: [ :x | x * x ].
b add: ds.
b.
-=-=-=

-=-=-=
""Use objects instead of numerical values""
b := RTGrapher new.
ds := RTData new. 
ds dotShape color: (Color red alpha: 0.3). 
ds points: Collection withAllSubclasses.
ds y: #numberOfLinesOfCode.
ds x: #numberOfMethods.
b add: ds.
b.
-=-=-=
"
Class {
	#name : #RTData,
	#superclass : #RTObject,
	#instVars : [
		'points',
		'elements',
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
		'shouldConnect',
		'interaction',
		'elementActions',
		'shouldHaveHistogramBars'
	],
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #hooks }
RTData >> addedInBuilder: aBuilder [
	self builder: aBuilder.
	aBuilder shouldUseNiceLabelsForX: false
]

{ #category : #utility }
RTData >> adjustMinAndMaxValues [
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

{ #category : #public }
RTData >> barChartWithBarCenteredTitle: aBlockOrSymbol [
	"Add bar charts with centered title, the default color is used. This is a public method"
	^ self barChartWithBarCenteredTitle: aBlockOrSymbol color: self defaultLabelColor
]

{ #category : #public }
RTData >> barChartWithBarCenteredTitle: aBlockOrSymbol color: aColor [
	"Draw a bar chart with title"
	self barShape.
	elementActions add: [ :elements | 
		| lbl |
		elements do: [ :e |
			lbl := (RTLabel new text: aBlockOrSymbol; color: aColor) elementOn: e model.
			TRConstraint move: lbl below: e.
			"lbl translateBy: (lbl width / -2 @ 0) + (5 @ 0)."
			elements anyOne view add: lbl.
		] ].
	 
]

{ #category : #public }
RTData >> barChartWithBarTitle: aBlockOrSymbol [
	"Draw a barChart with title"
	self barChartWithBarTitle: aBlockOrSymbol rotation: -45
]

{ #category : #public }
RTData >> barChartWithBarTitle: aBlockOrSymbol rotation: rotationInDegree [
	"Draw an histogram with title"

	self barChartWithBarTitle: aBlockOrSymbol rotation: rotationInDegree color: self defaultLabelColor
]

{ #category : #public }
RTData >> barChartWithBarTitle: aBlockOrSymbol rotation: rotationInDegree color: aColor [
	"Draw an histogram with title"
	self barShape.
	elementActions add: [ :elements | 
		| lbl |
		elements do: [ :e |
			lbl := (RTLabel new text: aBlockOrSymbol; color: aColor) elementOn: e model.
			lbl rotateByDegrees: rotationInDegree.
			TRConstraint move: lbl below: e.
			lbl translateBy: (lbl width / -2 @ 0) + (5 @ 0).
			elements anyOne view add: lbl.
		] ].
	 
]

{ #category : #'public - bar shape' }
RTData >> barShape [
	shouldHaveHistogramBars := true.
	^ histogramBuilder
]

{ #category : #accessing }
RTData >> builder: aBuilder [
	builder := aBuilder 
]

{ #category : #hooks }
RTData >> centralDot [
	^ (RTEllipse new
		size: 0;
		color: Color red) element translateTo: (builder getPixelPositionOf: 0 @ 0)
]

{ #category : #'min and max' }
RTData >> computeMinAndMax [
	self computeMinAndMaxForX.
	self computeMinAndMaxForY.
]

{ #category : #'min and max' }
RTData >> computeMinAndMaxForX [
	| computed |
	computed := elements collect: x.
	self assert: [ computed allSatisfy: [ :obj | obj isKindOf: Number ] ] description: 'You have provided objects that are not number. Please adjust what you provide to #points: #x: and #y:'.
	minX := computed min.
	maxX := computed max.

	(minX < 0 and: [ maxX < 0 ]) ifTrue: [ maxX := 0 ].
	(minX > 0 and: [ maxX > 0 ]) ifTrue: [ minX := 0 ].
	


]

{ #category : #'min and max' }
RTData >> computeMinAndMaxForY [
	| computed |
	computed := elements collect: y.
	self assert: [ computed allSatisfy: [ :obj | obj isKindOf: Number ] ] description: 'You have provided objects that are not number. Please adjust what you provide to #points: #x: and #y:'.
	minY := computed min.
	maxY := computed max.
	
	(minY < 0 and: [ maxY < 0 ]) ifTrue: [ maxY := 0 ].
	(minY > 0 and: [ maxY > 0 ]) ifTrue: [ minY := 0 ].
	
]

{ #category : #'public - lines' }
RTData >> connect [
	shouldConnect := true
]

{ #category : #'public - lines' }
RTData >> connectColor: aColor [
	"Draw a line between each point, of a given color"
	^ self connectUsing: (RTLine new color: aColor)
]

{ #category : #'public - lines' }
RTData >> connectUsing: aShape [
	"Connect all the point, using a particular shape"
	lineBuilder shape: aShape.
	self connect
]

{ #category : #initialization }
RTData >> defaultLabelColor [
	"Label should be gray per default"
	^ Color gray
]

{ #category : #initialization }
RTData >> defaultMaxValue [
	^ 1000000
]

{ #category : #initialization }
RTData >> defaultMinValue [
	^ -1000000
]

{ #category : #'public - dots' }
RTData >> dotShape [
	^ dotBuilder
]

{ #category : #'public - effects' }
RTData >> dotSize: metricAsBlockOrSymbol min: minValue max: maxValue using: transformation [
	"Set the size of the dots for each element"
	elementActions add: [ :elements |
		RTMetricNormalizer new
			elements: elements;
			normalizeSize: metricAsBlockOrSymbol min: minValue max: maxValue using: transformation ]
]

{ #category : #hooks }
RTData >> getPixelPositionOf: aPoint [
	"Return the position in the Roassal view of a point"

	| anX anY |
	anX := RTMetricNormalizer new
		getValue: aPoint x min: 0 max: builder extent x minValue: minX maxValue: maxX.
	anY := RTMetricNormalizer new
		getValue: aPoint y min: 0 max: builder extent y negated minValue: minY maxValue: maxY.
			
	^ anX @ anY
]

{ #category : #hooks }
RTData >> getPositionFromPixelPosition: aPoint [
	"Return the position in the graph from a position in the Roassal view of a point"

	| anX anY |
	anX := RTMetricNormalizer new
		getValue: aPoint x min: minX max: maxX minValue: 0 maxValue: builder extent x.
	anY := RTMetricNormalizer new
		getValue: aPoint y min: minY max: maxY minValue: 0 maxValue: builder extent y.
			
	^ anX @ anY negated
]

{ #category : #accessing }
RTData >> getValuesX [
	^ elements collect: x
]

{ #category : #accessing }
RTData >> getValuesY [
	^ elements collect: y
]

{ #category : #'public - effects' }
RTData >> highlightIf: aOneArgBlock using: secondOneArgBlock [
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

{ #category : #obsolete }
RTData >> histogramWithBarTitle: aBlockOrSymbol rotation: rotationInDegree color: aColor [
	"Draw an histogram with title"
	self barShape.
	elementActions add: [ :elements | 
		| lbl |
		elements do: [ :e |
			lbl := (RTLabel new text: aBlockOrSymbol; color: aColor) elementOn: e model.
			lbl rotateByDegrees: rotationInDegree.
			TRConstraint move: lbl below: e.
			lbl translateBy: (lbl width / -2 @ 0) + (5 @ 0).
			elements anyOne view add: lbl.
		] ].
	 
]

{ #category : #initialization }
RTData >> initialize [
	"Maybe this can be lazily done"

	super initialize.
	elements := #().
	self stack.
	self y: #yourself.
	self resetMinAndMax.
	self resetShapeBuilderForDot.
	self resetShapeBuilderForBar.
	self resetShapeBuilderForLine.
	self resetInteractionBuilder.
	shouldConnect := false.
	elementActions := OrderedCollection new.
	shouldHaveHistogramBars := false
]

{ #category : #accessing }
RTData >> interaction [
	^ interaction
]

{ #category : #testing }
RTData >> isStacked [
	"Return true if the data is stacked"
	^ self getValuesX = (1 to: self numberOfPoints)
]

{ #category : #accessing }
RTData >> lineShape [
	^ lineBuilder
]

{ #category : #accessing }
RTData >> maxX [
	^ maxX
]

{ #category : #accessing }
RTData >> maxX: anObject [
	maxX := anObject
]

{ #category : #accessing }
RTData >> maxY [
	^ maxY
]

{ #category : #accessing }
RTData >> maxY: anObject [
	maxY := anObject
]

{ #category : #accessing }
RTData >> minX [
	^ minX
]

{ #category : #accessing }
RTData >> minX: anObject [
	minX := anObject
]

{ #category : #accessing }
RTData >> minY [
	^ minY
]

{ #category : #accessing }
RTData >> minY: anObject [
	minY := anObject
]

{ #category : #'public - dots' }
RTData >> noDot [
	"No dot are shown"
	self dotShape rectangle size: 0
]

{ #category : #accessing }
RTData >> numberOfPoints [
	"Return the number of points the dataset is representing"
	^ elements size
]

{ #category : #accessing }
RTData >> points [
	^ elements collect: #model
]

{ #category : #accessing }
RTData >> points: objects [
	elements := dotBuilder elementsOn: objects
]

{ #category : #hooks }
RTData >> renderBarChartIn: aView [
	| centralDot positiveElements negativeElements |
	centralDot := self centralDot.
	
	elements := histogramBuilder elementsOn: self points.
	builder view addAll: elements.
	interaction setUpElements: elements.
	RTMetricNormalizer new
		elements: elements;
		normalizeElementX: [ :anElement | x rtValue: anElement ]
			min: 0
			max: builder extent x
			minValue: minX
			maxValue: maxX + 1.
	"We have 'maxX + 1' because we do not want the last bar on the extremity of the X-Axis"

	"We treat the element with a positive value"
	positiveElements := elements select: [ :el | (y rtValue: el) >= 0 ].
	positiveElements
		ifNotEmpty: [
			RTMetricNormalizer new
				elements: positiveElements;
				normalizeElementHeight: [ :anElement | y rtValue: anElement ]
					min: 0
					max: builder extent y + centralDot position y
					minValue: 0
					maxValue: maxY ].
	TRConstraint use: centralDot alignFromBottom: positiveElements.	
		
	"We treat the element with a negative value"
	negativeElements := elements copyWithoutAll: positiveElements.
	negativeElements
		ifNotEmpty: [ 
			RTMetricNormalizer new
				elements: negativeElements;
				normalizeElementHeight: [ :anElement | y rtValue: anElement ]
					min: centralDot position y negated 
					max: 0
					minValue: minY
					maxValue: 0.
			TRConstraint use: centralDot alignFromTop: negativeElements ].	"We set the actions, if any"
	elementActions do: [ :act | act rtValue: elements ]
]

{ #category : #hooks }
RTData >> renderDotAndLinesIn: aView [

	builder view addAll: elements.
	interaction setUpElements: elements.
	
	RTMetricNormalizer new
		elements: elements;
		normalizeElementX: [ :anElement | x rtValue: anElement ]
			min: 0
			max: builder extent x
			minValue: minX
			maxValue: maxX.
			
	RTMetricNormalizer new
		elements: elements;
		normalizeElementY: [ :anElement | y rtValue: anElement ]
			min: 0
			max: builder extent y negated
			minValue: minY
			maxValue: maxY.
			
	elementActions do: [ :act | act rtValue: elements ].
			
	self renderLinesFor: elements in: aView
]

{ #category : #hooks }
RTData >> renderIn: aView [

	"This is a bit ugly. Maybe having a class hierarchy would be better"
	shouldHaveHistogramBars 
		ifTrue: [ self renderBarChartIn: aView ]
		ifFalse: [ self renderDotAndLinesIn: aView ]
	

]

{ #category : #utility }
RTData >> renderLinesFor: elements in: aView [
	"Render the lines between elements if necessary"
	| t l |
	shouldConnect ifFalse: [ ^ self ].

	t := elements first.
	elements allButFirst
		do: [ :tt | 
			l := lineBuilder edgeFrom: t to: tt.
			interaction setUpElement: l.
			aView add: l.
			t := tt ]
]

{ #category : #initialization }
RTData >> resetInteractionBuilder [
	interaction := RTInteractionBuilder new.
	interaction popup
]

{ #category : #utility }
RTData >> resetMinAndMax [

	minY := self defaultMaxValue.
	maxY := self defaultMinValue.
	minX := self defaultMaxValue.
	maxX := self defaultMinValue.

]

{ #category : #initialization }
RTData >> resetShapeBuilderForBar [
	histogramBuilder := RTShapeBuilder new.
	histogramBuilder rectangle
]

{ #category : #initialization }
RTData >> resetShapeBuilderForDot [
	dotBuilder := RTShapeBuilder new.
	dotBuilder circle size: 5
]

{ #category : #initialization }
RTData >> resetShapeBuilderForLine [
	lineBuilder := RTShapeBuilder new
]

{ #category : #accessing }
RTData >> shouldConnect [
	^ shouldConnect
]

{ #category : #'public - configuration' }
RTData >> stack [
	"Make all the elements from left to right"
	self xElement: [ :anElement | elements indexOf: anElement ] 
]

{ #category : #accessing }
RTData >> x: blockOrSymbol [
	self xElement: [ :anElement | blockOrSymbol rtValue: anElement model ]
]

{ #category : #accessing }
RTData >> xElement: blockOrSymbol [
	x := blockOrSymbol
]

{ #category : #accessing }
RTData >> y: blockOrSymbol [
	self yElement: [ :anElement | blockOrSymbol rtValue: anElement model ]
]

{ #category : #accessing }
RTData >> yElement: blockOrSymbol [
	y := blockOrSymbol
]
