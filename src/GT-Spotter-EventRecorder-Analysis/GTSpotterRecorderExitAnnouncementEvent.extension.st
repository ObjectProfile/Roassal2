Extension { #name : #GTSpotterRecorderExitAnnouncementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> analysisIcon [
	^ GTAEventIcons exitIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Close Spotter'.
	self selectedCategoryLabel 
		ifNotNil: [ 
			aStream
				nextPutAll: ' on category ';
				nextPutAll: self selectedCategoryLabel ]
		ifNil: [ aStream nextPutAll: ' without results' ].
	self eventTypePrintOn: aStream.
	self printDelayFromPreviousEventOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> isForTimelineView [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> removeSelectedElementEvent [
	^ self removeInfoKey: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> selectedCategoryLabel [
	^ self selectedElementEvent 
		ifNil: [ nil ]
		ifNotNil: [ :obj | obj selectedCategoryLabel ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> selectedElementEvent [
	^ self infoAt: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> selectedElementEvent: anEvent [
	^ self infoAt: #selectedElementEvent put: anEvent
]
