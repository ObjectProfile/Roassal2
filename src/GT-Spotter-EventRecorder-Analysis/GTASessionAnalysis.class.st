Class {
	#name : #GTASessionAnalysis,
	#superclass : #Object,
	#instVars : [
		'session'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #api }
GTASessionAnalysis class >> executeOn: aGTSpotterSession [
	^ (self session: aGTSpotterSession) execute
]

{ #category : #'instance creation' }
GTASessionAnalysis class >> session: aGTSpotterSession [ 
	^ self new session: aGTSpotterSession; yourself
]

{ #category : #api }
GTASessionAnalysis class >> updateOn: aGTSpotterSession [
	^ (self session: aGTSpotterSession) clean; execute
]

{ #category : #execute }
GTASessionAnalysis >> analyze: aCollection [ 
	self 
		session: aCollection;
		clean; 
		execute
]

{ #category : #execute }
GTASessionAnalysis >> clean [
	(GTACommand allSubclasses 
		sort: [ :a :b | a analysisOrder < b analysisOrder ]) 
			do: [ :each | | command |
				command := each context: self.
				command clean ].
	^ self session
]

{ #category : #execute }
GTASessionAnalysis >> execute [
	(GTACommand allSubclasses 
		sort: [ :a :b | a analysisOrder < b analysisOrder ]) 
			do: [ :each | | command |
				command := each context: self.
				command execute ].
	^ self session
]

{ #category : #accessing }
GTASessionAnalysis >> session [
	^ session
]

{ #category : #accessing }
GTASessionAnalysis >> session: anObject [
	session := anObject
]
