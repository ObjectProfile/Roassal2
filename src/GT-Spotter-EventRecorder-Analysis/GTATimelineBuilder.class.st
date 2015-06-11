Class {
	#name : #GTATimelineBuilder,
	#superclass : #Object,
	#instVars : [
		'computers',
		'builder',
		'width',
		'height'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #building }
GTATimelineBuilder >> build [
	| minTime dataSetBuilder user |
	builder := RTTimeline new.
	minTime := self computers start asUnixTime.
	dataSetBuilder := GTARoughDataSetBuilder new
		gap: self computers duration / 108;
		setSessionComparator;
		yourself.
	self computers reverseWithIndexDo: [ :eachComputer :index | | set objects |
		dataSetBuilder 
			objects: eachComputer; 
			newGroupBlock: [ GTASomeSessions new computer: eachComputer; yourself ];
			build.
		objects := dataSetBuilder groups collect: [ :eachGroup |
			eachGroup size = 1 ifTrue: [ eachGroup any ] ifFalse: [ eachGroup ] ].
		set := RTTimelineSet new.
		set
			lineIdentifier: index;
			objects: objects;
			start: [ :eachSession | eachSession start asUnixTime - minTime ];
			end: [ :eachSession | eachSession end asUnixTime - minTime ].
		set interaction popupText: #humanReadablePrintString.
		set shape color: (RTMultiLinearColorForIdentity new 
							command: [ :eachSession | objects indexOf: eachSession ]; 
							objects: (1 to: objects size);
							yourself).
		builder add: set.
	 ].
	builder axisX 
		numberOfLabels: 5;
		labelRotation: 0;
		labelFontHeight: 8;
		labelConversion: [ :unixTime | 
			GTADateAndTimeStringBuilder new
				dateAndTime: (DateAndTime fromUnixTime: unixTime + minTime);
				duration: self computers duration;
				numberOfLabels: 5;
				humanReadablePrintString ].
	builder timelineLabelBuilder shape fontSize: 8.
	builder 
		timelineLabel: [ :lineIdentifier | String streamContents: [ :aStream |
				aStream 
					nextPutAll: (self computers at: lineIdentifier) userOrDeveloperString;
					space;
					print: lineIdentifier ] ];
		extent: self extent.
	
	user := self computers detect: [ :e | e isDeveloper not ] ifNone: [ nil ].
	user ifNotNil: [ | threshold |
		threshold := RTHorizontalTimelineDecorator 	new.
		threshold addLineAboveIdentifier: (self computers indexOf: user).
		threshold shape line width: 1; color: (Color blue alpha: 0.6).
		builder addDecorator: threshold ].
	
	builder build.
	^ builder view
]

{ #category : #accessing }
GTATimelineBuilder >> computers [
	^ computers
]

{ #category : #accessing }
GTATimelineBuilder >> computers: aGTAComputers [
	computers := aGTAComputers
]

{ #category : #accessing }
GTATimelineBuilder >> extent [
	^ self width @ self height
]

{ #category : #accessing }
GTATimelineBuilder >> height [
	^ height ifNil: [ height := self computers size * 10 max: 200 ]
]

{ #category : #accessing }
GTATimelineBuilder >> height: anObject [
	^ height := anObject
]

{ #category : #building }
GTATimelineBuilder >> menu [
	GTAMenuTimelineBuilder new timelineBuilder: builder; build.
	^ builder
]

{ #category : #accessing }
GTATimelineBuilder >> view [
	^ builder view
]

{ #category : #accessing }
GTATimelineBuilder >> width [
	^ width ifNil: [ width := 400 ]
]

{ #category : #accessing }
GTATimelineBuilder >> width: anObject [
	^ width := anObject
]
