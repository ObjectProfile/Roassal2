Class {
	#name : #RTCharterBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'extent',
		'x',
		'y',
		'size'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #'as yet unclassified' }
RTCharterBuilder >> exampleHistogram [
	"
	self new exampleLineCurve
	"
	| b |
	b := RTCharterBuilder new.
	b y: #numberOfMethods width: 100.
	b size: #numberOfVariable min: 5 max: 15.
	b points: (RTObject withAllSubclasses sortedAs: #numberOfMethods).
	b histogram.
	b open
]

{ #category : #'as yet unclassified' }
RTCharterBuilder >> exampleLineCurve [
	"
	self new exampleLineCurve
	"
	| b |
	b := RTCharterBuilder new.
	b y: #numberOfMethods width: 100.
	b size: #numberOfVariable min: 5 max: 15.
	b shape ellipse.
	b points: (RTObject withAllSubclasses sortedAs: #numberOfMethods).
	b connectPoints.
	b open
]

{ #category : #'as yet unclassified' }
RTCharterBuilder >> exampleSimpleScatterPlot [
	"
	self new exampleSimpleScatterPlot
	"
	| b |
	b := RTCharterBuilder new.
	b x: #numberOfLinesOfCode width: 100.
	b y: #numberOfMethods width: 100.
	b size: #numberOfVariable min: 5 max: 15.
	b shape ellipse.
	b points: RTObject withAllSubclasses.
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

{ #category : #initialization }
RTCharterBuilder >> initialize [
	super initialize.
	extent := 100 @ 100.
	x := #x.
	y := #y.
	size := 5
]

{ #category : #accessing }
RTCharterBuilder >> size [
	^ size
]

{ #category : #accessing }
RTCharterBuilder >> size: aValue [
	size := aValue
]

{ #category : #accessing }
RTCharterBuilder >> x [
	^ x
]

{ #category : #accessing }
RTCharterBuilder >> x: aValue [
	x := aValue
]

{ #category : #accessing }
RTCharterBuilder >> y [
	^ y
]

{ #category : #accessing }
RTCharterBuilder >> y: aValue [
	y := aValue
]
