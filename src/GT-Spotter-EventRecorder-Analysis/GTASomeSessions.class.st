Class {
	#name : #GTASomeSessions,
	#superclass : #GTAEventCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #'gt-inspector-extension' }
GTASomeSessions >> activityView [
	| composer builders |
	composer := RTComposer new.
	composer view @ RTZoomableView.
	self ifEmpty: [ ^ composer view ].
	builders := GTAActivityBuilders new.
	1 to: (self size min: 100) do: [ :index | | builder |
		builder := GTAActivityBuilder new.
		builder 
			view: composer view;
			configuration: GTADefaultTimelineConfiguration uniqueInstance;
			events: (self at: index);
			build.
		composer group: index.
		index > 1 ifTrue: [ composer move: index belowAlignFromLeft: index - 1 ].
		builders add: builder.
	 ].
	GTAActivityMenuBuilder new timelineBuilder: builders; build.
	composer view canvas focusOnCenterScaled.
	^ composer view.
]

{ #category : #'enumerating - events' }
GTASomeSessions >> anyEventSatisfy: aBlockClosure [ 
	^ self anySatisfy: [ :eachSession | eachSession anyEventSatisfy: aBlockClosure ]
]

{ #category : #helpers }
GTASomeSessions >> avgNumberOfDivesIn [
	self ifEmpty: [ ^ 0 ].
	^ (self sum: #numberOfDivesIn) / self size
]

{ #category : #helpers }
GTASomeSessions >> avgNumberOfDivesOut [
	self ifEmpty: [ ^ 0 ].
	^ (self sum: #numberOfDivesOut) / self size
]

{ #category : #api }
GTASomeSessions >> bookmarkIt [
	self bookmarks
		addSomeSessions: self
		description: 'Added at ', DateAndTime now rounded asString;
		save
]

{ #category : #accessing }
GTASomeSessions >> bookmarks [
	^ self computer bookmarks
]

{ #category : #enumerating }
GTASomeSessions >> categoryLabels [
	^ self flatCollect: #categoryLabels as: OrderedCollection
]

{ #category : #accessing }
GTASomeSessions >> computer [
	^ self optionAt: #computer
]

{ #category : #accessing }
GTASomeSessions >> computer: aCollection [ 
	^ self optionAt: #computer put: aCollection
]

{ #category : #enumerating }
GTASomeSessions >> divesIn [
	^ self flatCollect: #divesIn as: OrderedCollection
]

{ #category : #'gt-inspector-extension' }
GTASomeSessions >> durationView [
	| b ds |
	b := RTGrapher new.
	b extent: 500 @ 100.
	self ifEmpty: [ ^ b view ].
	ds := RTStackedDataSet new.
	ds interaction highlight.
	ds interaction popup text: [ :obj | obj sessionPopupText ].
	ds points: self.
	ds barShape 
			color: [ :obj | obj isWithPreview 
				ifTrue: [ Color green alpha: 0.3 ]
				ifFalse: [ Color blue alpha: 0.3 ] ]; 
			width: 10.
	ds y: [ :c | c duration asSeconds ].
	b add: ds.
	b axisX noTick; noLabel.
	b axisY.
	b build.
	^ b view.
	
]

{ #category : #'enumerating - events' }
GTASomeSessions >> flatCollectEvents: aBlock [ 
	^ self flatCollect: [ :eachSession | eachSession select: aBlock ] as: OrderedCollection
]

{ #category : #'gt-inspector-extension' }
GTASomeSessions >> gtInspectorActivityViewIn: composite [
	<gtInspectorPresentationOrder: -6>
	composite roassal2
		title: 'Activity';
		initializeView: [ self activityView ]
		
]

{ #category : #'gt-inspector-extension' }
GTASomeSessions >> gtInspectorDurationViewIn: composite [
	<gtInspectorPresentationOrder: -1>
	composite roassal2
		title: 'Duration';
		initializeView: [ self durationView ]
		
]

{ #category : #'gt-inspector-extension' }
GTASomeSessions >> gtInspectorSessionsIn: composite [
	<gtInspectorPresentationOrder: -10>  
	^ (composite table)
		title: 'Sessions';
		display: [ :aComputer | aComputer ];
		column: 'Start' 
			evaluated: [ :each | String streamContents: [ :aStream | | start |
											start := each start.
											start = 0 
												ifTrue: [ aStream nextPutAll: 'unknown' ]
												ifFalse: [
													start asUTC printYMDOn: aStream.
													aStream nextPutAll: ', '.
													start asUTC printHMSOn: aStream ] ] ]
			width: 120;
		column: 'Duration' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration ] width: 67;
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each size ] width: 50;
		column: 'Preview' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each previewString ]
			width: 57;
		column: 'MissSteps' 
			evaluated: [ :each | each numberOfMissSteps ]
			width: 67;
		column: 'Inputs' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfContextChanged ]
			width: 47;
		column: 'Diff Inp.' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDifferentSearchStrings ]
			width: 53;
		column: 'Fin. Searches' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfContextChanged ]
			width: 83;
		column: 'Selections' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfUserSelections ]
			width: 70;
		column: 'Dives In' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDivesIn ]
			width: 53;
		column: 'Close' 
			evaluated: [ :each | each closeActionSymbol ]
			width: 63;
		column: 'Image Hashes' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each imageHashes size ]
			width: 70;
		beMultiple;
		send: [ :result | GTAMultipleSelectionSendCommand selection: result in: self ];
		showOnly: 200
]

{ #category : #'gt-inspector-extension' }
GTASomeSessions >> gtInspectorTimelineViewIn: composite [
	<gtInspectorPresentationOrder: -8>
	composite roassal2
		title: 'Timeline';
		initializeView: [ self timelineView ]
		
]

{ #category : #testing }
GTASomeSessions >> isDeveloper [
	^ GTAConfiguration isDeveloper: self computerUUID
]

{ #category : #enumerating }
GTASomeSessions >> missSteps [
	^ self flatCollect: #missSteps as: GTASession
]

{ #category : #helpers }
GTASomeSessions >> numberOfContextChanged [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfContextChanged
]

{ #category : #helpers }
GTASomeSessions >> numberOfDifferentSearchStrings [
	^ self differentSearchStrings size
]

{ #category : #helpers }
GTASomeSessions >> numberOfDivesIn [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfDivesIn	
]

{ #category : #helpers }
GTASomeSessions >> numberOfDivesOut [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfDivesOut
]

{ #category : #helpers }
GTASomeSessions >> numberOfEvents [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #size
]

{ #category : #helpers }
GTASomeSessions >> numberOfPreviews [
	^ self sessionsWithPreview size
]

{ #category : #printing }
GTASomeSessions >> printHumanReadableOn: aStream [
	| duration |
	aStream 
		nextPutAll: (self size pluralize: 'session');
		nextPutAll: ' from '; 
		print: self start asDate; 
		cr;
		nextPutAll: ' during '. 
	duration := self duration.
	self duration > 1 second ifTrue: [ duration := self duration truncateTo: 1 milliseconds ].
	self duration > 1 minute ifTrue: [ duration := self duration truncateTo: 1 second ].
	self duration > 1 hour ifTrue: [ duration := self duration truncateTo: 1 minute ].
	self duration > 1 day ifTrue: [ duration := self duration truncateTo: 1 hour ].
	duration printHumanReadableOn: aStream.
	aStream
		cr;
		print: self specialKeywords size; nextPutAll: ' special keywords'; cr;
		print: self divesIn size; nextPutAll: ' dives-in'; cr;
		print: self unknownNames size; nextPutAll: ' unknown items'
		
]

{ #category : #enumerating }
GTASomeSessions >> searchStrings [
	^ self flatCollect: #searchStrings as: Bag
]

{ #category : #accessing }
GTASomeSessions >> sessionTypeString [
	^ self optionAt: #sessionTypeString
]

{ #category : #initialization }
GTASomeSessions >> sessionTypeString: aString [ 
	^ self optionAt: #sessionTypeString put: aString
]

{ #category : #'enumerating - sessions' }
GTASomeSessions >> sessions [
	^ self
]

{ #category : #'enumerating - sessions' }
GTASomeSessions >> sessionsPerActOnOrCloseActionCategories [
	| dictionary sessions |
	dictionary := Dictionary new.
	self  
		select: [ :eachSession | eachSession anyEventSatisfy: #isCloseSpotter ]
		thenDo: [ :eachSession | 
			eachSession categoryLabels asSet do: [ :eachLabel |
				dictionary 
					at: eachLabel
					ifPresent: [ :aCollection | aCollection add: eachSession ]
					ifAbsent: [ dictionary 
										at: eachLabel 
										put: (GTASomeSessions new
													add: eachSession;
													categoryLabel: eachLabel;
													computer: self computer;
													yourself) ] ] ].
	sessions := dictionary associations 
		collect: #value
		as: GTASomeSessions.
	sessions computer: self computer.
	^ sessions
]

{ #category : #'enumerating - sessions' }
GTASomeSessions >> sessionsPerSelectedCategories [
	| dictionary sessions |
	dictionary := Dictionary new.
	self  
		select: [ :eachSession | eachSession anyEventSatisfy: #isCategorySelection ]
		thenDo: [ :eachSession | 
			eachSession categoryLabels asSet do: [ :eachLabel |
				dictionary 
					at: eachLabel
					ifPresent: [ :aCollection | aCollection add: eachSession ]
					ifAbsent: [ dictionary 
										at: eachLabel 
										put: (GTASomeSessions new
													add: eachSession;
													categoryLabel: eachLabel;
													computer: self computer;
													yourself) ] ] ].
	sessions := dictionary associations 
		collect: #value
		as: GTASomeSessions.
	sessions computer: self computer.
	^ sessions
]

{ #category : #'enumerating - sessions' }
GTASomeSessions >> sessionsWithPreview [
	^ self select: #isWithPreview
]

{ #category : #accessing }
GTASomeSessions >> sizeInPercent [
	^ (self size / self computers sessions size * 100)
]

{ #category : #sorting }
GTASomeSessions >> sortByDateAndTime [
	self sort: [ :a :b | a start < b start ]
]

{ #category : #enumerating }
GTASomeSessions >> specialKeywords [
	^ self flatCollect: #specialKeywords as: OrderedCollection
]

{ #category : #enumerating }
GTASomeSessions >> spentTime [
	self ifEmpty: [ ^ 0 seconds ].
	^ self sum: #duration
]

{ #category : #'gt-inspector-extension' }
GTASomeSessions >> timelineView [
	| builder minTime dataSetBuilder set objects |
	builder := RTTimeline new.
	minTime := self start asUnixTime.
	self size > 15 
		ifTrue: [ 
			dataSetBuilder := GTARoughDataSetBuilder new
				gap: self duration / 108;
				setSessionComparator;
				newGroupBlock: [ GTASomeSessions new computer: self; yourself ];
				yourself.
			dataSetBuilder objects: self copy sortByDateAndTime; build.
			objects := dataSetBuilder groups collect: [ :eachGroup |
				eachGroup size = 1 ifTrue: [ eachGroup any ] ifFalse: [ eachGroup ] ] ]
		ifFalse: [ objects := self ].
	set := RTTimelineSet new.
	set 
		lineIdentifier: 1;
		objects: objects;
		start: [ :eachSession | eachSession start asUnixTime - minTime ];
		end: [ :eachSession | eachSession end asUnixTime - minTime ].
	set interaction popupText: #humanReadablePrintString.
	set shape color: (RTMultiLinearColorForIdentity new objects: objects).
	builder add: set.
	builder axisX 
		numberOfLabels: 5;
		labelRotation: -45;
		labelConversion: [ :unixTime | 
			GTADateAndTimeStringBuilder new
				dateAndTime: (DateAndTime fromUnixTime: unixTime + minTime);
				duration: self duration;
				numberOfLabels: 5;
				humanReadablePrintString ].
	builder timelineLabel: ''.
	builder build.
	GTAMenuTimelineBuilder new timelineBuilder: builder; build.
	^ builder 
]

{ #category : #enumerating }
GTASomeSessions >> unknownNames [
	^ self flatCollect: #unknownNames as: OrderedCollection
]

{ #category : #accessing }
GTASomeSessions >> userOrDeveloperString [
	^ self isDeveloper
			ifTrue: [ 'dev' ]
			ifFalse: [ 'user' ]
]
