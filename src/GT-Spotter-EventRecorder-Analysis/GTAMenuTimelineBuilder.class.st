Class {
	#name : #GTAMenuTimelineBuilder,
	#superclass : #Object,
	#instVars : [
		'timelineBuilder',
		'menuBuilder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #building }
GTAMenuTimelineBuilder >> build [
	self renderIn: timelineBuilder view.
]

{ #category : #'event handling' }
GTAMenuTimelineBuilder >> clean [
	| elements normalizer  |
	elements := timelineBuilder elements.
	normalizer := RTMultiLinearColorForIdentity new 
							objects: elements;
							yourself.
	elements do: [ :element |
		element trachelShape 
			color: (normalizer rtValue: element);
			strokePaint: Color transparent ].
	timelineBuilder view signalUpdate
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> divingUsage [
	self numberOfOccurrences: #divesIn inform: 'No dives-in.'

]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightCategoryFilters [
	self highlightSessionsWithEvents: [ :eachEvent | eachEvent isContextChanged and: [ eachEvent hasCurrentTextSpecials ] ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightComposedQueries [
	self highlightSessionsWithEvents: [ :eachEvent | 
		(eachEvent isSearchFinished and: [ (eachEvent currentQuerySpecials reject: [ :b | b = true ]) size > 1 ]) 
			and: [ eachEvent notEmptyCategories isEmpty ] ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightDivesIn [
	self highlightSessionsWithEvents: [ :eachEvent | eachEvent isDiveIn ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightPharo5Users [
	self highlightSessionsWithEvents: [ :eachEvent | 
		eachEvent latestUpdate >= 50000 ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightSessionsWithEvents: aBlock [
	timelineBuilder elements do: [ :eachElement | | color |
		(eachElement model anyEventSatisfy: aBlock)
			ifTrue: [ color := Color red ]
			ifFalse: [ color := Color white ].
		eachElement trachelShape 
			color: color;
			strokePaint: (Color black alpha: 0.4) ].
	timelineBuilder view signalUpdate
]

{ #category : #initialization }
GTAMenuTimelineBuilder >> initialize [
	super initialize.
	menuBuilder := RTMenuBuilder new.
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> keywordUsage [
	self numberOfOccurrences: #specialKeywords inform: 'No keywords.'

]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> numberOfOccurrences: aSymbol inform: aNoOccurrencesString [
	| elements keywords normalizer maxKeywords |
	elements := timelineBuilder elements.
	keywords := elements collect: [ :e | e -> (e model perform: aSymbol) size ].
	maxKeywords := keywords max: [ :assoc | assoc value ].
	maxKeywords = 0 ifTrue: [ 
		self inform: aNoOccurrencesString.
		^ self ].
	normalizer := RTGrayLinearColor new.
	normalizer command: #yourself; scope: (0 to: maxKeywords).
	elements do: [ :element | | elementKeywords |
		elementKeywords := keywords detect: [ :assoc | assoc key == element ].
		element trachelShape 
			color: (normalizer rtValue: elementKeywords value);
			strokePaint: (Color black alpha: 0.4) ].
	timelineBuilder view signalUpdate
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> numberOfSessions [
	self numberOfOccurrences: #sessions inform: 'There is not any session.'

]

{ #category : #hooks }
GTAMenuTimelineBuilder >> renderIn: aView [
	menuBuilder view: aView.
	menuBuilder menu: 'Feature Intensity' submenu: 'Number of Sessions' callback: [ self numberOfSessions ].
	menuBuilder menu: 'Feature Intensity' submenu: 'Category Filter' callback: [ self keywordUsage ].
	menuBuilder menu: 'Feature Intensity' submenu: 'Dive-In' callback: [ self divingUsage ].
	menuBuilder menu: 'Feature Intensity' submenu: 'Unknown items' callback: [ self unknownItems ].

	menuBuilder menu: 'Feature Usage' submenu: 'Composed Queries' callback: [ self highlightComposedQueries ].
	menuBuilder menu: 'Feature Usage' submenu: 'Category Filter' callback: [ self highlightCategoryFilters ].
	menuBuilder menu: 'Feature Usage' submenu: 'Dive-In' callback: [ self highlightDivesIn ].
	menuBuilder menu: 'Feature Usage' submenu: 'Pharo 5 Images' callback: [ self highlightPharo5Users ].

	menuBuilder menu: 'Clean' callback: [ self clean ].

]

{ #category : #accessing }
GTAMenuTimelineBuilder >> timelineBuilder [
	^ timelineBuilder
]

{ #category : #accessing }
GTAMenuTimelineBuilder >> timelineBuilder: anObject [
	timelineBuilder := anObject
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> unknownItems [
	self numberOfOccurrences: #unknownNames inform: 'No unknown names.'
]
