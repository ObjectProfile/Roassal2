Class {
	#name : #GTAPreviousEventCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #execute }
GTAPreviousEventCommand >> clean [
	self session do: [ :eachEvent | eachEvent removePreviousEvent ]
]

{ #category : #execute }
GTAPreviousEventCommand >> execute [
	| previousEvent |
	self session size < 2 ifTrue: [ ^ self ].
	previousEvent := self session first.
	self session allButFirstDo: [ :eachEvent |
		eachEvent previousEvent: previousEvent. 
		previousEvent := eachEvent ]
]
