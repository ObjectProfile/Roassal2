Class {
	#name : #PCPPSegment,
	#superclass : #PCPPObject,
	#instVars : [
		'callId',
		'id'
	],
	#category : #ProfilerCPP
}

{ #category : #'as yet unclassified' }
PCPPSegment class >> annotation [
	<MSEClass: #PCPPSegment super: #PCPPObject>
	<package: #ProfilerCPP>
	^ self

]

{ #category : #accessing }
PCPPSegment >> callId [
	^ callId
]

{ #category : #accessing }
PCPPSegment >> callId: anObject [
	callId := anObject
]

{ #category : #accessing }
PCPPSegment >> id [
	^ id
]

{ #category : #accessing }
PCPPSegment >> id: anObject [
	id := anObject
]
