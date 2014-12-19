Class {
	#name : #RTStackedDataSet,
	#superclass : #RTAbstractDataSet,
	#instVars : [
		'shouldHaveHistogramBars'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #public }
RTStackedDataSet >> barShape [
	shouldHaveHistogramBars := true.
	^ histogramBuilder
]

{ #category : #hooks }
RTStackedDataSet >> centralDot [
	^ (RTEllipse new
		size: 0;
		color: Color red) element translateTo: (builder axisPointFor: 0 @ 0)
]

{ #category : #'min and max' }
RTStackedDataSet >> computeMinAndMaxForX [
	minX := 1.
	maxX := builder getMaxNumberOfPoints.

	(minX < 0 and: [maxX < 0]) ifTrue: [ maxX := 0 ].
	(minX > 0 and: [maxX > 0]) ifTrue: [ minX := 0 ].
	

]

{ #category : #public }
RTStackedDataSet >> histogramWithBarTitle: aBlockOrSymbol [
	"Draw an histogram with title"
	self barShape.
	elementActions add: [ :elements | 
		| lbl |
		elements do: [ :e |
			lbl := (RTLabel new text: aBlockOrSymbol; color: Color lightGray) elementOn: e model.
			lbl rotateByDegrees: -45.
			TRConstraint move: lbl below: e.
			lbl translateBy: (lbl width / -2 @ 0) + (5 @ 0).
			elements anyOne view add: lbl.
		] ].
	 
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
RTStackedDataSet >> renderHistogramIn: aView [
	| centralDot elements positiveElements negativeElements |
	centralDot := self centralDot.
	
	elements := histogramBuilder elementsOn: points.
	builder view addAll: elements.
	interaction setUpElements: elements.
	RTMetricNormalizer new
		elements: elements;
		normalizeElementX: [ :element | (elements indexOf: element) + 1 ]
			min: 0
			max: builder extent x
			minValue: 1
			maxValue: elements size + 2.	

	"We treat the element with a positive value"
	positiveElements := elements select: [ :el | (y rtValue: el model) >= 0 ].
	positiveElements
		ifNotEmpty: [
			RTMetricNormalizer new
				elements: positiveElements;
				normalizeHeight: [ :model | y rtValue: model ]
					min: 0
					max: builder extent y + centralDot position y
					minValue: 0
					maxValue: maxY ].
	TRConstraint use: centralDot alignFromBottom: positiveElements.	
		
	"We treat the element with a negative value"
	negativeElements := elements copyWithoutAll: positiveElements.
	negativeElements
		ifNotEmpty: [ 
			RTMetricNormalizer new
				elements: negativeElements;
				normalizeHeight: [ :model | y rtValue: model ]
					min: "builder extent y -"  centralDot position y negated 
					max: 0
					minValue: minY
					maxValue: 0.
			TRConstraint use: centralDot alignFromTop: negativeElements ].	"We set the actions, if any"
	elementActions do: [ :act | act rtValue: elements ]
]

{ #category : #hooks }
RTStackedDataSet >> renderIn: aView [

	"This is a bit ugly. Maybe having a class hierarchy would be better"
	self adjustMinAndMaxValues.
	shouldHaveHistogramBars 
		ifTrue: [ self renderHistogramIn: aView ]
		ifFalse: [ self renderDotAndLinesIn: aView ]
]

{ #category : #public }
RTStackedDataSet >> stackX [
	"DO NOTHING. TO REMOVE"
]
