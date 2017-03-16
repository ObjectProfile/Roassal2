Class {
	#name : #RTAbstractMultipleData,
	#superclass : #RTAbstractData,
	#instVars : [
		'groupedElements',
		'interaction',
		'metrics',
		'points'
	],
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #'public - metrics' }
RTAbstractMultipleData >> addMetric: aBlockOrSymbolOrValue [
	metrics add: aBlockOrSymbolOrValue
]

{ #category : #accessing }
RTAbstractMultipleData >> colorPalette [
	^ RTPalette c3
	"^ RTColorPalette qualitative colors: 8 scheme: 'Set2'"
]

{ #category : #hooks }
RTAbstractMultipleData >> getModelForElement:e atIndex: index [
	"Return the model that is used to insert a label for the element. index is index-th label to be provided."
	^ self points at: index
]

{ #category : #initialization }
RTAbstractMultipleData >> initialize [
	super initialize.
	points := #().
	metrics := OrderedCollection new.
	groupedElements := OrderedCollection new.
	x := [ :anElement | elements indexOf: anElement ].
	y := [ :anElement | anElement model ].
	self resetMinAndMax.
	self resetShapeBuilderForBar.

]

{ #category : #'public - query' }
RTAbstractMultipleData >> numberOfMetrics [
	"Return the number of metrics added to the data set"
	^ metrics size
]

{ #category : #'public - query' }
RTAbstractMultipleData >> numberOfPoints [
	"Return the number of points added in the data set"
	^ points size
]

{ #category : #accessing }
RTAbstractMultipleData >> points [
	^ points
]

{ #category : #accessing }
RTAbstractMultipleData >> points: objects [
	points := objects
]

{ #category : #hooks }
RTAbstractMultipleData >> renderIn: aView [

	"We need to do the layout here"

	| centralDot positiveElements negativeElements  |
	centralDot := self centralDot.

	RTMetricNormalizer new
		elements: elements;
		normalizeElementX: [ :anElement | x rtValue: anElement ]
			min: 0
			max: builder extent x
			minValue: minX
			maxValue: maxX + 1.
	"We have 'maxX + 1' because we do not want the last bar on the extremity of the X-Axis"

	"We treat the element with a positive value"
	positiveElements := elements select: [ :el | (y rtValue: el) >= 0 ].
	positiveElements
		ifNotEmpty: [
			RTMetricNormalizer new
				elements: positiveElements;
				normalizeElementHeight: [ :anElement | y rtValue: anElement ]
					min: 0
					max: builder extent y + centralDot position y
					minValue: 0
					maxValue: maxY ].

	RTAlignment new elements: positiveElements; fixedElement: centralDot; bottom.
	"TRConstraint use: centralDot alignFromBottom: positiveElements.	"
		
	"We treat the element with a negative value"
	negativeElements := elements copyWithoutAll: positiveElements.
	negativeElements
		ifNotEmpty: [ 
			RTMetricNormalizer new
				elements: negativeElements;
				normalizeElementHeight: [ :anElement | y rtValue: anElement ]
					min: centralDot position y negated 
					max: 0
					minValue: minY
					maxValue: 0.
			RTAlignment new elements: negativeElements; fixedElement: centralDot; top.
			"TRConstraint use: centralDot alignFromTop: negativeElements "].	"We set the actions, if any"
	elementActions do: [ :act | act rtValue: elements ]
]

{ #category : #hooks }
RTAbstractMultipleData >> resetShapeBuilderForBar [
	super resetShapeBuilderForBar.
	
	"Default width that compute an appropriate width"
	barBuilder width: [ :object | 
		(builder extent x / (self numberOfPoints * self numberOfMetrics * 2)) asFloat ]
]

{ #category : #hooks }
RTAbstractMultipleData >> selectElementsForAddingBarTitle [
	^ groupedElements collect: [ :es | es at: (es size / 2) asInteger + 1 ]
]
