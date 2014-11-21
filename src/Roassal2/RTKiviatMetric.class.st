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

{ #category : #accessing }
RTKiviatMetric >> block: aOneArgBlock [
	modelBlock := aOneArgBlock 
]

{ #category : #private }
RTKiviatMetric >> defaultMaxSize [
	maxSize := 200
]

{ #category : #default }
RTKiviatMetric >> defaultModelBlock [
	self block: [ :v | (v@0) ].
]

{ #category : #initialization }
RTKiviatMetric >> initialize [
	super initialize.
	self defaultModelBlock.
	self defaultMaxSize.
	maxValue := 0.
	minValue := 0.
]

{ #category : #accessing }
RTKiviatMetric >> maxSize [
	^ maxSize
]

{ #category : #accessing }
RTKiviatMetric >> maxSize: aNumber [
	maxSize := aNumber.
]

{ #category : #accessing }
RTKiviatMetric >> maxValue [
	^ maxValue.
]

{ #category : #accessing }
RTKiviatMetric >> maxValue: aNumber [
	maxValue := aNumber.
]

{ #category : #accessing }
RTKiviatMetric >> minValue [
	^ minValue.
]

{ #category : #accessing }
RTKiviatMetric >> minValue: aNumber [
	minValue := aNumber.
]

{ #category : #accessing }
RTKiviatMetric >> modelBlock [
	^ modelBlock
]
