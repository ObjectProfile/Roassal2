Class {
	#name : #RTTimeLineBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'height',
		'numberOfValues',
		'values',
		'addedElements',
		'colors'
	],
	#category : 'Roassal2-Builder-TimeLine'
}

{ #category : #adding }
RTTimeLineBuilder >> add: aNumericalValue [
	values add: aNumericalValue.
	(values size > numberOfValues) ifTrue: [ values removeFirst ].
	self render.
	view signalUpdate
]

{ #category : #'private visualization' }
RTTimeLineBuilder >> addBarsOn: aView [
	addedElements := self shape elementsOn: values.
	aView addAll: addedElements.
	addedElements @ RTPopup @ RTHighlightable.
]

{ #category : #'private visualization' }
RTTimeLineBuilder >> cleanView [
	addedElements do: #remove.
	addedElements := OrderedCollection new.
]

{ #category : #accessing }
RTTimeLineBuilder >> colors: arrayOfColors [
	"The array of colors is used to give a color to each bar. The lowest value is the first colors. The highest value is the last color"
	colors := arrayOfColors
]

{ #category : #hooks }
RTTimeLineBuilder >> createShapeBuilder [
	^ super createShapeBuilder rectangle width: 10; yourself
]

{ #category : #hooks }
RTTimeLineBuilder >> createView [
	^ RTView new
]

{ #category : #examples }
RTTimeLineBuilder >> example01 [
	"
	self new example01
	"

	| b |
	b := RTTimeLineBuilder new.
	b shape current width: 15.
	b height: 80.
	b numberOfValues: 20.
	b view canvas addMenu: 'Add' callback: [ b add: 30 atRandom ].
	b open
]

{ #category : #examples }
RTTimeLineBuilder >> example02WithRedAndGreen [
	"
	self new example02WithRedAndGreen
	"

	| b |
	b := RTTimeLineBuilder new.
	b colors: (Array with: Color red with: Color green).
	b shape current width: 15.
	b height: 80.
	b numberOfValues: 20.
	b view canvas addMenu: 'Add' callback: [ b add: 30 atRandom ].
	b open
]

{ #category : #examples }
RTTimeLineBuilder >> example03WithRedOrangeAndGreen [
	"
	self new example03WithRedOrangeAndGreen
	"

	| b |
	b := RTTimeLineBuilder new.
	b colors: (Array with: Color red with: Color orange with: Color green).
	b shape current width: 15.
	b height: 80.
	b numberOfValues: 20.
	b view canvas addMenu: 'Add' callback: [ b add: 30 atRandom ].
	b open
]

{ #category : #accessing }
RTTimeLineBuilder >> height: anHeightInPixels [
	"Height of the maximum bar"
	height := anHeightInPixels
]

{ #category : #initialization }
RTTimeLineBuilder >> initialize [
	super initialize.
	height := 100.
	numberOfValues := 20.
	values := OrderedCollection new.
	colors := Array with: Color gray.
	addedElements := OrderedCollection new.
]

{ #category : #'private visualization' }
RTTimeLineBuilder >> layoutBars [
	RTHorizontalLineLayout new
		alignBottom;
		gapSize: 1;
		on: addedElements
]

{ #category : #accessing }
RTTimeLineBuilder >> numberOfValues: numberOfValuesAsInteger [
	"Give the number of values displayed"
	numberOfValues := numberOfValuesAsInteger
]

{ #category : #hooks }
RTTimeLineBuilder >> renderIn: aView [
	values ifEmpty: [ ^ self ].
	self cleanView.
	self setShapeForMaxValue: values max.
	self addBarsOn: aView.
	self layoutBars.
	view canvas camera focusOnCenter.
	view signalUpdate
]

{ #category : #'private visualization' }
RTTimeLineBuilder >> setShapeForMaxValue: maxValue [
	| normalizer |
	normalizer := RTMultiLinearColor new colors: colors.
	self shape current 
		color: [ :v | normalizer level: v / maxValue ];
		height: [ :v | v * height / maxValue ]
]
