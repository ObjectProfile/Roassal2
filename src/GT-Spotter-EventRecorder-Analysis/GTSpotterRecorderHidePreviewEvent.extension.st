Extension { #name : #GTSpotterRecorderHidePreviewEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderHidePreviewEvent >> analysisIcon [
	^ GTAEventIcons hidePreviewIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderHidePreviewEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Hide Preview'.
	self printDelayFromPreviousEventOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderHidePreviewEvent >> isForTimelineView [
	^ true
]
