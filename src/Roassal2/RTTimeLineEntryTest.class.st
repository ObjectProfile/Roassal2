"
A RTTimeLineEntryTest is a test class for testing the behavior of RTTimeLineEntry
"
Class {
	#name : #RTTimeLineEntryTest,
	#superclass : #TestCase,
	#category : #'Roassal2-Builder-TimeLine-Tests'
}

{ #category : #tests }
RTTimeLineEntryTest >> testBasic [

	| entry |
	entry := RTTimeLineEntry new.
	self assert: entry start equals: 0.
	self assert: entry duration equals: 0.
]
