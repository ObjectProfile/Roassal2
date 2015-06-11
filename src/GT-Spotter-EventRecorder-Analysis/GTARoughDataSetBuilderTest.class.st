Class {
	#name : #GTARoughDataSetBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Tests'
}

{ #category : #accessing }
GTARoughDataSetBuilderTest >> dateAndTimes [
	^ OrderedCollection new
		add: (DateAndTime year: 2015 month: 01 day: 02);
		add: (DateAndTime year: 2015 month: 01 day: 03);
		add: (DateAndTime year: 2015 month: 01 day: 05);
		add: (DateAndTime year: 2015 month: 01 day: 14);
		add: (DateAndTime year: 2015 month: 02 day: 07);
		add: (DateAndTime year: 2015 month: 02 day: 10);
		add: (DateAndTime year: 2015 month: 02 day: 15);
		add: (DateAndTime year: 2015 month: 03 day: 30);
		yourself
]

{ #category : #private }
GTARoughDataSetBuilderTest >> session: aCollection offset: aDuration [ 
	aCollection do: [ :eachEvent |
		eachEvent offset: aDuration
	 ].
	^ aCollection
]

{ #category : #accessing }
GTARoughDataSetBuilderTest >> sessions [
	^ OrderedCollection new
		add: (self session: GTASessionExamples session1 offset: -30 days);
		add: (self session: GTASessionExamples session1 offset: -28 days);
		add: (self session: GTASessionExamples session1 offset: -15 days);
		add: (self session: GTASessionExamples session1 offset: -5 days);
		add: (self session: GTASessionExamples session1 offset: -1 days);
		yourself
]

{ #category : #running }
GTARoughDataSetBuilderTest >> setUp [
	super setUp.
	builder := GTARoughDataSetBuilder new.
]

{ #category : #tests }
GTARoughDataSetBuilderTest >> testBuild [
	| objects |
	objects := #(0 1 2 3   13 15 17   23   29 30).
	builder
		objects: objects;
		gap: 5;
		build.
	self assert: builder numberOfGroups equals: 4.
	self assert: builder groups first size equals: 4.
	self assert: builder groups second size equals: 3.
	self assert: builder groups third size equals: 1.
	self assert: builder groups fourth size equals: 2.
	self assert: builder groups first asArray equals: #(0 1 2 3).
	self assert: builder groups second asArray equals: #(13 15 17).
	self assert: builder groups third asArray equals: #(23).
	self assert: builder groups fourth asArray equals: #(29 30).
]

{ #category : #tests }
GTARoughDataSetBuilderTest >> testBuildDateAndTimes [
	| objects |
	objects := self dateAndTimes.
	builder
		objects: objects;
		gap: 2 weeks;
		build.
	self assert: builder numberOfGroups equals: 3.
	self assert: builder groups first size equals: 4.
	self assert: builder groups second size equals: 3.
	self assert: builder groups third size equals: 1.

]

{ #category : #tests }
GTARoughDataSetBuilderTest >> testBuildSessions [
	| objects |
	objects := self sessions.
	builder
		objects: objects;
		gap: 1 week;
		setSessionComparator;
		groupClass: GTASomeSessions;
		build.
	self assert: builder numberOfGroups equals: 3.
	self assert: builder groups first size equals: 2.
	self assert: builder groups second size equals: 1.
	self assert: builder groups third size equals: 2.
	self assert: (builder groups allSatisfy: [ :eachGroup | eachGroup class = GTASomeSessions ]).

]

{ #category : #tests }
GTARoughDataSetBuilderTest >> testBuildSessions2 [
	| objects |
	objects := self sessions.
	builder
		objects: objects;
		gap: 1 week;
		setSessionComparator;
		newGroupBlock: [ GTASomeSessions new ];
		build.
	self assert: builder numberOfGroups equals: 3.
	self assert: builder groups first size equals: 2.
	self assert: builder groups second size equals: 1.
	self assert: builder groups third size equals: 2.
	self assert: (builder groups allSatisfy: [ :eachGroup | eachGroup class = GTASomeSessions ]).

]
