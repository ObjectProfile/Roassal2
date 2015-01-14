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
	super addedInBuilder: aBuilder.

	self points: ((RTDistribution on: (points collect: y)) annotatedFrequency).
	self y: #first.

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
