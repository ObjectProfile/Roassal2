Class {
	#name : #GTASomeComputers,
	#superclass : #GTACollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #enumerating }
GTASomeComputers >> categoryLabels [
	^ self flatCollect: #categoryLabels as: OrderedCollection
]

{ #category : #enumerating }
GTASomeComputers >> computerUUIDs [
	^ self collect: #computerUUID as: OrderedCollection
]

{ #category : #accessing }
GTASomeComputers >> computers [
	^ self optionAt: #computers
]

{ #category : #accessing }
GTASomeComputers >> computers: aCollection [ 
	^ self optionAt: #computers put: aCollection
]

{ #category : #'enumerating - computer' }
GTASomeComputers >> computersAndOnlySessionsWithSpecialKeywords [
	^ self 
		select: [ :computer | computer hasSessionsWithSpecialKeywords ]
		thenCollect: [ :computer | 
			computer sessionsWithSpecialKeywords	]
]

{ #category : #enumerating }
GTASomeComputers >> divesIn [
	^ self flatCollect: #divesIn as: OrderedCollection
]

{ #category : #'enumerating - events' }
GTASomeComputers >> flatCollectEvents: aBlock [ 
	^ self flatCollect: [ :eachComputer | eachComputer flatCollectEvents: aBlock ] as: OrderedCollection
]

{ #category : #'gt-inspector-extension' }
GTASomeComputers >> gtInspectorComputersIn: composite [
	<gtInspectorPresentationOrder: -10>  
	^ (composite table)
		title: 'Computers';
		display: [ :aComputer | aComputer ];
		column: 'Since' 
			evaluated: [ :each | String streamContents: [ :aStream | 
											each start = 0 
												ifTrue: [ aStream nextPutAll: 'unknown' ]
												ifFalse: [ each start asUTC printYMDOn: aStream ] ] ]
			width: 67;
		column: 'Days' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration asDuration asDays rounded ] 
			width: 40;
		column: 'Spent' 
			evaluated: [ :each | each spentTime ] 
			width: 63;
		column: 'User' 
			evaluated: [ :each | each userOrDeveloperString ] 
			width: 50;
		column: 'Sessions' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each size ] 
			width: 60;
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfEvents ] 
			width: 50;
		column: 'Previews' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfPreviews ] 
			width: 60;
		column: 'Inputs' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfContextChanged ]
			width: 47;
		column: 'Diff Inp.' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDifferentSearchStrings ]
			width: 53;
		column: 'Dives In' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDivesIn ]
			width: 53;
		column: 'Dives Out' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDivesOut ]
			width: 63;
		column: 'Avg. D-In' 
			evaluated: [ :each | (each avgNumberOfDivesIn printShowingDecimalPlaces: 2)]
			width: 60;
		column: 'Avg. D-Out' 
			evaluated: [ :each | (each avgNumberOfDivesOut printShowingDecimalPlaces: 2) ]
			width: 67;
		column: 'MissSteps' 
			evaluated: [ :each | each numberOfMissSteps ]
			width: 60;
		beMultiple;
		send: [ :result | GTAMultipleSelectionSendCommand selection: result in: self as: GTASomeComputers ];
		showOnly: 100
]

{ #category : #'gt-inspector-extension' }
GTASomeComputers >> gtInspectorSessionClassificationIn: composite [
	<gtInspectorPresentationOrder: -5>  
	^ (composite table)
		title: 'Classification';
		display: [ :aComputers | aComputers perSessionType ];
		column: 'Type' 
			evaluated: [ :each | each sessionTypeString ]
			width: 100;
		column: 'Count' 
			evaluated: [ :each | each size ] 
			width: 50
			tags: #()
			sortedBy: [ :aComputer1 :aComputer2 | aComputer1 size > aComputer2 size ];
		column: '%' 
			evaluated: [ :each | each sizeInPercent asFloat rounded ] 
			width: 30;
		column: 'Mean Duration' 
			evaluated: [ :each | self meanDurationFor: each ] 
			width: 97;
		column: 'Min Duration' 
			evaluated: [ :each | self minDurationFor: each ] 
			width: 97;
		column: 'Max Duration' 
			evaluated: [ :each | self maxDurationFor: each ] 
			width: 97;
		showOnly: 100
]

{ #category : #'gt-inspector-extension' }
GTASomeComputers >> gtInspectorTimelineViewIn: composite [
	<gtInspectorPresentationOrder: -8>
	composite roassal2
		title: 'Timeline';
		initializeView: [ self timelineView ]
		
]

{ #category : #'enumerating - computer' }
GTASomeComputers >> maxDurationFor: aComputer [
	aComputer ifEmpty: [ ^ 0 seconds ].
	^ (aComputer max: #duration) roundTo: 1 second
]

{ #category : #'enumerating - computer' }
GTASomeComputers >> meanDurationFor: aComputer [
	aComputer ifEmpty: [ ^ 0 seconds ].
	^ ((aComputer collect: #duration as: OrderedCollection) sum / aComputer size) roundTo: 1 second
]

{ #category : #'enumerating - computer' }
GTASomeComputers >> minDurationFor: aComputer [
	aComputer ifEmpty: [ ^ 0 seconds ].
	^ (aComputer detectMin: #duration) duration roundTo: 1 second
]

{ #category : #enumerating }
GTASomeComputers >> missSteps [
	^ self flatCollect: #missSteps as: GTASession
]

{ #category : #enumerating }
GTASomeComputers >> numberOfContextChanged [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfContextChanged 
]

{ #category : #helpers }
GTASomeComputers >> numberOfEvents [
	^ self sum: [ :each | each numberOfEvents ]
]

{ #category : #helpers }
GTASomeComputers >> numberOfMissSteps [
	^ self missSteps size
]

{ #category : #helpers }
GTASomeComputers >> numberOfSessions [
	^ self sum: [ :each | each size ]
]

{ #category : #enumerating }
GTASomeComputers >> perSessionType [
	| results |
	results := GTACollection new.
	results add: (((self sessions select: #isEmptySession) as: GTAComputer) computers: self; sessionTypeString: 'Empty'; yourself).
	results add: (((self sessions select: #isDirectSession) as: GTAComputer) computers: self; sessionTypeString: 'Direct'; yourself).
	results add: (((self sessions select: #isFirstLevelDiveInSession) as: GTAComputer) computers: self; sessionTypeString: 'First Level Dive-In'; yourself).
	results add: (((self sessions select: #isComplexSession) as: GTAComputer) computers: self; sessionTypeString: 'Complex'; yourself).
	results add: (((self sessions select: #hasDelayedExit) as: GTAComputer) computers: self; sessionTypeString: 'Delayed Exit'; yourself).
	^ results
]

{ #category : #'enumerating - events' }
GTASomeComputers >> selectComputersWithEvents: aBlock [
	^ self select: [ :eachComputer | eachComputer anySatisfy: [ :eachSession | eachSession anySatisfy: aBlock ] ]
]

{ #category : #'enumerating - computer' }
GTASomeComputers >> selectComputersWithSessions: aBlock [
	^ self select: [ :eachComputer | eachComputer select: aBlock ]
]

{ #category : #'enumerating - events' }
GTASomeComputers >> selectSessionsPerComputerWithEvents: aBlock [
	| someComputers |
	someComputers := (self 
		collect: [ :eachComputer | | newComputer |
			newComputer := eachComputer select: [ :eachSession | eachSession anySatisfy: aBlock ].
			(newComputer as: GTASomeSessions) computer: eachComputer computer; yourself ]
		as: GTASomeComputers)
		select: #notEmpty.
	someComputers computers: self computers.
	^ someComputers
]

{ #category : #'enumerating - sessions' }
GTASomeComputers >> sessions [
	^ self flatCollect: #yourself as: GTASessions
]

{ #category : #'enumerating - sessions' }
GTASomeComputers >> sessionsPerActOnOrCloseActionCategories [
	| dictionary computers |
	dictionary := Dictionary new.
	self  
		select: [ :eachComputer | eachComputer anyEventSatisfy: #isCloseSpotter ]
		thenDo: [ :eachComputer | 
			eachComputer categoryLabels asSet do: [ :eachLabel |
				dictionary 
					at: eachLabel
					ifPresent: [ :aCollection | aCollection add: eachComputer ]
					ifAbsent: [ dictionary 
										at: eachLabel 
										put: (GTASomeComputers new
													add: eachComputer;
													categoryLabel: eachLabel;
													computers: self computers;
													yourself) ] ] ].
	computers := dictionary associations 
		collect: #value
		as: GTASomeComputers.
	computers computers: self computers.
	^ computers
]

{ #category : #'enumerating - sessions' }
GTASomeComputers >> sessionsPerSelectedCategories [
	| dictionary computers |
	dictionary := Dictionary new.
	self  
		select: [ :eachComputer | eachComputer anyEventSatisfy: #isCategorySelection ]
		thenDo: [ :eachComputer | 
			eachComputer categoryLabels asSet do: [ :eachLabel |
				dictionary 
					at: eachLabel
					ifPresent: [ :aCollection | aCollection add: eachComputer ]
					ifAbsent: [ dictionary 
										at: eachLabel 
										put: (GTASomeComputers new
													add: eachComputer;
													categoryLabel: eachLabel;
													computers: self computers;
													yourself) ] ] ].
	computers := dictionary associations 
		collect: #value
		as: GTASomeComputers.
	computers computers: self computers.
	^ computers
]

{ #category : #'enumerating - sessions' }
GTASomeComputers >> sessionsWithNumberOfInputsGreaterThen: anInteger [
	^ self collect: [ :each | each copy sessionsWithNumberOfInputsGreaterThen: anInteger ]
]

{ #category : #'enumerating - sessions' }
GTASomeComputers >> sessionsWithNumberOfInputsGreaterThenOne [
	^ self sessionsWithNumberOfInputsGreaterThen: 1
]

{ #category : #sorting }
GTASomeComputers >> sortByDevelopersAndDuration [
	self sort: [ :a :b | | duration |
		duration := a duration > b duration.
		(a isDeveloper and: [ duration ]) or: [ 
			(b isDeveloper not and: [ duration ]) or: [ 
				a isDeveloper and: [ b isDeveloper not and: [ duration not ] ] ] ] ]
]

{ #category : #sorting }
GTASomeComputers >> sortByDevelopersAndNumberOfSessions [
	self sort: [ :a :b | | bigger |
		bigger := a size > b size.
		(a isDeveloper and: [ bigger ]) or: [ 
			(b isDeveloper not and: [ bigger ]) or: [ 
				a isDeveloper and: [ b isDeveloper not and: [ bigger not ] ] ] ] ]
]

{ #category : #enumerating }
GTASomeComputers >> specialKeywords [
	^ self flatCollect: #specialKeywords as: OrderedCollection
]

{ #category : #'gt-inspector-extension' }
GTASomeComputers >> timelineView [
	^ GTATimelineBuilder new computers: self; build; menu; view.
]

{ #category : #enumerating }
GTASomeComputers >> unknownNames [
	^ self flatCollect: #unknownNames as: OrderedCollection
]

{ #category : #update }
GTASomeComputers >> updateEvents [
	^ self do: #updateEvents
]
