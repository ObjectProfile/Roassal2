"
RTMultipleData handles multiple metrics per data points. It is rendered using bar chart.

[[[ 
b := RTGrapher new.

d := RTMultipleData new.
d barShape color: Color blue.
d points: #( #('hello' 1 2 1) #('world' 2 4 2) #('bonjour' 3 5 4) #('Gutten Morgen' -1 4 -5)).
d addMetric: #second.
d addMetric: #third.
d addMetric: #fourth.

""d barChartWithBarCenteredTitle: #first.""
d barChartWithBarTitle: #first rotation: -30.

b add: d.

b
 ]]]
"
Class {
	#name : #RTMultipleData,
	#superclass : #RTAbstractData,
	#instVars : [
		'points',
		'interaction',
		'metrics',
		'groupedElements'
	],
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #'public - metrics' }
RTMultipleData >> addMetric: aBlockOrSymbolOrValue [
	metrics add: aBlockOrSymbolOrValue
]

{ #category : #adding }
RTMultipleData >> addedInBuilder: aBuilder [
	super addedInBuilder: aBuilder.
	aBuilder axisX noLabel; noTick.
	
	elements := RTGroup new.
	points do: [ :p | 
		| values es |
		values := metrics collect: [ :m | m rtValue: p ].
		es := barBuilder elementsOn: values.
		es doWithIndex: [ :e :index | e trachelShape color: (self colorPalette at: index) ].
		groupedElements add: es.
		elements addAll: es
		 ] separatedBy: [ elements add: ((RTBox new size: 0) elementOn: 0) ].
	builder view addAll: elements
]

{ #category : #accessing }
RTMultipleData >> colorPalette [
	^ ColorPalette qualitative colors: 8 scheme: 'Set2'
]

{ #category : #'as yet unclassified' }
RTMultipleData >> getModelForElement:e atIndex: index [
	"Return the model that is used to insert a label for the element. index is index-th label to be provided."
	^ self points at: index
]

{ #category : #initialization }
RTMultipleData >> initialize [
	super initialize.
	points := #().
	metrics := OrderedCollection new.
	groupedElements := OrderedCollection new.
	x := [ :anElement | elements indexOf: anElement ].
	y := [ :anElement | anElement model ].
	self resetMinAndMax.
	self resetShapeBuilderForBar.

]

{ #category : #'public - query' }
RTMultipleData >> numberOfMetrics [
	"Return the number of metrics added to the data set"
	^ metrics size
]

{ #category : #'public - query' }
RTMultipleData >> numberOfPoints [
	"Return the number of points added in the data set"
	^ points size
]

{ #category : #accessing }
RTMultipleData >> points [
	^ points
]

{ #category : #accessing }
RTMultipleData >> points: objects [
	points := objects
]

{ #category : #hooks }
RTMultipleData >> renderIn: aView [

	"We need to do the layout here"

| centralDot positiveElements negativeElements  |
	centralDot := self centralDot.
	
"	elements := barBuilder elementsOn: self points.
	builder view addAll: elements.
"	"interaction setUpElements: elements."
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

	RTAlignment new elements: positiveElements; fixedElement: centralDot; bottom.
	"TRConstraint use: centralDot alignFromBottom: positiveElements.	"
		
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
			RTAlignment new elements: negativeElements; fixedElement: centralDot; top.
			"TRConstraint use: centralDot alignFromTop: negativeElements "].	"We set the actions, if any"
	elementActions do: [ :act | act rtValue: elements ]
]

{ #category : #initialization }
RTMultipleData >> resetShapeBuilderForBar [
	super resetShapeBuilderForBar.

]

{ #category : #hooks }
RTMultipleData >> selectElementsForAddingBarTitle [
	^ groupedElements collect: [ :es | es at: (es size / 2) asInteger + 1 ]
]
