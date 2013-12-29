Class {
	#name : #RTNopAnimation,
	#superclass : #RTAnimation,
	#instVars : [
		'animatedValue',
		'trachelCanvas'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTNopAnimation >> addedIn: aTrachelCanvas [
	trachelCanvas := aTrachelCanvas
]

{ #category : #accessing }
RTNopAnimation >> after: aBlock [
	animatedValue finishCallback: aBlock
]

{ #category : #testing }
RTNopAnimation >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #actions }
RTNopAnimation >> refresh [
	animatedValue value
]

{ #category : #'waiting-specific' }
RTNopAnimation >> start [
	animatedValue start.
	trachelCanvas signalUpdate
]

{ #category : #'waiting-specific' }
RTNopAnimation >> waitFor: seconds [
	animatedValue := VIAnimatedValue new
							evaluator: [ :t | ];
							timer: (VITimer new cycleLength: seconds);
							yourself.
	
]
