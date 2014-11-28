Class {
	#name : #RTStackedDataSet,
	#superclass : #RTAbstractDataSet,
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #'min and max' }
RTStackedDataSet >> computeMinAndMaxForX [
	minX := 1.
	maxX := builder getMaxNumberOfPoints.

	(minX < 0 and: [maxX < 0]) ifTrue: [ maxX := 0 ].
	(minX > 0 and: [maxX > 0]) ifTrue: [ minX := 0 ].
	

]

{ #category : #initialization }
RTStackedDataSet >> initialize [
	"Subclasses should redefine this method to perform initializations on instance creation" 
	super initialize.
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
					maxValue: maxX + 1.
			
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

{ #category : #public }
RTStackedDataSet >> stackX [
	"DO NOTHING. TO REMOVE"
]
