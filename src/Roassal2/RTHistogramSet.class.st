"
This class is under construction. It does not work yet!
"
Class {
	#name : #RTHistogramSet,
	#superclass : #RTAbstractStackedDataSet,
	#instVars : [
		'metric'
	],
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #hooks }
RTHistogramSet >> addedInBuilder: aBuilder [
	"Really ugly method. This will be fixed soon!"
	super addedInBuilder: aBuilder.

	self points: ((RTDistribution on: (points collect: y)) annotatedFrequency).
	self y: #first.
	
	builder addDecorator: (RTVerticalValuesDecorator new addAll: (0 to: (points collect: #first) max)).
	builder axisY noTick; noLabel.
	builder axisX noLabel; noTick
]

{ #category : #public }
RTHistogramSet >> barShape [
	^ histogramBuilder
]

{ #category : #initialization }
RTHistogramSet >> initialize [
	super initialize.
	self metric: #yourself
]

{ #category : #accessing }
RTHistogramSet >> metric: aMetricAsBlockOrSymbol [

	metric := aMetricAsBlockOrSymbol.
]

{ #category : #hooks }
RTHistogramSet >> renderIn: aView [
	self adjustMinAndMaxValues.
	self renderBarChartIn: aView
]
