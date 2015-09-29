"
A RTNopAnimation simply wait. This is useful to temporize
"
Class {
	#name : #RTNopAnimation,
	#superclass : #RTAnimation,
	#instVars : [
		'animatedValue',
		'trachelCanvas',
		'blockToExecute'
	],
	#category : #'Roassal2-Animation'
}

{ #category : #actions }
RTNopAnimation >> addedIn: aTrachelCanvas [
	trachelCanvas := aTrachelCanvas
]

{ #category : #accessing }
RTNopAnimation >> blockToExecute [
	^ blockToExecute
]

{ #category : #accessing }
RTNopAnimation >> blockToExecute: aZeroArgBlock [
	blockToExecute := aZeroArgBlock
]

{ #category : #testing }
RTNopAnimation >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #'as yet unclassified' }
RTNopAnimation >> initialize [
	super initialize.
	blockToExecute := [  ]
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
							evaluator: [ :t | blockToExecute value ];
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
