Class {
	#name : #TRMouseDragging,
	#superclass : #TREvent,
	#instVars : [
		'step'
	],
	#category : #Trachel
}

{ #category : #public }
TRMouseDragging class >> step: aStepAsPoint [
	^ self new step: aStepAsPoint
]

{ #category : #initialization }
TRMouseDragging >> initialize [
	super initialize.
	step := 0 @ 0
]

{ #category : #accessing }
TRMouseDragging >> step [
	^ step
]

{ #category : #accessing }
TRMouseDragging >> step: aPoint [
	step := aPoint
]
