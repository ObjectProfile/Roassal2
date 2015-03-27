Class {
	#name : #PCPPInstruction,
	#superclass : #PCPPObject,
	#instVars : [
		'id',
		'segmentId'
	],
	#category : #ProfilerCPP
}

{ #category : #'as yet unclassified' }
PCPPInstruction class >> annotation [
	<MSEClass: #PCPPInstruction super: #PCPPObject>
	<package: #ProfilerCPP>
	^ self

]

{ #category : #accessing }
PCPPInstruction >> id [
	^ id
]

{ #category : #accessing }
PCPPInstruction >> id: anObject [
	id := anObject
]

{ #category : #accessing }
PCPPInstruction >> segmentId [
	^ segmentId
]

{ #category : #accessing }
PCPPInstruction >> segmentId: anObject [
	segmentId := anObject
]
