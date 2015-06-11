Class {
	#name : #GTASameTimestampCommand,
	#superclass : #GTACommand,
	#instVars : [
		'timestamp',
		'events'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTASameTimestampCommand class >> analysisOrder [
	^ GTALinkToSessionCommand analysisOrder + 1
]

{ #category : #adding }
GTASameTimestampCommand >> addEvent: aSpotterEvent [ 
	events ifNil: [ events := OrderedCollection new ].
	events addLast: aSpotterEvent
]

{ #category : #execute }
GTASameTimestampCommand >> clean [
	self session do: [ :event | event removeSameTimeEvents ]
]

{ #category : #adding }
GTASameTimestampCommand >> consolidateEvents: aDateAndTime [ 
	events ifNil: [ ^ self ].
	events withIndexDo: [ :event :index |
		event sameTimeEvents: events index: index nextDateAndTime: aDateAndTime ].
	events := nil.
]

{ #category : #execute }
GTASameTimestampCommand >> execute [
	| eventTimestamp |
	self session do: [ :eachEvent | 
		eventTimestamp := eachEvent dateAndTimeWithFixedTimeZone.
		timestamp 
			ifNil: [ 
				timestamp := eventTimestamp.
				self addEvent: eachEvent. ]
			ifNotNil: [ 
				timestamp = eventTimestamp 
					ifTrue: [ self addEvent: eachEvent ] 
					ifFalse: [ self consolidateEvents: eventTimestamp.
						timestamp := eventTimestamp.
						self addEvent: eachEvent. ] ]
		 ].
	self consolidateEvents: eventTimestamp
]
