Class {
	#name : #GTADiveInLevelCommand,
	#superclass : #GTACommand,
	#instVars : [
		'dives'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTADiveInLevelCommand class >> analysisOrder [
	^ 1
]

{ #category : #execute }
GTADiveInLevelCommand >> clean [
	self session do: [ :eachEvent |
		eachEvent
			removeDiveInEvent;
			removeSameLevelEvents ]
]

{ #category : #execute }
GTADiveInLevelCommand >> execute [
	self session do: [ :eachEvent |
		eachEvent isDiveIn ifTrue: [ self updateDiveIn: eachEvent ].
		eachEvent isDiveOut ifTrue: [ self updateDiveOut: eachEvent ].
		eachEvent isDive ifFalse: [ self updateEvent: eachEvent ].
	]
]

{ #category : #initialization }
GTADiveInLevelCommand >> initialize [
	super initialize.
	dives := OrderedCollection new
]

{ #category : #update }
GTADiveInLevelCommand >> updateDiveIn: anEvent [
	self updateEvent: anEvent.
	dives add: anEvent.

]

{ #category : #update }
GTADiveInLevelCommand >> updateDiveOut: anEvent [
	dives ifEmpty: [ ^ anEvent markAsStrange: 'Dive-Out before Dive-In.' ].
	self updateEvent: anEvent.
	dives removeLast 
]

{ #category : #update }
GTADiveInLevelCommand >> updateEvent: anEvent [
	dives ifEmpty: [ ^ self ].
	anEvent diveInEvent: dives last.
	dives last addSameLevelEvent: anEvent.

]
