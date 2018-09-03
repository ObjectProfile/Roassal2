Class {
	#name : #GTALinkToSessionCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTALinkToSessionCommand class >> analysisOrder [
	^ 1
]

{ #category : #execute }
GTALinkToSessionCommand >> clean [
	self session do: [ :eachEvent |
		eachEvent removeSession ]
]

{ #category : #execute }
GTALinkToSessionCommand >> execute [
	self session do: [ :eachEvent |
		eachEvent session: self session ]
]
