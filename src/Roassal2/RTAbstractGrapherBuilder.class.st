Class {
	#name : #RTAbstractGrapherBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'extent',
		'axisConfiguration',
		'datasets',
		'plugins',
		'axisX',
		'axisY'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #adding }
RTAbstractGrapherBuilder >> add: aDataSet [
	"Essential method. Add a dataset into the grapher. Only non-empty set are considered"
	aDataSet numberOfPoints = 0 ifTrue: [ ^ self ].
	
	datasets add: aDataSet.
	aDataSet builder: self
]

{ #category : #adding }
RTAbstractGrapherBuilder >> addPlugin: aPlugin [
	"Add a plugin"
	plugins add: aPlugin
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> axisConfiguration [
	"Return an instance of RTAxisConfiguration. This method is useful to let a script to particularize the axis"
	axisConfiguration ifNil: [ self resetAxisConfiguration ].
	^ axisConfiguration
]

{ #category : #'private-axis' }
RTAbstractGrapherBuilder >> axisFrom: aPoint to: anotherPoint [
	"Draw the axis from aPoint to anotherPoint"
	axisConfiguration fromPoint: aPoint.
	axisConfiguration toPoint: anotherPoint.
	axisConfiguration axisFrom: aPoint to: anotherPoint.
	self resetAxisConfiguration
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisX [
	| centralPoint |
	self checkIfDataSetHaveBeenAdded.
	self computeMinAndMax.
	centralPoint := self centralPoint.
	self axisConfiguration
		positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ];
		minValue:
				(self minX > 0
						ifTrue: [ 0 ]
						ifFalse: [ self minX ]);
		maxValue: self maxX.
	self axisXFrom: 0 @ centralPoint y to: extent x @ centralPoint y
]

{ #category : #'private-axis' }
RTAbstractGrapherBuilder >> axisXFrom: aPoint to: anotherPoint [
	"Draw the axis from aPoint to anotherPoint"
	axisX := axisConfiguration.
	self axisFrom: aPoint to: anotherPoint.
	

]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisXNoLabel [
	| centralPoint |
	self checkIfDataSetHaveBeenAdded.
	self computeMinAndMax.
	axisConfiguration := RTAxisConfiguration new
					builder: self;
					numberOfTicks: 0;
					numberOfLabels: 0.
	centralPoint := self centralPoint.
	self axisXFrom: 0 @ centralPoint y to: extent x @ centralPoint y
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisXTitled: aTitle [
	self axisConfiguration title: aTitle.
	self axisX
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisXWithNumberOfTicks: nbOfTicks [
	| centralPoint |
	self checkIfDataSetHaveBeenAdded.
	self computeMinAndMax.
	axisConfiguration := RTAxisConfiguration new
					builder: self;
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((self minX > 0) ifTrue: [ 0 ] ifFalse: [ self minX ]);
					maxValue: self maxX;
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ].
	centralPoint := self centralPoint.
	self axisXFrom: 0 @ centralPoint y to: extent x @ centralPoint y
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisY [
	| centralPoint |
	self checkIfDataSetHaveBeenAdded.
	self computeMinAndMax.
	centralPoint := self centralPoint.
	self axisConfiguration
		positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (40 @ 0) ];
		minValue:
				(self minY > 0
						ifTrue: [ 0 ]
						ifFalse: [ self minY ]);
		maxValue: self maxY.
	self axisYFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
]

{ #category : #'private-axis' }
RTAbstractGrapherBuilder >> axisYFrom: aPoint to: anotherPoint [
	"Draw the axis from aPoint to anotherPoint"
	axisY := axisConfiguration.
	self axisFrom: aPoint to: anotherPoint.
	

]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisYTitled: aTitle [
	self axisConfiguration title: aTitle.
	self axisY
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisYWithNumberOfTicks: nbOfTicks [
	| centralPoint |
	self checkIfDataSetHaveBeenAdded.
	self computeMinAndMax.
	axisConfiguration := RTAxisConfiguration new
					builder: self;
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((self minY > 0) ifTrue: [ 0 ] ifFalse: [ self minY ]);
					maxValue: self maxY;
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (40 @ 0) ].
	centralPoint := self centralPoint.
	self axisYFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
]

{ #category : #utility }
RTAbstractGrapherBuilder >> centralPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self getPixelPositionOf: 0 @ 0
]

{ #category : #utility }
RTAbstractGrapherBuilder >> checkIfDataSetHaveBeenAdded [
	datasets ifEmpty: [ self error: 'No dataset has been added?' ]
]

{ #category : #'min and max' }
RTAbstractGrapherBuilder >> computeMinAndMax [
	self computeMinAndMaxForX.
	self computeMinAndMaxForY.
	self homogenizeMinAndMax
]

{ #category : #'min and max' }
RTAbstractGrapherBuilder >> computeMinAndMaxForX [
	datasets do: #computeMinAndMaxForX
]

{ #category : #'min and max' }
RTAbstractGrapherBuilder >> computeMinAndMaxForY [
	datasets do: #computeMinAndMaxForY
]

{ #category : #hooks }
RTAbstractGrapherBuilder >> createView [
	^ RTView new @ RTDraggableView
]

{ #category : #utility }
RTAbstractGrapherBuilder >> defineAxesIfNecessary [
	
	self isXAxisDefined ifFalse: [ self axisX ].
	self isYAxisDefined ifFalse: [ self axisY ].
	
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> extent [
	^ extent
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> extent: aPoint [
	"Set the size of the graph"
	extent := aPoint
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> getAxisX [
	^ axisX
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> getAxisY [
	^ axisY
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> getMaxNumberOfPoints [
	"Return the maximum number of points any of the dataset has."
	^ datasets inject: 0 into: [ :max :ds | max max: ds numberOfPoints ]
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> getPixelPositionOf: aPoint [
	"Return the position in pixel in the View for a given data point"
	^ datasets first getPixelPositionOf: aPoint
]

{ #category : #'min and max' }
RTAbstractGrapherBuilder >> homogenizeMinAndMax [
	| minX maxX minY maxY |
	minX := self minX.
	maxX := self maxX.
	minY := self minY.
	maxY := self maxY.
	datasets do: [ :ds |
		ds minX: minX.
		ds minY: minY.
		ds maxX: maxX.
		ds maxY: maxY. ]
]

{ #category : #initialization }
RTAbstractGrapherBuilder >> initialize [
	super initialize.
	extent := 100 @ 100.
	
	"Collection of data sets"
	datasets := OrderedCollection new.
	
	"Collection of plugins"
	plugins := OrderedCollection new.

]

{ #category : #testing }
RTAbstractGrapherBuilder >> isXAxisDefined [
	"Return true is X axis has been defined"
	^ axisX notNil
]

{ #category : #testing }
RTAbstractGrapherBuilder >> isYAxisDefined [
	"Return true is X axis has been defined"
	^ axisY notNil
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> maxX [
	^ (datasets collect: #maxX) max
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> maxY [
	^ (datasets collect: #maxY) max
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> minX [
	^ (datasets collect: #minX) min
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> minY [
	^ (datasets collect: #minY) min
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> newAxisConfiguration [
	"Return an instance of RTAxisConfiguration. This method is useful to let a script to particularize the axis"
	self resetAxisConfiguration.
	^ self axisConfiguration
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> numberOfDataSets [
	^ datasets size
]

{ #category : #utility }
RTAbstractGrapherBuilder >> renderAllPlugins [
	plugins do: [ :aPlugin | aPlugin builder: self; render ]
]

{ #category : #hooks }
RTAbstractGrapherBuilder >> renderIn: aView [
	self defineAxesIfNecessary.
	datasets do: [ :aDataset | aDataset renderIn: aView ].
	self renderAllPlugins
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> resetAxisConfiguration [
	axisConfiguration := RTAxisConfiguration new.
	axisConfiguration builder: self
]
