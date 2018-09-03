Class {
	#name : #GTADelayedExitCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #'as yet unclassified' }
GTADelayedExitCommand >> clean [
	self session removeHasDelayedExit
]

{ #category : #'as yet unclassified' }
GTADelayedExitCommand >> execute [
	| close nextToLast |
	self session last isCloseSpotter ifFalse: [ ^ self ].
	close := self session last dateAndTimeWithFixedTimeZone.
	nextToLast := self session nextToLast dateAndTimeWithFixedTimeZone.
	close - nextToLast < 1 minute ifTrue: [ ^ self ].
	self session setHasDelayedExit
]
