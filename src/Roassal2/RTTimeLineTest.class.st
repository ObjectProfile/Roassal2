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
RTTimeLineTest >> testDoublePopup [

	| b entry view e announcer |
	b := RTTimeLine new.

	entry := RTTimeLineEntry new start: 0; end: 5; identifier: 1.
	b addEntry: entry.
	b addEntry: (RTTimeLineEntry new start: 5; end: 10; identifier: 2).

	self assert: b interaction numberOfMenuEntries equals: 1.
	b interaction popupText: #identifier.
	self assert: b interaction numberOfMenuEntries equals: 1.
	b build.
	view := b view.
	
	e := view elementFromModel: entry.
	self assert: e notNil.
	
	self assert: (e hasInteraction: RTPopup).
	
	announcer := e announcer.
	self assert: announcer numberOfSubscriptions equals: 3
]

{ #category : #tests }
RTTimeLineTest >> testEmptyTimeline [

	self assert: timeline numberOfEntries equals: 0.
	self assert: timeline numberOfTimeLines equals: 0.
]
