Class {
	#name : #RTLinearMove,
	#superclass : #RTAnimation,
	#instVars : [
		'animatedValue'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTLinearMove class >> to: endPoint during: seconds on: shape [
	^ self new to: endPoint during: seconds on: shape
]

{ #category : #testing }
RTLinearMove >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #refreshing }
RTLinearMove >> refresh [
	element translateTo: animatedValue value.
	element view canvas signalUpdate.
]

{ #category : #accessing }
RTLinearMove >> start [
	animatedValue start
]

{ #category : #public }
RTLinearMove >> to: anEndPoint during: seconds on: anElement [
	| position |
	element := anElement.
	
	position := anElement position.
	animatedValue := VIAnimatedValue new
							evaluator: [ :t | position interpolateTo: anEndPoint at: t ];
							timer: (VITimer new cycleLength: seconds);
							yourself.
	
]
