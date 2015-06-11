Class {
	#name : #GTALinkCloseWithSelectionCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #execute }
GTALinkCloseWithSelectionCommand >> clean [
	| close |
	close := self session last.
	close isCloseSpotter ifFalse: [ ^ self ].
	close removeSelectedElementEvent.
]

{ #category : #execute }
GTALinkCloseWithSelectionCommand >> execute [
	| close |
	close := self session last.
	close isCloseSpotter ifFalse: [ ^ self session bookmarkIt: 'The last event should be ActOn or Exit.' ].
	self session reverseDo: [ :eachEvent |
		eachEvent isUserSelectionClass ifTrue: [
			close selectedElementEvent: eachEvent.
			^ self ] ].
]
