Class {
	#name : #RTGrapherBuilder,
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
RTGrapherBuilder >> add: aDataSet [
	"Essential method. Add a dataset into the grapher. Only non-empty set are considered"
	aDataSet numberOfPoints = 0 ifTrue: [ ^ self ].
	
	datasets add: aDataSet.
	aDataSet builder: self
]

{ #category : #adding }
RTGrapherBuilder >> addPlugin: aPlugin [
	"Add a plugin"
	plugins add: aPlugin
]

{ #category : #'public-axis' }
RTGrapherBuilder >> axisX [
	self checkIfDataSetHaveBeenAdded.
	axisConfigurationX := self createAxisConfiguration.
	axisConfigurationX
		tickLabelOffset: 0 @ 15.
	^ axisConfigurationX
]

{ #category : #'private-axis' }
RTGrapherBuilder >> axisXFrom: aPoint to: anotherPoint [
	"Draw the axis from aPoint to anotherPoint"
	axisConfigurationX fromPoint: aPoint.
	axisConfigurationX toPoint: anotherPoint.
	axisConfigurationX maxValue: self maxX.
	axisConfigurationX minValue: self minX.
	axisConfigurationX axisFrom: aPoint to: anotherPoint

]

{ #category : #'public-axis' }
RTGrapherBuilder >> axisXWithNumberOfTicks: aNumber [
	self axisX numberOfTicks: aNumber

]

{ #category : #'public-axis' }
RTGrapherBuilder >> axisY [
	self checkIfDataSetHaveBeenAdded.
	axisConfigurationY := self createAxisConfiguration.
	axisConfigurationY
		tickLabelOffset: -30 @ 0.
	^ axisConfigurationY
]

{ #category : #'private-axis' }
RTGrapherBuilder >> axisYFrom: aPoint to: anotherPoint [
	"Draw the axis from aPoint to anotherPoint"
	axisConfigurationY fromPoint: aPoint.
	axisConfigurationY toPoint: anotherPoint.
	axisConfigurationY maxValue: self maxY.
	axisConfigurationY minValue: self minY.
	axisConfigurationY axisFrom: aPoint to: anotherPoint

]

{ #category : #accessing }
RTGrapherBuilder >> axisYLabelled [
	self axisY.
	shouldUseOptimalTicksAndLabelsForY := true.
]

{ #category : #'public-axis' }
RTGrapherBuilder >> axisYWithNumberOfTicks: aNumber [
	self axisY numberOfTicks: aNumber

]

{ #category : #utility }
RTGrapherBuilder >> centralPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self getPixelPositionOf: 0 @ 0
]

{ #category : #utility }
RTGrapherBuilder >> checkIfDataSetHaveBeenAdded [
	datasets ifEmpty: [ self error: 'No dataset has been added?' ]
]

{ #category : #utility }
RTGrapherBuilder >> createAxisConfiguration [
	| newAxis |
	newAxis := RTAxisConfiguration new.
	newAxis builder: self.
	^ newAxis
]

{ #category : #hooks }
RTGrapherBuilder >> createView [
	^ RTView new @ RTDraggableView
]

{ #category : #'data sets' }
RTGrapherBuilder >> datasets [
	^ datasets copy
]

{ #category : #utility }
RTGrapherBuilder >> defineAxesIfNecessary [
	
	self isXAxisDefined ifFalse: [ self axisX ].
	self isYAxisDefined ifFalse: [ self axisY ].
	
]

{ #category : #accessing }
RTGrapherBuilder >> extent [
	^ extent
]

{ #category : #accessing }
RTGrapherBuilder >> extent: aPoint [
	"Set the size of the graph"
	extent := aPoint
]

{ #category : #accessing }
RTGrapherBuilder >> getAxisX [
	^ axisConfigurationX
]

{ #category : #accessing }
RTGrapherBuilder >> getAxisY [
	^ axisConfigurationY 
]

{ #category : #accessing }
RTGrapherBuilder >> getMaxNumberOfPoints [
	"Return the maximum number of points any of the dataset has."
	^ datasets inject: 0 into: [ :max :ds | max max: ds numberOfPoints ]
]

{ #category : #accessing }
RTGrapherBuilder >> getPixelPositionOf: aPoint [
	"Return the position in pixel in the View for a given data point"
	"This method should be called only if all the dataset have been set the min and max values"
	^ datasets first getPixelPositionOf: aPoint
]

{ #category : #'data sets' }
RTGrapherBuilder >> hasDataSet [
	^ self numberOfDataSets > 0
]

{ #category : #'min and max' }
RTGrapherBuilder >> homogenizeMinAndMax [
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
RTGrapherBuilder >> initialize [
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
RTGrapherBuilder >> isXAxisDefined [
	"Return true is X axis has been defined"
	^ axisConfigurationX notNil
]

{ #category : #testing }
RTGrapherBuilder >> isYAxisDefined [
	"Return true is X axis has been defined"
	^ axisConfigurationY notNil
]

{ #category : #accessing }
RTGrapherBuilder >> maxX [
	^ self hasDataSet 
		ifTrue: [ maxX max: self maxXFromDataSets ]
		ifFalse: [ maxX ]
]

{ #category : #accessing }
RTGrapherBuilder >> maxX: aValue [
	maxX := aValue
]

{ #category : #'data sets' }
RTGrapherBuilder >> maxXFromDataSets [
	^ (datasets collect: #maxX) max
]

{ #category : #accessing }
RTGrapherBuilder >> maxY [
	^ self hasDataSet 
		ifTrue: [ maxY max: self maxYFromDataSets ]
		ifFalse: [ maxY ] 
]

{ #category : #accessing }
RTGrapherBuilder >> maxY: aValue [
	maxY := aValue
]

{ #category : #'data sets' }
RTGrapherBuilder >> maxYFromDataSets [
	^ (datasets collect: #maxY) max
]

{ #category : #accessing }
RTGrapherBuilder >> minX [
	^ self hasDataSet 
		ifTrue: [ minX min: self minXFromDataSets ]
		ifFalse: [ minX ]
]

{ #category : #accessing }
RTGrapherBuilder >> minX: aValue [
	minX := aValue
]

{ #category : #'data sets' }
RTGrapherBuilder >> minXFromDataSets [
	^ (datasets collect: #minX) min
]

{ #category : #accessing }
RTGrapherBuilder >> minY [
	^ self hasDataSet 
		ifTrue: [ minY min: self minYFromDataSets ]
		ifFalse: [ minY ] 
]

{ #category : #accessing }
RTGrapherBuilder >> minY: aValue [
	minY := aValue
]

{ #category : #'data sets' }
RTGrapherBuilder >> minYFromDataSets [
	^ (datasets collect: #minY) min
]

{ #category : #accessing }
RTGrapherBuilder >> numberOfDataSets [
	^ datasets size
]

{ #category : #utility }
RTGrapherBuilder >> optimalNumberOfTicksForDiff: diff wishedNumberOfTicks: nbOfTicks [
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
RTGrapherBuilder >> optimalNumberOfTicksForMin: min max: max wishedNumberOfTicks: nbOfTicks [
"	((self maxY - self minY) \\ nbOfTicks) ~= 0
			ifTrue: [ ^ (self maxY - self minY); numberOfLabels: (self maxY - self minY) ]
"			

	(min = 0 or: [ max = 0 ]) ifTrue: [ ^ nbOfTicks ].	
	^ nbOfTicks
]

{ #category : #utility }
RTGrapherBuilder >> renderAllPlugins [
	plugins do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #utility }
RTGrapherBuilder >> renderAllPluginsBehind [
	(plugins select: #isBehind) do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #utility }
RTGrapherBuilder >> renderAllPluginsInFront [
	(plugins select: #isInFront) do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #utility }
RTGrapherBuilder >> renderAxis [
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
RTGrapherBuilder >> renderDataSetsIn: aView [
	datasets do: [ :aDataset | aDataset renderIn: aView ]
]

{ #category : #hooks }
RTGrapherBuilder >> renderIn: aView [
	datasets do: #computeMinAndMax.
	self homogenizeMinAndMax.
	self defineAxesIfNecessary.
	self renderAxis.
	self renderAllPluginsInFront.
	self renderDataSetsIn: aView.
	self renderAllPluginsBehind
]
