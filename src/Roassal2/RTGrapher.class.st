Class {
	#name : #RTGrapher,
	#superclass : #RTBuilder,
	#instVars : [
		'extent',
		'datasets',
		'plugins',
		'axisConfigurationX',
		'axisConfigurationY',
		'minX',
		'minY',
		'maxX',
		'maxY',
		'shouldUseOptimalTicksAndLabelsForY'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #adding }
RTGrapher >> add: aDataSet [
	"Essential method. Add a dataset into the grapher. Only non-empty set are considered"
	aDataSet numberOfPoints = 0 ifTrue: [ ^ self ].
	
	datasets add: aDataSet.
	aDataSet builder: self
]

{ #category : #adding }
RTGrapher >> addPlugin: aPlugin [
	"Add a plugin"
	plugins add: aPlugin
]

{ #category : #'public-axis' }
RTGrapher >> axisX [
	self checkIfDataSetHaveBeenAdded.
	axisConfigurationX := self createAxisConfiguration.
	axisConfigurationX
		tickLabelOffset: 0 @ 15.
	^ axisConfigurationX
]

{ #category : #'private-axis' }
RTGrapher >> axisXFrom: aPoint to: anotherPoint [
	"Draw the axis from aPoint to anotherPoint"
	axisConfigurationX fromPoint: aPoint.
	axisConfigurationX toPoint: anotherPoint.
	axisConfigurationX maxValue: self maxX.
	axisConfigurationX minValue: self minX.
	axisConfigurationX axisFrom: aPoint to: anotherPoint

]

{ #category : #'public-axis' }
RTGrapher >> axisXWithNumberOfTicks: aNumber [
	self axisX numberOfTicks: aNumber

]

{ #category : #'public-axis' }
RTGrapher >> axisY [
	self checkIfDataSetHaveBeenAdded.
	axisConfigurationY := self createAxisConfiguration.
	axisConfigurationY
		tickLabelOffset: -30 @ 0.
	^ axisConfigurationY
]

{ #category : #'private-axis' }
RTGrapher >> axisYFrom: aPoint to: anotherPoint [
	"Draw the axis from aPoint to anotherPoint"
	axisConfigurationY fromPoint: aPoint.
	axisConfigurationY toPoint: anotherPoint.
	axisConfigurationY maxValue: self maxY.
	axisConfigurationY minValue: self minY.
	axisConfigurationY axisFrom: aPoint to: anotherPoint

]

{ #category : #accessing }
RTGrapher >> axisYLabelled [
	self axisY.
	shouldUseOptimalTicksAndLabelsForY := true.
]

{ #category : #'public-axis' }
RTGrapher >> axisYWithNumberOfTicks: aNumber [
	self axisY numberOfTicks: aNumber

]

{ #category : #utility }
RTGrapher >> centralPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self getPixelPositionOf: 0 @ 0
]

{ #category : #utility }
RTGrapher >> checkIfDataSetHaveBeenAdded [
	datasets ifEmpty: [ self error: 'No dataset has been added?' ]
]

{ #category : #utility }
RTGrapher >> createAxisConfiguration [
	| newAxis |
	newAxis := RTAxisConfiguration new.
	newAxis builder: self.
	^ newAxis
]

{ #category : #hooks }
RTGrapher >> createView [
	^ RTView new @ RTDraggableView
]

{ #category : #'data sets' }
RTGrapher >> datasets [
	^ datasets copy
]

{ #category : #utility }
RTGrapher >> defineAxesIfNecessary [
	
	self isXAxisDefined ifFalse: [ self axisX ].
	self isYAxisDefined ifFalse: [ self axisY ].
	
]

{ #category : #accessing }
RTGrapher >> extent [
	^ extent
]

{ #category : #accessing }
RTGrapher >> extent: aPoint [
	"Set the size of the graph"
	extent := aPoint
]

{ #category : #accessing }
RTGrapher >> getAxisX [
	^ axisConfigurationX
]

{ #category : #accessing }
RTGrapher >> getAxisY [
	^ axisConfigurationY 
]

{ #category : #accessing }
RTGrapher >> getMaxNumberOfPoints [
	"Return the maximum number of points any of the dataset has."
	^ datasets inject: 0 into: [ :max :ds | max max: ds numberOfPoints ]
]

{ #category : #accessing }
RTGrapher >> getPixelPositionOf: aPoint [
	"Return the position in pixel in the View for a given data point"
	"This method should be called only if all the dataset have been set the min and max values"
	^ datasets first getPixelPositionOf: aPoint
]

{ #category : #'data sets' }
RTGrapher >> hasDataSet [
	^ self numberOfDataSets > 0
]

{ #category : #'min and max' }
RTGrapher >> homogenizeMinAndMax [
	| tminX tmaxX tminY tmaxY |
	tminX := self minX.
	tmaxX := self maxX.
	tminY := self minY.
	tmaxY := self maxY.
	datasets do: [ :ds |
		ds minX: tminX.
		ds minY: tminY.
		ds maxX: tmaxX.
		ds maxY: tmaxY. ]
]

{ #category : #initialization }
RTGrapher >> initialize [
	super initialize.
	extent := 300 @ 200.
	
	"Collection of data sets"
	datasets := OrderedCollection new.
	
	"Collection of plugins"
	plugins := OrderedCollection new.

	minX := 0.
	minY := 0.
	maxX := 0.
	maxY := 0.
	
	shouldUseOptimalTicksAndLabelsForY := false.
]

{ #category : #testing }
RTGrapher >> isXAxisDefined [
	"Return true is X axis has been defined"
	^ axisConfigurationX notNil
]

{ #category : #testing }
RTGrapher >> isYAxisDefined [
	"Return true is X axis has been defined"
	^ axisConfigurationY notNil
]

{ #category : #accessing }
RTGrapher >> maxX [
	^ self hasDataSet 
		ifTrue: [ maxX max: self maxXFromDataSets ]
		ifFalse: [ maxX ]
]

{ #category : #accessing }
RTGrapher >> maxX: aValue [
	maxX := aValue
]

{ #category : #'data sets' }
RTGrapher >> maxXFromDataSets [
	^ (datasets collect: #maxX) max
]

{ #category : #accessing }
RTGrapher >> maxY [
	^ self hasDataSet 
		ifTrue: [ maxY max: self maxYFromDataSets ]
		ifFalse: [ maxY ] 
]

{ #category : #accessing }
RTGrapher >> maxY: aValue [
	maxY := aValue
]

{ #category : #'data sets' }
RTGrapher >> maxYFromDataSets [
	^ (datasets collect: #maxY) max
]

{ #category : #accessing }
RTGrapher >> minX [
	^ self hasDataSet 
		ifTrue: [ minX min: self minXFromDataSets ]
		ifFalse: [ minX ]
]

{ #category : #accessing }
RTGrapher >> minX: aValue [
	minX := aValue
]

{ #category : #'data sets' }
RTGrapher >> minXFromDataSets [
	^ (datasets collect: #minX) min
]

{ #category : #accessing }
RTGrapher >> minY [
	^ self hasDataSet 
		ifTrue: [ minY min: self minYFromDataSets ]
		ifFalse: [ minY ] 
]

{ #category : #accessing }
RTGrapher >> minY: aValue [
	minY := aValue
]

{ #category : #'data sets' }
RTGrapher >> minYFromDataSets [
	^ (datasets collect: #minY) min
]

{ #category : #accessing }
RTGrapher >> numberOfDataSets [
	^ datasets size
]

{ #category : #utility }
RTGrapher >> optimalNumberOfTicksForDiff: diff wishedNumberOfTicks: nbOfTicks [
"	((self maxY - self minY) \\ nbOfTicks) ~= 0
			ifTrue: [ ^ (self maxY - self minY); numberOfLabels: (self maxY - self minY) ]
"			
			(diff \\ 4) = 0 ifTrue: [ ^ 4 ].
			(diff \\ 5) = 0 ifTrue: [ ^ 5 ]. 
			(diff \\ 6) = 0 ifTrue: [ ^ 6 ]. 
			(diff \\ 7) = 0 ifTrue: [ ^ 7 ].
			(diff \\ 8) = 0 ifTrue: [ ^ 8 ].
			(diff \\ 9) = 0 ifTrue: [ ^ 9 ].
	^ diff
]

{ #category : #utility }
RTGrapher >> optimalNumberOfTicksForMin: min max: max wishedNumberOfTicks: nbOfTicks [
"	((self maxY - self minY) \\ nbOfTicks) ~= 0
			ifTrue: [ ^ (self maxY - self minY); numberOfLabels: (self maxY - self minY) ]
"			

	(min = 0 or: [ max = 0 ]) ifTrue: [ ^ nbOfTicks ].	
	^ nbOfTicks
]

{ #category : #utility }
RTGrapher >> renderAllPlugins [
	plugins do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #utility }
RTGrapher >> renderAllPluginsBehind [
	(plugins select: #isBehind) do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #utility }
RTGrapher >> renderAllPluginsInFront [
	(plugins select: #isInFront) do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #utility }
RTGrapher >> renderAxis [
	| centralPoint |
	centralPoint := self centralPoint.
	shouldUseOptimalTicksAndLabelsForY ifTrue: 
	[ 
		| t |
		t := self optimalNumberOfTicksForMin: self minY max: self maxY wishedNumberOfTicks: self getAxisY numberOfTicks.
		self getAxisY numberOfTicks: t; numberOfLabels: t
	 ].

	self axisYFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated.
	self axisXFrom: 0 @ centralPoint y to: extent x @ centralPoint y.
]

{ #category : #hooks }
RTGrapher >> renderDataSetsIn: aView [
	datasets do: [ :aDataset | aDataset renderIn: aView ]
]

{ #category : #hooks }
RTGrapher >> renderIn: aView [
	datasets do: #computeMinAndMax.
	self homogenizeMinAndMax.
	self defineAxesIfNecessary.
	self renderAxis.
	self renderAllPluginsInFront.
	self renderDataSetsIn: aView.
	self renderAllPluginsBehind
]
