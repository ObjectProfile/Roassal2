"
A RTAxisRenderer is a renderer for axis. It simply render in a view an axis configuration

"
Class {
	#name : #RTAxisRenderer,
	#superclass : #RTObject,
	#instVars : [
		'config',
		'builder'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #'rendering-utility' }
RTAxisRenderer >> addAllToView: roassalElements [
	self builder view addAll: roassalElements
]

{ #category : #rendering }
RTAxisRenderer >> addTicksFrom: toPosition to: fromPosition [
	"Add ticks on the lines. Return the list of ticks"
	| tickShape ticks |
	tickShape := RTBox new height: 10; width: 5.
	ticks := tickShape elementsOn: (0 to: self numberOfTicks).
	ticks rotateByDegrees: (toPosition - fromPosition) angle radiansToDegrees abs.
	
	self addAllToView: ticks.
	ticks pushBack.
	RTMetricNormalizer new
		elements: ticks;
		normalizePosition: [ :v | v @ v ] min: fromPosition max: toPosition.
	^ ticks
]

{ #category : #'rendering-utility' }
RTAxisRenderer >> addToView: roassalElement [
	self builder view add: roassalElement
]

{ #category : #'public-rendering' }
RTAxisRenderer >> axisFrom: fromPosition to: toPosition [
	"THIS IS A PUBLIC METHOD"

	"fromPosition is the starting point of the axis. toPosition is the ending point"

	| ticks labelShape labelValues labels tickIntervalForLabel labelledTicks |
	"We add the labels"
	self axisLineFrom: fromPosition to: toPosition.
	ticks := self addTicksFrom: toPosition to: fromPosition.
	self numberOfLabels = 0
		ifTrue: [ ^ self ].
	tickIntervalForLabel := self tickIntervalForLabel.
	labelledTicks := (1 to: ticks size by: tickIntervalForLabel) collect: [ :i | ticks at: i ].
	labelValues := (0 to: self numberOfLabels)
		collect: [ :i | self minValue + (i * (self maxValue - self minValue) / self numberOfLabels) ].

	labelShape := RTLabel new text: [ :i | self getStringFromNumber: (labelValues at: i + 1) ].
	labels := labelShape elementsOn: (0 to: self numberOfLabels).
	labels withIndexDo: [ :label :i | 
		self moveLabel: label againstTick: (labelledTicks at: i).
		self rotateLabelIfNecessary: label ].
	
	self addAllToView: labels.	"We insert the label if necessary"
	self insertLabelIfNecessaryTo: toPosition.
	labels pushBack
]

{ #category : #rendering }
RTAxisRenderer >> axisLineFrom: aPositionFrom to: aPositionTo [
	"Add the lines"
	| edge ex2 ex1 |		
	ex1 := (RTBox new size: 0) element.
	ex2 := (RTBox new size: 0) element.
	ex2 translateTo: (aPositionTo).
	ex1 translateTo: (aPositionFrom).
	edge := (RTLine new color: config color) edgeFrom: ex1 to: ex2.
	self addToView: ex1; addToView: ex2.
	self addToView: edge
]

{ #category : #accessing }
RTAxisRenderer >> builder [
	^ builder
]

{ #category : #accessing }
RTAxisRenderer >> builder: aChartBuilder [
	builder := aChartBuilder
]

{ #category : #accessing }
RTAxisRenderer >> config [
	^ config
]

{ #category : #accessing }
RTAxisRenderer >> config: anAxisConfiguration [
	config := anAxisConfiguration
]

{ #category : #'accessing-computed' }
RTAxisRenderer >> getStringFromNumber: aNumber [
	^ config getStringFromNumber: aNumber
]

{ #category : #'public-rendering' }
RTAxisRenderer >> insertLabelIfNecessaryTo: toPosition [
	| lbl |
	self title notEmpty
		ifTrue: [ 
			lbl := RTLabel elementOn: self title.
			self addToView: lbl.
			lbl translateTo: toPosition - config titlePosition ]
]

{ #category : #'accessing-computed' }
RTAxisRenderer >> maxValue [
	^ config maxValue
]

{ #category : #'accessing-computed' }
RTAxisRenderer >> minValue [
	^ config minValue
]

{ #category : #action }
RTAxisRenderer >> moveLabel: label againstTick: aTick [
	self positionLabel value: label value: aTick
]

{ #category : #'accessing-computed' }
RTAxisRenderer >> numberOfLabels [
	^ config numberOfLabels
]

{ #category : #'accessing-computed' }
RTAxisRenderer >> numberOfTicks [
	^ config numberOfTicks
]

{ #category : #'accessing-computed' }
RTAxisRenderer >> positionLabel [
	^ config positionLabel
]

{ #category : #'public-rendering' }
RTAxisRenderer >> rotateLabelIfNecessary: label [
	"Rotate and position the label if necessary"
	config areLabelRotated ifFalse: [ ^ self ].
	label rotateByDegrees: config labelRotation.
	label translateBy: (label width / -2 * config labelRotation degreesToRadians cos @ 
								(label width / -2 * config labelRotation degreesToRadians sin)) "+ (5 @ 0)".
]

{ #category : #'accessing-computed' }
RTAxisRenderer >> tickIntervalForLabel [
	^ config tickIntervalForLabel
]

{ #category : #'accessing-computed' }
RTAxisRenderer >> title [
	^ config title
]
