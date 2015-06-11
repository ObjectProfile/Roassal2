Class {
	#name : #GTASession,
	#superclass : #GTAEventCollection,
	#traits : 'TGTSpotterUpdateEvents',
	#classTraits : 'TGTSpotterUpdateEvents classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #'gt-inspector-extension' }
GTASession >> activityView [
	| builder |
	builder := GTAActivityBuilder new.
	builder 
		configuration: GTADefaultTimelineConfiguration uniqueInstance;
		events: self;
		build.
	GTAActivityMenuBuilder new timelineBuilder: builder; build.
	builder view canvas focusOnCenterScaled.
	^ builder view.
]

{ #category : #'gt-inspector-extension' }
GTASession >> activityView3 [
	"obsolete"
	^ GTAObsoleteActivityBuilder viewOn: self
]

{ #category : #'enumerating - events' }
GTASession >> anyEventSatisfy: aBlock [
	^ self anySatisfy: aBlock
]

{ #category : #api }
GTASession >> bookmarkIt [
	self bookmarks
		addSession: self
		description: 'Added at ', DateAndTime now rounded asString;
		save
]

{ #category : #api }
GTASession >> bookmarkIt: descriptionString [
	self bookmarks
		addSession: self
		description: descriptionString;
		save
]

{ #category : #accessing }
GTASession >> bookmarks [
	^ self computer bookmarks 
]

{ #category : #enumerating }
GTASession >> categoryLabels [
	^ self categorySelections collect: #categoryLabel as: OrderedCollection
]

{ #category : #enumerating }
GTASession >> categorySelections [
	^ self select: #isCategorySelection
]

{ #category : #accessing }
GTASession >> closeActionSymbol [
	self ifEmpty: [ ^ #empty ].
	^ self last closeActionSymbol
]

{ #category : #accessing }
GTASession >> computer [
	^ self optionAt: #computer
]

{ #category : #accessing }
GTASession >> computer: aGTSpotterComputer [
	^ self optionAt: #computer put: aGTSpotterComputer
]

{ #category : #comparing }
GTASession >> deepestDiveIn [
	^ self max: #diveInLevel
]

{ #category : #enumerating }
GTASession >> divesIn [
	^ self select: #isDiveIn
]

{ #category : #accessing }
GTASession >> end [
	self ifEmpty: [ ^ 0 ].
	^ self last dateAndTimeWithFixedTimeZone
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorActivityView3In: composite [
	<gtInspectorPresentationOrder: -5>
	"obsolete"
	composite roassal2
		title: 'Activity 3';
		initializeView: [ self activityView3 ]
		
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorActivityViewIn: composite [
	<gtInspectorPresentationOrder: -6>
	composite roassal2
		title: 'Activity';
		initializeView: [ self activityView ]
		
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorEventsIn: composite [
	<gtInspectorPresentationOrder: -10>  
	^ (composite table)
		title: 'Events';
		display: [ :aSession | aSession ];
		column: 'Event' 
			evaluated: [ :each | each asEventAnalysisString ] width: 400;
		column: 'Time' 
			evaluated: [ :each | GTAPrintDateAndTime yyyyMmDdAndHhMmSs: each dateAndTimeWithFixedTimeZone ]
			width: 120;
		withSmalltalkSearch;
		helpMessage: 'Given your INPUT, it executes: self select: [:each | INPUT ]';
		showOnly: 200
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorStrangeEventsIn: composite [
	<gtInspectorPresentationOrder: 9>  
	^ (composite tree)
		title: 'Strange';
		display: [ :aSession | aSession select: #isStrange ];
		children: [ :eachChild |
			eachChild isString 
				ifTrue: [ #() ]
				ifFalse: [ eachChild strange ] ];
		format: [ :eachEvent | 
			eachEvent isString 
				ifTrue: [ eachEvent ]
				ifFalse: [ eachEvent asEventAnalysisString, 
								' with ', eachEvent strange size asString, ' strange observations.' ] ]
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorTreeEventsIn: composite [
	<gtInspectorPresentationOrder: -8>  
	^ (composite tree)
		title: 'Tree';
		display: [ :aSession | aSession roots ];
		children: [ :eachChild |
			eachChild children ];
		format: [ :eachEvent | eachEvent asEventAnalysisString ]
		
]

{ #category : #testing }
GTASession >> hasDelayedExit [
	^ self optionAt: #hasDelayedExit ifAbsent: [ false ]
]

{ #category : #testing }
GTASession >> hasSpecialKeywords [
	^ self anySatisfy: [ :each | each isContextChanged and: [ each hasCurrentTextSpecials ] ]
]

{ #category : #accessing }
GTASession >> imageHashes [
	^ (self collect: #imageHash as: OrderedCollection) removeDuplicates
]

{ #category : #testing }
GTASession >> isComplexSession [
	^ self isFirstLevelDiveInSession not and: [ 
		self isDirectSession not and: [ 
			self isEmptySession not and: [ 
				self hasDelayedExit not ] ] ]
]

{ #category : #testing }
GTASession >> isDirectSession [
	^ self optionAt: #isDirectSession ifAbsent: [ false ]
]

{ #category : #testing }
GTASession >> isEmptySession [
	^ self optionAt: #isEmptySession ifAbsent: [ false ]
]

{ #category : #testing }
GTASession >> isFirstLevelDiveInSession [
	^ self optionAt: #isFirstLevelDiveInSession ifAbsent: [ false ]
]

{ #category : #testing }
GTASession >> isWithPreview [
	^ (self contains: #isShowPreview) and: [ 
			(self contains: #isHidePreview) not ]
]

{ #category : #enumerating }
GTASession >> missSteps [
	| collection |
	collection := self select: #isMissStep.
	collection computer: self computer.
	^ collection
]

{ #category : #accessing }
GTASession >> previewString [
	^ self isWithPreview
		ifTrue: [ 'yes' ]
		ifFalse: [ 'no' ]
]

{ #category : #printing }
GTASession >> printHumanReadableOn: aStream [ 
	self sessionPopupTextOn: aStream
]

{ #category : #initialization }
GTASession >> removeHasDelayedExit [
	^ self removeOptionKey: #hasDelayedExit
]

{ #category : #initialization }
GTASession >> removeIsDirectSession [
	^ self removeOptionKey: #isDirectSession
]

{ #category : #initialization }
GTASession >> removeIsEmptySession [
	^ self removeOptionKey: #isEmptySession
]

{ #category : #initialization }
GTASession >> removeIsFirstLevelDiveInSession [
	^ self removeOptionKey: #isFirstLevelDiveInSession
]

{ #category : #initialization }
GTASession >> removeIsOneDiveInSession [
	^ self removeOptionKey: #isOneDiveInSession
]

{ #category : #enumerating }
GTASession >> roots [
	^ self select: #isRootEvent
]

{ #category : #enumerating }
GTASession >> searchStrings [
	^ ((self select: #isContextChanged)
			flatCollect: #currentTextHashes as: Bag)
]

{ #category : #enumerating }
GTASession >> select: aBlock [
	| newCollection |
	newCollection := super select: aBlock.
	newCollection computer: self computer.
	^ newCollection
]

{ #category : #enumerating }
GTASession >> selectedCategoryLabel [
	^ self last selectedCategoryLabel
]

{ #category : #'enumerating - sessions' }
GTASession >> sessions [
	^ Array with: self
]

{ #category : #'enumerating - sessions' }
GTASession >> sessionsPerActOnOrCloseActionCategories [
	| labels col |
	labels := ((self select: #isCloseSpotter) collect: #selectedCategoryLabel as: OrderedCollection) removeDuplicates.
	col := labels collect: [ :eachLabel | self categoryLabel: eachLabel; yourself ] as: GTASomeSessions.
	col computer: self computer.
	^ col
]

{ #category : #'enumerating - sessions' }
GTASession >> sessionsPerSelectedCategories [
	| labels col |
	labels := ((self select: #isCategorySelection) collect: #categoryLabel as: OrderedCollection) removeDuplicates.
	col := labels collect: [ :eachLabel | self categoryLabel: eachLabel; yourself ] as: GTASomeSessions.
	col computer: self computer.
	^ col
]

{ #category : #initialization }
GTASession >> setDirectSession [
	self optionAt: #isDirectSession put: true
]

{ #category : #initialization }
GTASession >> setHasDelayedExit [
	self optionAt: #hasDelayedExit put: true
]

{ #category : #initialization }
GTASession >> setIsEmptySession [
	self optionAt: #isEmptySession put: true
]

{ #category : #initialization }
GTASession >> setIsFirstLevelDiveInSession [
	self optionAt: #isFirstLevelDiveInSession put: true
]

{ #category : #enumerating }
GTASession >> specialKeywords [
	^ self select: [ :each | each isContextChanged and: [ each hasCurrentTextSpecials ] ]
]

{ #category : #accessing }
GTASession >> start [
	self ifEmpty: [ ^ 0 ].
	^ self first dateAndTimeWithFixedTimeZone
]

{ #category : #'gt-inspector-extension' }
GTASession >> timelineView2 [
	^ self activityView
]

{ #category : #enumerating }
GTASession >> unknownNames [
	^ self select: #hasUnknownName
]

{ #category : #update }
GTASession >> updateEvents [
	^ GTASessionAnalysis updateOn: self
]

{ #category : #enumerating }
GTASession >> userQueryOrSelectionHashes [
	^ self flatCollect: #userQueryOrSelectionHashes as: OrderedCollection 
]
