Class {
	#name : #RTHistogramSet,
	#superclass : #RTAbstractStackedDataSet,
	#instVars : [
		'metric'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #'as yet unclassified' }
RTHistogramSet >> addedInBuilder: aBuilder [
	"Really ugly method. This will be fixed soon!"
	super addedInBuilder: aBuilder.

	self points: ((RTDistribution on: (points collect: y)) annotatedFrequency).
	self y: #first.
	
	builder addDecorator: (RTVerticalValuesDecorator new addAll: (0 to: (points collect: #first) max)).
	builder axisY noTick; noLabel.
	builder axisX noLabel; noTick
]

{ #category : #'as yet unclassified' }
RTHistogramSet >> barShape [
	^ histogramBuilder
]

{ #category : #'as yet unclassified' }
RTHistogramSet >> initialize [
	super initialize.
	self metric: #yourself
]

{ #category : #'as yet unclassified' }
RTHistogramSet >> metric: aMetricAsBlockOrSymbol [

	metric := aMetricAsBlockOrSymbol.
]

{ #category : #'as yet unclassified' }
RTHistogramSet >> renderIn: aView [
	self adjustMinAndMaxValues.
	self renderBarChartIn: aView
]
