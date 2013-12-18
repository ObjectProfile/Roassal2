Class {
	#name : #TRMouseDragging,
	#superclass : #TREvent,
	#instVars : [
		'step'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRMouseDragging >> initialize [
	super initialize.
	step := 0 @ 0
]

{ #category : #'as yet unclassified' }
TRMouseDragging >> step [
	^ step
]

{ #category : #'as yet unclassified' }
TRMouseDragging >> step: aPoint [
	step := aPoint
]
