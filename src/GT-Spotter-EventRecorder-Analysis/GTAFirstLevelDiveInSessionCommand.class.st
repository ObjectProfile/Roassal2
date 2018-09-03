Class {
	#name : #GTAFirstLevelDiveInSessionCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTAFirstLevelDiveInSessionCommand class >> analysisOrder [
	^ GTADirectSessionCommand analysisOrder + 1
]

{ #category : #execute }
GTAFirstLevelDiveInSessionCommand >> clean [
	self session removeIsFirstLevelDiveInSession
]

{ #category : #execute }
GTAFirstLevelDiveInSessionCommand >> execute [
	self session hasDelayedExit ifTrue: [ ^ self ].
	self session isEmptySession ifTrue: [ ^ self ].
	self session isDirectSession ifTrue: [ ^ self ].
	self session deepestDiveIn = 2 ifFalse: [ ^ self ].
	self session setIsFirstLevelDiveInSession.
]
