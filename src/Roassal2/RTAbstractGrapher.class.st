Class {
	#name : #RTAbstractGrapher,
	#superclass : #RTBuilder,
	#instVars : [
		'axisConfigurationX',
		'axisConfigurationY',
		'maxX',
		'maxY',
		'minX',
		'minY',
		'extent',
		'decorators'
	],
	#category : #'Roassal2-Builder-Grapher-Core'
}

{ #category : #adding }
RTAbstractGrapher >> addDecorator: aDecorator [
	"Add a decorator"
	decorators add: aDecorator
]

{ #category : #utility }
RTAbstractGrapher >> adjustXAxisIfNecessary [
	"Move the title below the X axis."
	self getAxisX numberOfLabels = 0
		ifTrue: [ self getAxisX titlePosition: (0 @ -20) ]
		ifFalse: [ self getAxisX titlePosition: (0 @ -30) ].

]

{ #category : #'public-axis' }
RTAbstractGrapher >> axisX [
	axisConfigurationX ifNil: [
		axisConfigurationX := self createAxisConfiguration ].
	axisConfigurationX
		tickLabelOffset: 0 @ 15.
	^ axisConfigurationX
]

{ #category : #'private-axis' }
RTAbstractGrapher >> axisXFrom: aPoint to: anotherPoint [
	"Draw the axis from aPoint to anotherPoint"
	axisConfigurationX fromPoint: aPoint.
	axisConfigurationX toPoint: anotherPoint.
	axisConfigurationX hasMaxValueBeenManuallySet
		ifFalse: [ axisConfigurationX maxValue: self maxX ].
	axisConfigurationX hasMinValueBeenManuallySet 
		ifFalse: [ axisConfigurationX minValue: self minX ].
	axisConfigurationX axisFrom: aPoint to: anotherPoint

]

{ #category : #'public-axis' }
RTAbstractGrapher >> axisY [
	axisConfigurationY ifNil: [
		axisConfigurationY := self createAxisConfiguration ].
	axisConfigurationY
		tickLabelOffset: -30 @ 0.
	^ axisConfigurationY
]

{ #category : #'private-axis' }
RTAbstractGrapher >> axisYFrom: aPoint to: anotherPoint [
	"Draw the axis from aPoint to anotherPoint"
	axisConfigurationY fromPoint: aPoint.
	axisConfigurationY toPoint: anotherPoint.
	axisConfigurationY maxValue: self maxY.
	axisConfigurationY minValue: self minY.
	axisConfigurationY axisFrom: aPoint to: anotherPoint

]

{ #category : #utility }
RTAbstractGrapher >> centralPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self getPixelPositionOf: 0 @ 0
]

{ #category : #utility }
RTAbstractGrapher >> createAxisConfiguration [
	| newAxis |
	newAxis := RTAxisConfiguration new.
	newAxis builder: self.
	^ newAxis
]

{ #category : #hooks }
RTAbstractGrapher >> createView [
	^ RTView new @ RTDraggableView
]

{ #category : #'private - accessing' }
RTAbstractGrapher >> decorators [
	^ decorators
]

{ #category : #utility }
RTAbstractGrapher >> defineAxesIfNecessary [
	
	self isXAxisDefined ifFalse: [ self axisX ].
	self isYAxisDefined ifFalse: [ self axisY ].
	
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> extent [
	^ extent
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> extent: aPoint [
	"Set the size of the graph"
	extent := aPoint
]

{ #category : #'private - accessing' }
RTAbstractGrapher >> getAxisX [
	^ axisConfigurationX
]

{ #category : #'private - accessing' }
RTAbstractGrapher >> getAxisY [
	^ axisConfigurationY 
]

{ #category : #'private - accessing' }
RTAbstractGrapher >> getPixelPositionOf: aPoint [
	"Return the position in the Roassal view of a point"

	| anX anY |
	anX := RTMetricNormalizer new
		getValue: aPoint x min: 0 max: self extent x minValue: minX maxValue: maxX.
	anY := RTMetricNormalizer new
		getValue: aPoint y min: 0 max: self extent y negated minValue: minY maxValue: maxY.
			
	^ anX @ anY
]

{ #category : #'private - accessing' }
RTAbstractGrapher >> getPositionFromPixelPosition: aPoint [
	"Return the position in the graph from a position in the Roassal view of a point"

	| anX anY |
	anX := RTMetricNormalizer new
		getValue: aPoint x min: minX max: maxX minValue: 0 maxValue: self extent x.
	anY := RTMetricNormalizer new
		getValue: aPoint y min: minY max: maxY negated minValue: 0 maxValue: self extent y.
			
	^ anX @ anY negated
]

{ #category : #initialization }
RTAbstractGrapher >> initialize [
	super initialize.
	extent := 300 @ 200.
	minX := 0.
	minY := 0.
	maxX := 0.
	maxY := 0.
	
	"Collection of decorators"
	decorators := OrderedCollection new
]

{ #category : #testing }
RTAbstractGrapher >> isXAxisDefined [
	"Return true is X axis has been defined"
	^ axisConfigurationX notNil
]

{ #category : #testing }
RTAbstractGrapher >> isYAxisDefined [
	"Return true is X axis has been defined"
	^ axisConfigurationY notNil
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> maxX [
	^ maxX
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> maxX: aNumber [
	"
	Set the maximum value for the X-axis.
	Here is an example:
	| b ds |
	b := RTGrapher new.
	ds := RTData new.
	ds points: #(2 3 4).
	b add: ds.
	b maxX: 10.
	b
	
	Note that the provided argument should be greater than 0. This is because the 0 @ 0 point is always in the graph. 

	If you want to excluse the 0 @ 0 from the produced graph, we suggest you to read Section 6 (Translating the Y axis), in 
	https://dl.dropboxusercontent.com/u/31543901/AgileVisualization/Grapher/0203-Grapher.html
	"
	maxX := aNumber
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> maxY [
	^ maxY
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> maxY: aNumber [
	"
	Set the maximum value for the Y-axis.
	Here is an example:
	| b ds |
	b := RTGrapher new.
	ds := RTData new.
	ds points: #(2 3 4).
	b add: ds.
	b maxY: 10.
	b
	
	Note that the provided argument should be greater than 0. This is because the 0 @ 0 point is always in the graph. 

	If you want to excluse the 0 @ 0 from the produced graph, we suggest you to read Section 6 (Translating the Y axis), in 
	https://dl.dropboxusercontent.com/u/31543901/AgileVisualization/Grapher/0203-Grapher.html
	"
	maxY := aNumber
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> minX [
	^ minX
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> minX: aNumber [
	"
	Set the minimym value for the X-axis.
	Here is an example:
	| b ds |
	b := RTGrapher new.
	ds := RTData new.
	ds points: #(2 3 4).
	b add: ds.
	b minX: -10.
	b
	
	Note that the provided argument should be lesser than 0. This is because the 0 @ 0 point is always in the graph. 

	If you want to excluse the 0 @ 0 from the produced graph, we suggest you to read Section 6 (Translating the Y axis), in 
	https://dl.dropboxusercontent.com/u/31543901/AgileVisualization/Grapher/0203-Grapher.html
	"
	minX := aNumber
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> minY [
	^ minY
]

{ #category : #'public - accessing' }
RTAbstractGrapher >> minY: aNumber [
	"
	Set the minimym value for the Y-axis.
	Here is an example:
	| b ds |
	b := RTGrapher new.
	ds := RTData new.
	ds points: #(2 3 4).
	b add: ds.
	b minY: -10.
	b
	
	Note that the provided argument should be lesser than 0. This is because the 0 @ 0 point is always in the graph. 

	If you want to excluse the 0 @ 0 from the produced graph, we suggest you to read Section 6 (Translating the Y axis), in 
	https://dl.dropboxusercontent.com/u/31543901/AgileVisualization/Grapher/0203-Grapher.html
	"
	minY := aNumber
]

{ #category : #utility }
RTAbstractGrapher >> renderAllDecoratorsBehind [
	(decorators select: #isBehind) do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #utility }
RTAbstractGrapher >> renderAllDecoratorsInFront [
	(decorators select: #isInFront) do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #utility }
RTAbstractGrapher >> renderAxis [
	| centralPoint |
	centralPoint := self centralPoint.
"	shouldUseOptimalTicksAndLabelsForY ifTrue: 
	[ 
		| t |
		t := self optimalNumberOfTicksForMin: self minY max: self maxY wishedNumberOfTicks: self getAxisY numberOfTicks.
		self getAxisY numberOfTicks: t; numberOfLabels: t
	 ].
"
	self adjustXAxisIfNecessary.

	self axisYFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated.
	self axisXFrom: 0 @ centralPoint y to: extent x @ centralPoint y.
]
