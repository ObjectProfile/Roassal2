Class {
	#name : #RTAbstractZoomMove,
	#superclass : #RTAnimation,
	#instVars : [
		'animatedValue',
		'trachelCanvas'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTAbstractZoomMove class >> on: aView [
	aView addAnimation: (self new on: aView)
]

{ #category : #'as yet unclassified' }
RTAbstractZoomMove >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #'as yet unclassified' }
RTAbstractZoomMove >> on: view [

	^ self on: view during: 0.5
]

{ #category : #'as yet unclassified' }
RTAbstractZoomMove >> on: view during: seconds [
	| initialScale |
	initialScale := view canvas camera scale.
	trachelCanvas := view canvas.
	animatedValue := VIAnimatedValue new
							evaluator: [ :t | initialScale interpolateTo: (initialScale + self step ) at: t ];
							timer: (VITimer new cycleLength: seconds);
							yourself.
	


]

{ #category : #'as yet unclassified' }
RTAbstractZoomMove >> refresh [
	trachelCanvas camera scale: animatedValue value.
	trachelCanvas signalUpdate
]

{ #category : #'as yet unclassified' }
RTAbstractZoomMove >> start [
	animatedValue start.
	trachelCanvas signalUpdate
]

{ #category : #'as yet unclassified' }
RTAbstractZoomMove >> step [
	self subclassResponsibility 
]
