Class {
	#name : #GTAActivityBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Tests'
}

{ #category : #accessing }
GTAActivityBuilderTest >> session1 [
	^ GTASessionExamples session1
]

{ #category : #running }
GTAActivityBuilderTest >> setUp [
	super setUp.
	builder := GTAActivityBuilder new.
]

{ #category : #tests }
GTAActivityBuilderTest >> testBuild [
	| events |
	events := GTASession new.
	GTSpotterRecorderEvent allSubclassesDo: [ :eachClass |
		events add: eachClass new.
	].
	builder events: events.
	builder build.
	builder view.
]

{ #category : #tests }
GTAActivityBuilderTest >> testBuildSession1 [
	| events |
	events := self session1.
	builder
		events: events;
		analyze;
		withEdges.
	builder interaction 
		popupText: #asEventAnalysisString;
		draggable.
	builder build.
	"builder view inspect."
]
