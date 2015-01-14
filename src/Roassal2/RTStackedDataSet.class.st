Class {
	#name : #RTStackedDataSet,
	#superclass : #RTAbstractStackedDataSet,
	#instVars : [
		'shouldHaveHistogramBars'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #public }
RTStackedDataSet >> barShape [
	shouldHaveHistogramBars := true.
	^ histogramBuilder
]

{ #category : #initialization }
RTStackedDataSet >> initialize [
	"Subclasses should redefine this method to perform initializations on instance creation" 
	super initialize.
	shouldHaveHistogramBars := false.
]

{ #category : #hooks }
RTStackedDataSet >> renderDotAndLinesIn: aView [

	| elements |
	elements := dotBuilder elementsOn: points.
	builder view addAll: elements.
	interaction setUpElements: elements.
	
	RTMetricNormalizer new
		elements: elements;
		normalizeElementX: [ :element | (elements indexOf: element) + 1 ] 
			min: 0
			max: builder extent x 
			minValue: 1 
			maxValue: maxX + 2.
			
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
RTStackedDataSet >> renderIn: aView [

	"This is a bit ugly. Maybe having a class hierarchy would be better"
	self adjustMinAndMaxValues.
	shouldHaveHistogramBars 
		ifTrue: [ self renderBarChartIn: aView ]
		ifFalse: [ self renderDotAndLinesIn: aView ]
]
