Class {
	#name : #RTLinearMove,
	#superclass : #RTAnimation,
	#instVars : [
		'animatedValue'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTLinearMove class >> to: endPoint during: milliseconds on: shape [
	^ self new to: endPoint during: milliseconds on: shape
]

{ #category : #'as yet unclassified' }
RTLinearMove >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #'as yet unclassified' }
RTLinearMove >> refresh [
	element translateTo: animatedValue value
]

{ #category : #'as yet unclassified' }
RTLinearMove >> start [
	animatedValue start
]

{ #category : #'as yet unclassified' }
RTLinearMove >> to: anEndPoint during: seconds on: anElement [
	| position |
	element := anElement.
	
	position := anElement position.
	animatedValue := VIAnimatedValue new
							evaluator: [ :t | position interpolateTo: anEndPoint at: (t) ];
							timer: (VITimer new cycleLength: seconds);
							yourself.
	
]
