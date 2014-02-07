Class {
	#name : #RTNopAnimation,
	#superclass : #RTAnimation,
	#instVars : [
		'animatedValue',
		'trachelCanvas'
	],
	#category : #'Roassal2-Core'
}

{ #category : #actions }
RTNopAnimation >> addedIn: aTrachelCanvas [
	trachelCanvas := aTrachelCanvas
]

{ #category : #testing }
RTNopAnimation >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #actions }
RTNopAnimation >> refresh [
	animatedValue value.
	trachelCanvas signalUpdate
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

{ #category : #'waiting-specific' }
RTNopAnimation >> waitFor: seconds after: aBlock [
	animatedValue := VIAnimatedValue new
							evaluator: [ :t | ];
							finishCallback: aBlock;
							timer: (VITimer new cycleLength: seconds);
							yourself.
	
]
