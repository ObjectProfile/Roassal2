Class {
	#name : #RTAxisConfiguration,
	#superclass : #RTObject,
	#instVars : [
		'numberOfTicks',
		'numberOfLabels',
		'labelConvertion',
		'positionLabel',
		'minValue',
		'maxValue'
	],
	#category : #'Roassal2-Builder-Charter'
}

{ #category : #initialization }
RTAxisConfiguration >> initialize [
	super initialize.
	labelConvertion := [ :number | number asFloat round: 2 ].
	positionLabel := [ :aLabel :aTick | aLabel translateTo: aTick position ].
	numberOfTicks := 4.
	numberOfLabels := 0.
	minValue := 0.
	maxValue := 0
]

{ #category : #accessing }
RTAxisConfiguration >> labelConvertion [
	^ labelConvertion
]

{ #category : #accessing }
RTAxisConfiguration >> labelConvertion: aValue [
	labelConvertion := aValue
]

{ #category : #accessing }
RTAxisConfiguration >> maxValue [
	^ maxValue
]

{ #category : #accessing }
RTAxisConfiguration >> maxValue: aMinValue [
	maxValue := aMinValue
]

{ #category : #accessing }
RTAxisConfiguration >> minValue [
	^ minValue
]

{ #category : #accessing }
RTAxisConfiguration >> minValue: aMinValue [
	minValue := aMinValue
]

{ #category : #action }
RTAxisConfiguration >> moveLabel: label againstTick: aTick [
	positionLabel value: label value: aTick
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfLabels [
	^ numberOfLabels
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfLabels: aValue [
	numberOfLabels := aValue
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfTicks [
	^ numberOfTicks
]

{ #category : #accessing }
RTAxisConfiguration >> numberOfTicks: aValue [
	numberOfTicks := aValue
]

{ #category : #accessing }
RTAxisConfiguration >> positionLabel [
	^ positionLabel
]

{ #category : #accessing }
RTAxisConfiguration >> positionLabel: aValue [
	positionLabel := aValue
]

{ #category : #accessing }
RTAxisConfiguration >> tickIntervalForLabel [
	^ numberOfTicks / numberOfLabels
]
