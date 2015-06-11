Class {
	#name : #GTADirectSessionCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTADirectSessionCommand class >> analysisOrder [
	^ GTAEmptySessionCommand analysisOrder + 1
]

{ #category : #execute }
GTADirectSessionCommand >> clean [
	self session removeIsDirectSession.
]

{ #category : #execute }
GTADirectSessionCommand >> execute [
	self session hasDelayedExit ifTrue: [ ^ self ].
	self session isEmptySession ifTrue: [ ^ self ].
	self session numberOfDivesIn = 0 ifFalse: [ ^ self ].
	self session setDirectSession.
]
