Class {
	#name : #RTRotationMove,
	#superclass : #RTAnimation,
	#instVars : [
		'animatedValue'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTRotationMove class >> angle: anAngle during: seconds on: shape [
	^ self new angle: anAngle during: seconds on: shape
]

{ #category : #public }
RTRotationMove >> angle: anAngle during: seconds on: anElement [
	|currentAngle|
	element := anElement.
	currentAngle := element trachelShape angle.
	animatedValue := VIAnimatedValue new
							evaluator: [ :t | currentAngle interpolateTo: anAngle at: t ];
							timer: (VITimer new cycleLength: seconds);
							yourself.
]

{ #category : #testing }
RTRotationMove >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #refreshing }
RTRotationMove >> refresh [
	element trachelShape rotateToDegrees: animatedValue value.
	element update.
]

{ #category : #actions }
RTRotationMove >> start [
	animatedValue start
]
