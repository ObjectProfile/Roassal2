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

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> initialize [
	super initialize.
	labelConvertion := [ :number | number asFloat round: 2 ].
	positionLabel := [ :aLabel :aTick | aLabel translateTo: aTick position ].
	numberOfTicks := 4.
	numberOfLabels := 4.
	minValue := 0.
	maxValue := 0
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> labelConvertion [
	^ labelConvertion
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> labelConvertion: aValue [
	labelConvertion := aValue
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> maxValue [
	^ maxValue
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> maxValue: aMinValue [
	maxValue := aMinValue
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> minValue [
	^ minValue
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> minValue: aMinValue [
	minValue := aMinValue
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> moveLabel: label againstTick: aTick [
	positionLabel value: label value: aTick
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> numberOfLabels [
	^ numberOfLabels
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> numberOfLabels: aValue [
	numberOfLabels := aValue
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> numberOfTicks [
	^ numberOfTicks
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> numberOfTicks: aValue [
	numberOfTicks := aValue
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> positionLabel [
	^ positionLabel
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> positionLabel: aValue [
	positionLabel := aValue
]

{ #category : #'as yet unclassified' }
RTAxisConfiguration >> tickIntervalForLabel [
	^ numberOfTicks / numberOfLabels
]
