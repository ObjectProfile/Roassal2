"
RTGrapher describes a chart. Data set may be added and axis may be configured. Consider the following example:

b := RTGrapher new.
ds := RTDataSet new. 
ds dotShape color: Color red. 
ds points: #(5 1 20 8).
b add: ds.
b build.

"
Class {
	#name : #RTGrapher,
	#superclass : #RTAbstractGrapher,
	#instVars : [
		'datasets',
		'decorators',
		'generator',
		'shouldUseNiceLabelsForX',
		'shouldUseNiceLabelsForY'
	],
	#category : #'Roassal2-Builder-Grapher'
}

{ #category : #adding }
RTGrapher >> add: aDataSet [
	"Essential method. Add a dataset into the grapher. Only non-empty set are considered"
	aDataSet numberOfPoints = 0 ifTrue: [ ^ self ].
	
	datasets add: aDataSet.
	aDataSet addedInBuilder: self
]

{ #category : #adding }
RTGrapher >> addDecorator: aDecorator [
	"Add a decorator"
	decorators add: aDecorator
]

{ #category : #'public-axis' }
RTGrapher >> axisX [
	self checkIfDataSetHaveBeenAdded.
	^ super axisX
]

{ #category : #'public-axis' }
RTGrapher >> axisXWithNumberOfTicks: aNumber [
	self axisX numberOfTicks: aNumber

]

{ #category : #'public-axis' }
RTGrapher >> axisY [
	self checkIfDataSetHaveBeenAdded.
	^ super axisY
]

{ #category : #'public-axis' }
RTGrapher >> axisYWithNumberOfTicks: aNumber [
	self axisY numberOfTicks: aNumber

]

{ #category : #utility }
RTGrapher >> checkIfDataSetHaveBeenAdded [
	datasets ifEmpty: [ self error: 'No dataset has been added?' ]
]

{ #category : #'data sets' }
RTGrapher >> datasets [
	^ datasets copy
]

{ #category : #accessing }
RTGrapher >> decorators [
	^ decorators
]

{ #category : #accessing }
RTGrapher >> decorators: anObject [
	decorators := anObject
]

{ #category : #accessing }
RTGrapher >> getMaxNumberOfPoints [
	"Return the maximum number of points any of the dataset has."
	^ datasets inject: 0 into: [ :max :ds | max max: ds numberOfPoints ]
]

{ #category : #utility }
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
	| tminX tmaxX tminY tmaxY block r |
	generator setLooseFlag: true.
	block := [ :axis :lmin :lmax | | result nticks|
		nticks := axis numberOfTicks isZero ifTrue: [ 2 ] ifFalse: [ axis numberOfTicks ].
		result := generator searchMin: lmin max: lmax desired: nticks.
		axis numberOfTicks isZero ifFalse: [ axis numberOfTicks: result numberOfTicks ].
		axis numberOfLabels isZero ifFalse: [ axis numberOfLabels: result numberOfTicks ].
		result. ].
	shouldUseNiceLabelsForX ifTrue: [ 
		r := block value: self getAxisX value: self minX value: self maxX.
		self minX: (tminX := r min).
		self maxX: (tmaxX := r max).] ifFalse: [ 
		tminX := self minX.
		tmaxX := self maxX ].
	shouldUseNiceLabelsForY ifTrue: [ 
		r := block value: self getAxisY value: self minY value: self maxY.
		self minY: (tminY := r min).
		self maxY: (tmaxY := r max). ] ifFalse: [ 
		tminY := self minY.
		tmaxY := self maxY. ].

	datasets do: [ :ds |
		ds minX: tminX.
		ds minY: tminY.
		ds maxX: tmaxX.
		ds maxY: tmaxY. ]
]

{ #category : #initialization }
RTGrapher >> initialize [
	super initialize.
	
	"Collection of data sets"
	datasets := OrderedCollection new.
	
	"Collection of decorators"
	decorators := OrderedCollection new.
	
	generator := RTLabelGenerator nice: RTNiceStepSizeGenerator new.
	self shouldUseNiceLabels: true.
]

{ #category : #accessing }
RTGrapher >> maxX [
	^ self hasDataSet 
		ifTrue: [ maxX max: self maxXFromDataSets ]
		ifFalse: [ maxX ]
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

{ #category : #'data sets' }
RTGrapher >> minYFromDataSets [
	^ (datasets collect: #minY) min
]

{ #category : #accessing }
RTGrapher >> numberOfDataSets [
	^ datasets size
]

{ #category : #accessing }
RTGrapher >> numberOfDecorators [
	"Return the number of decorators that have been added"
	^ decorators size
]

{ #category : #'work in progress' }
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

{ #category : #'work in progress' }
RTGrapher >> optimalNumberOfTicksForMin: min max: max wishedNumberOfTicks: nbOfTicks [
"	((self maxY - self minY) \\ nbOfTicks) ~= 0
			ifTrue: [ ^ (self maxY - self minY); numberOfLabels: (self maxY - self minY) ]
"			

	(min = 0 or: [ max = 0 ]) ifTrue: [ ^ nbOfTicks ].	
	^ nbOfTicks
]

{ #category : #utility }
RTGrapher >> renderAllPluginsBehind [
	(decorators select: #isBehind) do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #utility }
RTGrapher >> renderAllPluginsInFront [
	(decorators select: #isInFront) do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #hooks }
RTGrapher >> renderDataSetsIn: aView [
	datasets do: [ :aDataset | aDataset renderIn: aView ]
]

{ #category : #hooks }
RTGrapher >> renderIn: aView [
	datasets do: #computeMinAndMax.
	self defineAxesIfNecessary.
	self homogenizeMinAndMax.
	self renderAxis.
	self renderAllPluginsInFront.
	self renderDataSetsIn: aView.
	self renderAllPluginsBehind
]

{ #category : #accessing }
RTGrapher >> shouldUseNiceLabels: aBool [
	self shouldUseNiceLabelsForX: aBool.
	self shouldUseNiceLabelsForY: aBool.
]

{ #category : #accessing }
RTGrapher >> shouldUseNiceLabelsForX: aBool [
	shouldUseNiceLabelsForX := aBool
]

{ #category : #accessing }
RTGrapher >> shouldUseNiceLabelsForY: aBool [
	shouldUseNiceLabelsForY := aBool
]
