Extension { #name : #GTSpotterRecorderOpenEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderOpenEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Open Spotter'.
]
