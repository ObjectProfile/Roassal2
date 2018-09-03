Class {
	#name : #GTACommand,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTACommand class >> analysisOrder [
	^ 100
]

{ #category : #'instance creation' }
GTACommand class >> context: aGTSpotterSession [ 
	^ self new context: aGTSpotterSession; yourself
]

{ #category : #execute }
GTACommand >> clean [
	self subclassResponsibility
]

{ #category : #accessing }
GTACommand >> context [
	^ context
]

{ #category : #accessing }
GTACommand >> context: anObject [
	context := anObject
]

{ #category : #execute }
GTACommand >> execute [
	self subclassResponsibility
]

{ #category : #accessing }
GTACommand >> session [
	^ self context session
]
