Class {
	#name : #GTAGroup,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #accessing }
GTAGroup >> duration [
	^ self end - self start
]

{ #category : #accessing }
GTAGroup >> end [
	^ self last end
]

{ #category : #printing }
GTAGroup >> humanReadablePrintString [
	"Return a String with a human readable representation of me"
	^ String streamContents: [ :out | 
		self printHumanReadableOn: out ]
]

{ #category : #printing }
GTAGroup >> printHumanReadableOn: aStream [
	| duration |
	aStream 
		nextPutAll: (self size pluralize: 'event');
		nextPutAll: ' from '; 
		print: self start asDate; 
		cr;
		nextPutAll: ' during '. 
	duration := self duration.
	self duration > 1 second ifTrue: [ duration := self duration truncateTo: 1 milliseconds ].
	self duration > 1 minute ifTrue: [ duration := self duration truncateTo: 1 second ].
	self duration > 1 hour ifTrue: [ duration := self duration truncateTo: 1 minute ].
	self duration > 1 day ifTrue: [ duration := self duration truncateTo: 1 hour ].
	duration printHumanReadableOn: aStream
]

{ #category : #accessing }
GTAGroup >> start [
	^ self first start
]
