Extension { #name : #GTSpotterRecorderShowPreviewEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderShowPreviewEvent >> analysisIcon [
	^ GTAEventIcons showPreviewIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderShowPreviewEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Show Preview'.
	self printDelayFromPreviousEventOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderShowPreviewEvent >> isForTimelineView [
	^ true
]
