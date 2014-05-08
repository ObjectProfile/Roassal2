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

{ #category : #testing }
RTAbstractZoomMove >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #'instance creation' }
RTAbstractZoomMove >> on: view [

	^ self on: view during: 0.5
]

{ #category : #public }
RTAbstractZoomMove >> on: view during: seconds [
	| initialScale |
	initialScale := view canvas camera scale.
	trachelCanvas := view canvas.
	animatedValue := VIAnimatedValue new
							evaluator: [ :t | initialScale interpolateTo: (initialScale + self step ) at: t ];
							timer: (VITimer new cycleLength: seconds);
							yourself.
	


]

{ #category : #refreshing }
RTAbstractZoomMove >> refresh [
	trachelCanvas camera scale: animatedValue value.
	trachelCanvas signalUpdate
]

{ #category : #actions }
RTAbstractZoomMove >> start [
	animatedValue start.
	trachelCanvas signalUpdate
]

{ #category : #'stepping and presenter' }
RTAbstractZoomMove >> step [
	self subclassResponsibility 
]
