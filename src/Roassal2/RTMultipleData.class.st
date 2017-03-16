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
	#superclass : #RTAbstractMultipleData,
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #adding }
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
	self addAll: elements
]

{ #category : #rendering }
RTMultipleData >> colorPalette [
	^ super  colorPalette
]

{ #category : #hooks }
RTMultipleData >> getModelForElement:e atIndex: index [
	"Return the model that is used to insert a label for the element. index is index-th label to be provided."
	^ self points at: index
]

{ #category : #rendering }
RTMultipleData >> initialize [
	^ super initialize
]

{ #category : #rendering }
RTMultipleData >> numberOfMetrics [
	^ super numberOfMetrics
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

{ #category : #rendering }
RTMultipleData >> points: vv [
	^ super points: vv
]

{ #category : #rendering }
RTMultipleData >> renderIn: blah [
	^ super renderIn: blah
	
]

{ #category : #hooks }
RTMultipleData >> resetShapeBuilderForBar [
	super resetShapeBuilderForBar.
	
	"Default width that compute an appropriate width"
	barBuilder width: [ :object | 
		(builder extent x / (self numberOfPoints * self numberOfMetrics * 2)) asFloat ]
]

{ #category : #rendering }
RTMultipleData >> selectElementsForAddingBarTitle [
	^ super 
selectElementsForAddingBarTitle
]
