"
The histogram gives you a distribution frequency over the points given. Frequency on y and a collection of values per bars on x.  
"
Class {
	#name : #RTHistogramSet,
	#superclass : #RTAbstractStackedDataSet,
	#instVars : [
		'metric',
		'nbOfIntervals'
	],
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #hooks }
RTHistogramSet >> addedInBuilder: aBuilder [
	"Really ugly method. This will be fixed soon!"
	super addedInBuilder: aBuilder.

	self points: ((RTDistribution on: points) annotatedFrequencyWithAmountOfIntervals: (self nbOfIntervals rtValue: points)).	
	self y: #first.
	
	builder axisX noTick; noLabel.

	
]

{ #category : #public }
RTHistogramSet >> barShape [
	^ histogramBuilder
]

{ #category : #initialization }
RTHistogramSet >> defaultNbOfIntervals [ 
	self nbOfIntervals: [ :vls | (vls size) log * 3.3 + 1 ].
]

{ #category : #initialization }
RTHistogramSet >> initialize [
	super initialize.
	self metric: #yourself.
	self defaultNbOfIntervals 
]

{ #category : #accessing }
RTHistogramSet >> metric: aMetricAsBlockOrSymbol [

	metric := aMetricAsBlockOrSymbol.
]

{ #category : #hooks }
RTHistogramSet >> nbOfIntervals [
	^ nbOfIntervals
]

{ #category : #hooks }
RTHistogramSet >> nbOfIntervals: aNumberOfBlock [
	nbOfIntervals := aNumberOfBlock 
	 
]

{ #category : #hooks }
RTHistogramSet >> renderIn: aView [
	self adjustMinAndMaxValues.
	self renderBarChartIn: aView
]
