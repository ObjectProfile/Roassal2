"
Class implementing a slider with two cursors, useful for selection of intervals
"
Class {
	#name : #RTDoubleSlider,
	#superclass : #RTBuilder,
	#instVars : [
		'callback',
		'labelled',
		'position',
		'sliderElements',
		'min',
		'max',
		'useIntegerLabel',
		'extremity1',
		'extremity2',
		'line',
		'cursorMin',
		'cursorMax',
		'lineCursor'
	],
	#category : #'Roassal2-Builder-UI-Slider'
}

{ #category : #public }
RTDoubleSlider >> build [
	| allElements res |
	allElements := view elements.
	res := super build.
	TRConstraint move: sliderElements to: position and: allElements.
	^ res
]

{ #category : #accessing }
RTDoubleSlider >> callback [
	^ callback
]

{ #category : #accessing }
RTDoubleSlider >> callback: aTwoArgBlock [
	"everytime the slider is moved the aTwoArgBlock will be evaluated with 2 arguments which correspond 
	to the position of the 2 cursors of the double slider, from the configured min value to the configured max value"
	callback := aTwoArgBlock
]

{ #category : #hooks }
RTDoubleSlider >> createShapeBuilder [
	"RTBox new color: (Color red alpha: 0.5); width: 15; height: 20"
	^ super createShapeBuilder
		rectangle;
		color: (Color red alpha: 0.5);
		width: 10;
		height: 20;
		yourself
]

{ #category : #examples }
RTDoubleSlider >> example01 [
	"
		self new example01
	"
	| v label1 label2 doubleSlider composer |
	v := RTView new.
	
	composer := RTComposer new.
	composer view: v.
	
	label1 := RTLabel elementOn: 0.
	v add: label1.
	composer group: label1.
	
	label2 := RTLabel elementOn: 0.
	v add: label2.
	composer group: label2.
	
	doubleSlider := RTDoubleSlider new.
	doubleSlider view: v.
	doubleSlider labeled.
	doubleSlider callback: [ :cursor1 :cursor2 | 
		label1 model: cursor1 * 100.
		label1 updateShape.
		label2 model: cursor2 * 100.
		label2 updateShape. ].
	doubleSlider move: #below.
	doubleSlider build.
	composer group: doubleSlider.
	
	composer layout: (RTVerticalLineLayout new gapSize: 25; center).
	^ v
	 
]

{ #category : #initialization }
RTDoubleSlider >> initialize [
	super initialize.
	labelled := false.
	callback := [ :arg1 :arg2 | ].
	sliderElements := #().
	min := 0.0.
	max := 1.0.
	useIntegerLabel := false.
]

{ #category : #accessing }
RTDoubleSlider >> isLabelled [
	^labelled
]

{ #category : #accessing }
RTDoubleSlider >> labeled [
	labelled := true
]

{ #category : #accessing }
RTDoubleSlider >> labelled [
	self labeled
]

{ #category : #accessing }
RTDoubleSlider >> max [
	^ max
]

{ #category : #accessing }
RTDoubleSlider >> max: aNumber [
	self assert: [ min <= aNumber ] description: 'Max value cant be smaller than the min value'.
	max := aNumber
]

{ #category : #accessing }
RTDoubleSlider >> min [
	^ min
]

{ #category : #accessing }
RTDoubleSlider >> min: aNumber [
	self assert: [ aNumber <= max ] description: 'Min value cant be bigger than the max value'.
	min := aNumber
]

{ #category : #accessing }
RTDoubleSlider >> moveBelow [
	self move: #below
]

{ #category : #hooks }
RTDoubleSlider >> renderIn: aView [
	self createElements.
	aView addAll: sliderElements.
	self addDraggableInteractions.
	self addLabelsIfNecessary.
	
]

{ #category : #accessing }
RTDoubleSlider >> useIntegerLabel [
	"sets the display of the slider's label using an integral value instead of a floating point one
	ex:
		slider useIntegerLabel
	"
	useIntegerLabel := true
]

{ #category : #accessing }
RTDoubleSlider >> usingIntegerLabel [
	^useIntegerLabel
]
