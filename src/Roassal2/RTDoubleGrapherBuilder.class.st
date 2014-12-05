Class {
	#name : #RTDoubleGrapherBuilder,
	#superclass : #RTAbstractGrapherBuilder,
	#instVars : [
		'rightDataSets'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #'as yet unclassified' }
RTDoubleGrapherBuilder >> addRight: aDataSet [
	"Essential method. Add a dataset into the grapher. Only non-empty set are considered"
	aDataSet numberOfPoints = 0 ifTrue: [ ^ self ].
	
	rightDataSets add: aDataSet.
	aDataSet builder: self
]

{ #category : #'as yet unclassified' }
RTDoubleGrapherBuilder >> axisYRight [
	| centralPoint |
	self checkIfDataSetHaveBeenAdded.
	self computeMinAndMax.
	centralPoint := self extent x @ self centralPoint y.
	self axisConfiguration
		positionLabel: [ :aLabel :aTick | aLabel translateTo: aTick position + (40 @ 0) ];
		minValue:
				(self minYRight > 0
						ifTrue: [ 0 ]
						ifFalse: [ self minYRight ]);
		maxValue: self maxYRight.
	axisConfiguration axisFrom: centralPoint x @ 0 to: centralPoint x @ extent y negated
]

{ #category : #'as yet unclassified' }
RTDoubleGrapherBuilder >> computeMinAndMaxForX [
	super computeMinAndMaxForX.
	rightDataSets do: #computeMinAndMaxForX
]

{ #category : #'as yet unclassified' }
RTDoubleGrapherBuilder >> computeMinAndMaxForY [
	super computeMinAndMaxForY.
	rightDataSets do: #computeMinAndMaxForY
]

{ #category : #initialization }
RTDoubleGrapherBuilder >> initialize [
	super initialize.
	
	"Collection of data sets"
	rightDataSets := OrderedCollection new.
	
	
]

{ #category : #'as yet unclassified' }
RTDoubleGrapherBuilder >> maxYRight [
	^ (rightDataSets collect: #maxY) max
]

{ #category : #'as yet unclassified' }
RTDoubleGrapherBuilder >> minYRight [
	self assert: [ rightDataSets notEmpty ] description: 'You need to specify at least one data set for the right axis'.
	^ (rightDataSets collect: #minY) min
]

{ #category : #'as yet unclassified' }
RTDoubleGrapherBuilder >> renderIn: aView [
	super renderIn: aView.
	rightDataSets do: [ :aDataset | aDataset renderIn: aView ]
]
