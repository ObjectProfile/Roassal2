Class {
	#name : #RTKiviatMetric,
	#superclass : #RTObject,
	#instVars : [
		'maxSize',
		'modelBlock',
		'minValue',
		'maxValue'
	],
	#category : #'Roassal2-Builder-Kiviat'
}

{ #category : #'as yet unclassified' }
RTKiviatMetric >> block: aOneArgBlock [
	modelBlock := aOneArgBlock 
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> defaultMaxSize [
	maxSize := 200
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> defaultModelBlock [
	self block: [ :v | (v@0) ].
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> initialize [
	super initialize.
	self defaultModelBlock.
	self defaultMaxSize.
	maxValue := 0.
	minValue := 0.
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> maxSize [
	^ maxSize
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> maxSize: aNumber [
	maxSize := aNumber.
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> maxValue [
	^ maxValue.
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> maxValue: aNumber [
	maxValue := aNumber.
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> minValue [
	^ minValue.
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> minValue: aNumber [
	minValue := aNumber.
]

{ #category : #'as yet unclassified' }
RTKiviatMetric >> modelBlock [
	^ modelBlock
]
