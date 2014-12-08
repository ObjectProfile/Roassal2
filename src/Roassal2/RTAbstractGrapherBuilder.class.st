Class {
	#name : #RTAbstractGrapherBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'extent',
		'axisConfiguration',
		'datasets'
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

{ #category : #testing }
RTAbstractGrapherBuilder >> areAxisDefined [
	"Return true is axis have been defined"
	^ axisConfiguration notNil
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> axisConfiguration [
	"Return an instance of RTAxisConfiguration. This method is useful to let a script to particularize the axis"
	axisConfiguration ifNil: [ self resetAxisConfiguration ].
	^ axisConfiguration
]

{ #category : #utility }
RTAbstractGrapherBuilder >> axisPointFor: aPoint [
	"Return the position in the view to have the 0 @ 0"
	| centralPointX centralPointY diffBetweenMaxAndMin |
	diffBetweenMaxAndMin := self maxX - self minX.
	diffBetweenMaxAndMin = 0 ifTrue: [ 100 ] ifFalse: [ diffBetweenMaxAndMin ].
	centralPointX := aPoint x + ((extent x - aPoint x) * ((aPoint x - self minX) / diffBetweenMaxAndMin )) asInteger.
	centralPointY := aPoint y + ((extent y - aPoint y) * ((aPoint y - self minY) / diffBetweenMaxAndMin)) asInteger.
	^ centralPointX @ centralPointY negated.

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
	axisConfiguration axisFrom: 0 @ centralPoint y to: extent x @ centralPoint y
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisXNoLabel [
	| config centralPoint |
	self checkIfDataSetHaveBeenAdded.
	self computeMinAndMax.
	config := RTAxisConfiguration new
					builder: self;
					numberOfTicks: 0;
					numberOfLabels: 0.
	centralPoint := self centralPoint.
	config axisFrom: 0 @ centralPoint y to: extent x @ centralPoint y
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisXTitled: aTitle [
	self axisConfiguration title: aTitle.
	self axisX
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisXWithNumberOfTicks: nbOfTicks [
	| config centralPoint |
	self checkIfDataSetHaveBeenAdded.
	self computeMinAndMax.
	config := RTAxisConfiguration new
					builder: self;
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((self minX > 0) ifTrue: [ 0 ] ifFalse: [ self minX ]);
					maxValue: self maxX;
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (0 @ 15) ].
	centralPoint := self centralPoint.
	config axisFrom: 0 @ centralPoint y to: extent x @ centralPoint y
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
	axisConfiguration axisFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisYTitled: aTitle [
	self axisConfiguration title: aTitle.
	self axisY
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> axisYWithNumberOfTicks: nbOfTicks [
	| config centralPoint |
	self checkIfDataSetHaveBeenAdded.
	self computeMinAndMax.
	config := RTAxisConfiguration new
					builder: self;
					numberOfTicks: nbOfTicks;
					numberOfLabels: nbOfTicks;
					minValue: ((self minY > 0) ifTrue: [ 0 ] ifFalse: [ self minY ]);
					maxValue: self maxY;
					labelConvertion: [ :number | number asFloat round: 2 ];
					positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position - (40 @ 0) ].
	centralPoint := self centralPoint.
	config axisFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
]

{ #category : #utility }
RTAbstractGrapherBuilder >> centralPoint [
	"Return the position in the view to have the 0 @ 0"
	^ self axisPointFor: 0 @ 0
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
	self areAxisDefined ifTrue: [ ^ self ].
	self axisX; axisY
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> extent [
	^ extent
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> extent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
RTAbstractGrapherBuilder >> getMaxNumberOfPoints [
	"Return the maximum number of points any of the dataset has."
	^ datasets inject: 0 into: [ :max :ds | max max: ds numberOfPoints ]
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

{ #category : #hooks }
RTAbstractGrapherBuilder >> renderIn: aView [
	self defineAxesIfNecessary.
	datasets do: [ :aDataset | aDataset renderIn: aView ]
]

{ #category : #'public-axis' }
RTAbstractGrapherBuilder >> resetAxisConfiguration [
	axisConfiguration := RTAxisConfiguration new.
	axisConfiguration builder: self
]
