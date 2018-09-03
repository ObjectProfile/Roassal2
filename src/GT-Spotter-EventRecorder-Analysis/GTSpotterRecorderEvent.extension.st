Extension { #name : #GTSpotterRecorderEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> analysisIcon [
	^ GTAEventIcons noIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> asEventAnalysisString [
	^ String streamContents: [ :stream |
			self eventAnalysisPrintOn: stream ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> children [
	^ self infoAt: #sameLevelEvents ifAbsent: [ #() ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> cleanDiveInEvent: aDiveInEvent [ 
	^ self removeInfoAt: #diveInEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> dateAndTimeWithFixedTimeZone [
	| dateAndTime announcementTimestamp session dates |
	self infoAt: #dateAndTimeWithFixedTimeZone ifPresent: [ :value | ^ value ] ifAbsent: [ "ignore" ].
	dateAndTime := self dateAndTime.
	dateAndTime ifNil: [ ^ nil ].
	announcementTimestamp := self announcementTimestamp.
	announcementTimestamp ifNil: [ 
		^ dateAndTime translateTo: 0 ].
	dateAndTime asDate yyyymmdd = announcementTimestamp asDate yyyymmdd ifTrue: [ 
		^ self 
			infoAt: #dateAndTimeWithFixedTimeZone 
			put: (dateAndTime translateTo: announcementTimestamp offset) ].
	session := self session.
	session ifNil: [ 
		^ dateAndTime translateTo: announcementTimestamp offset ].
	dates := (session collect: #announcementTimestamp as: Set)
		select: [ :eachTimestamp | eachTimestamp asDate yyyymmdd = dateAndTime asDate yyyymmdd ].
	dates ifEmpty: [ 
		^ dateAndTime translateTo: announcementTimestamp offset ].
	^ self 
		infoAt: #dateAndTimeWithFixedTimeZone 
		put: (dateAndTime translateTo: dates any offset)
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> delayFromPreviousEvent [
	self previousEvent ifNil: [ ^ 0 seconds ].
	^ self dateAndTimeWithFixedTimeZone - self previousEvent dateAndTimeWithFixedTimeZone
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> diveInEvent: aDiveInEvent [ 
	^ self infoAt: #diveInEvent put: aDiveInEvent.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> diveInLevel [
	^ self parentEvent 
		ifNotNil: [ :obj | obj diveInLevel + 1 ]
		ifNil: [ 1 ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> elementNamePrintOn: aStream [
	self elementName 
		ifNil: [ aStream nextPutAll: 'unknown element' ];
		ifNotNil: [ aStream nextPutAll: 'an element' ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> eventAnalysisPrintOn: aStream [
	self printOn: aStream
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> eventTypePrintOn: aStream [
	self eventType
		ifNotNil: [ :aSymbol |
			aStream
				cr;
				print: aSymbol;
				nextPutAll: ' event' ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> followingDifferentTime [
	^ self infoAt: #followingDifferentTime ifAbsent: [ self dateAndTimeWithFixedTimeZone ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: -1>  
	^ (composite table)
		title: 'Info';
		display: [ :anEvent | anEvent gtInspectorItems sort: [ :a :b | a key < b key ] ];
		children: [ :each | 
			(each value isDictionary) 
				ifTrue: [ each value associations ] 
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [:x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each key ]
			sortedBy: [ :a :b | a key < b key ];
		column: 'Value' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each value ];
		beMultiple;
		send: [ :selection | 
			(selection notNil and: [ selection size = 1 ]) 
				ifTrue: [ selection anyOne value ] 
				ifFalse: [ selection collect: #value ] ];
		showOnly: 50
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> hasElementName [
	^ false
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> hasKnownName [
	^ false
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> hasName [
	^ false
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> hasUnknownName [
	^ self hasName and: [ self hasKnownName not ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isActOn [
	^ false
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isCategoryDiveIn [
	^ false
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isElementDiveIn [
	^ false
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isForTimelineView [
	^ false
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isMissStep [
	^ self infoAt: #isMissStep ifPresent: [ :obj | true ] ifAbsent: [ false ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isRootEvent [
	^ self infoAt: #diveInEvent ifPresent: [ :obj | false ] ifAbsent: [ true ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isSearchFinishedClass [
	^ false
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isSpotterEvent [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isStrange [
	^ self infoAt: #strange ifPresent: [ :aCol | aCol notEmpty ] ifAbsent: [ false ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> markAsStrange: aString [
	| stranges |
	stranges := self infoAt: #strange ifAbsentPut: [ OrderedCollection new ].
	stranges add: aString.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> myPositionAmongSameTimeEvents [
	^ self infoAt: #myPositionAmongSameTimeEvents ifAbsent: [ 1 ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> offset: aDuration [ 
	"Private: For test case purpose only."
	timestamp := timestamp + aDuration
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> parentEvent [
	^ self infoAt: #diveInEvent ifPresent: [ :obj | obj ] ifAbsent: [ nil ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> previousEvent [ 
	^ self infoAt: #previousEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> previousEvent: anEvent [ 
	^ self infoAt: #previousEvent put: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> printDelayFromPreviousEventOn: aStream [
	self previousEvent ifNil: [ ^ self ].
	aStream 
		cr;
		nextPutAll: 'triggered after ';
		print: self delayFromPreviousEvent.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> relativeXPosition [
	^ self infoAt: #relativeXPosition
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> relativeXPosition: aDateAndTime [ 
	^ self infoAt: #relativeXPosition put: aDateAndTime
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeDiveInEvent [
	^ self removeInfoKey: #diveInEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeIsMissStep [
	^ self removeInfoKey: #isMissStep
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removePreviousEvent [
	^ self removeInfoKey: #previousEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeSameLevelEvents [
	^ self removeInfoKey: #sameLevelEvents
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeSameTimeEvents [
	self removeInfoKey: #sameTimeEvents.
	self removeInfoKey: #myPositionAmongSameTimeEvents.
	self removeInfoKey: #followingDifferentTime.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeSelectedCategoryEvent [
	^ self removeInfoKey: #selectedCategoryEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeSelectedElementEvents [
	^ self removeInfoKey: #selectedElementEvents
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeSession [
	^ self removeInfoKey: #session
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeStrange [
	^ self removeInfoKey: #strange
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> sameTimeEvents [
	^ self infoAt: #sameTimeEvents ifAbsent: [ #() ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> sameTimeEvents: aCollection index: anInteger nextDateAndTime: aDateAndTime [ 
	self infoAt: #sameTimeEvents put: aCollection.
	self infoAt: #myPositionAmongSameTimeEvents put: anInteger.
	self infoAt: #followingDifferentTime put: aDateAndTime.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> session [
	^ self infoAt: #session
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> session: aSessionCollection [ 
	^ self infoAt: #session put: aSessionCollection.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> setMissStep [
	^ self infoAt: #isMissStep put: true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> strange [
	^ self infoAt: #strange ifAbsent: [ #() ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> userQueryOrSelectionHashes [
	"It returns array of hashes that represent user input (query) or user selections."
	^ #()
]
