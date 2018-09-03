Class {
	#name : #GTAEmptySessionCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTAEmptySessionCommand class >> analysisOrder [
	^ GTADelayedExitCommand analysisOrder + 1
]

{ #category : #execute }
GTAEmptySessionCommand >> clean [
	self session removeIsEmptySession
]

{ #category : #execute }
GTAEmptySessionCommand >> execute [
	| displayed |
	self session hasDelayedExit ifTrue: [ ^ self ].
	self session ifEmpty: [ ^ self setEmpty ].
	self session last isActOn ifTrue: [ ^ self ].
	displayed := (self session select: #isForTimelineView).
	displayed size > 3 ifTrue: [ ^ self ].
	self setEmpty.
]

{ #category : #api }
GTAEmptySessionCommand >> setEmpty [
	self session setIsEmptySession
]
