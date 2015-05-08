"
A RTTimeLine4SpotterTest is a test class for testing the behavior of RTTimeLine4Spotter
"
Class {
	#name : #RTTimeLineTest,
	#superclass : #TestCase,
	#instVars : [
		'timeline'
	],
	#category : #'Roassal2-Builder-TimeLine-Tests'
}

{ #category : #running }
RTTimeLineTest >> setUp [
	super setUp.
	timeline := RTTimeLine new
]

{ #category : #tests }
RTTimeLineTest >> testEmptyTimeline [

	self assert: timeline numberOfEntries equals: 0.
	self assert: timeline numberOfTimeLines equals: 0.
]
