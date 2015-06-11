Extension { #name : #GTSpotterRecorderDiveOutEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> analysisIcon [
	^ GTAEventIcons diveOutIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Dive Out: '.
	self elementNamePrintOn: aStream.
	self printDelayFromPreviousEventOn: aStream.

]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> hasKnownName [
	^ self elementName notNil
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> hasName [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> isForTimelineView [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> userQueryOrSelectionHashes [
	^ self elementName 
			ifNil: [ #() ]
			ifNotNil: [ :value | Array with: value ]
]
