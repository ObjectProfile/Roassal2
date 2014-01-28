Class {
	#name : #RTResizeMove,
	#superclass : #RTAnimation,
	#instVars : [
		'originalExtent',
		'animatedValue'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTResizeMove >> after: aBlock [
	animatedValue finishCallback: aBlock
]

{ #category : #'as yet unclassified' }
RTResizeMove >> hasCompleted [
	^ animatedValue hasCompleted
]

{ #category : #'as yet unclassified' }
RTResizeMove >> refresh [
	| t |
	t := animatedValue value.
	element trachelShape extent: t.
	element trachelShape resetPath.
	element trachelShape canvas signalUpdate.
]

{ #category : #'as yet unclassified' }
RTResizeMove >> start [
	animatedValue start
]

{ #category : #'as yet unclassified' }
RTResizeMove >> toExtent: toExtent on: anElement [
	
	element := anElement.
	originalExtent := anElement trachelShape extent.
	animatedValue := VIAnimatedValue new
									evaluator: [ :t | originalExtent interpolateTo: toExtent at: t ];
									timer: (VITimer new cycleLength: 1);
									yourself.
	
]
