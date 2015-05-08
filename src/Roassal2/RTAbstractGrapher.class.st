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
	#category : #'Roassal2-Builder-Grapher'
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

{ #category : #accessing }
RTAbstractGrapher >> decorators [
	^ decorators
]

{ #category : #utility }
RTAbstractGrapher >> defineAxesIfNecessary [
	
	self isXAxisDefined ifFalse: [ self axisX ].
	self isYAxisDefined ifFalse: [ self axisY ].
	
]

{ #category : #accessing }
RTAbstractGrapher >> extent [
	^ extent
]

{ #category : #accessing }
RTAbstractGrapher >> extent: aPoint [
	"Set the size of the graph"
	extent := aPoint
]

{ #category : #accessing }
RTAbstractGrapher >> getAxisX [
	^ axisConfigurationX
]

{ #category : #accessing }
RTAbstractGrapher >> getAxisY [
	^ axisConfigurationY 
]

{ #category : #accessing }
RTAbstractGrapher >> getPixelPositionOf: aPoint [
	"Return the position in the Roassal view of a point"

	| anX anY |
	anX := RTMetricNormalizer new
		getValue: aPoint x min: 0 max: self extent x minValue: minX maxValue: maxX.
	anY := RTMetricNormalizer new
		getValue: aPoint y min: 0 max: self extent y negated minValue: minY maxValue: maxY.
			
	^ anX @ anY
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
	decorators := OrderedCollection new.

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

{ #category : #accessing }
RTAbstractGrapher >> maxX [
	^ maxX
]

{ #category : #accessing }
RTAbstractGrapher >> maxX: aValue [
	maxX := aValue
]

{ #category : #accessing }
RTAbstractGrapher >> maxY [
	^ maxY
]

{ #category : #accessing }
RTAbstractGrapher >> maxY: aValue [
	maxY := aValue
]

{ #category : #accessing }
RTAbstractGrapher >> minX [
	^ minX
]

{ #category : #accessing }
RTAbstractGrapher >> minX: aValue [
	minX := aValue
]

{ #category : #accessing }
RTAbstractGrapher >> minY [
	^ minY
]

{ #category : #accessing }
RTAbstractGrapher >> minY: aValue [
	minY := aValue
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
