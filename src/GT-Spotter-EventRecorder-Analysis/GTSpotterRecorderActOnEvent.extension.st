Extension { #name : #GTSpotterRecorderActOnEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> analysisIcon [
	^ GTAEventIcons actOnIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> eventAnalysisPrintOn: aStream [
	aStream 
		nextPutAll: 'Act on category ';
		nextPutAll: self selectedCategoryLabel.
	self eventTypePrintOn: aStream.
	self printDelayFromPreviousEventOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> hasKnownName [
	"It is a hash"
	^ self elementName notNil
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> hasName [
	"It is a hash"
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> isActOn [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> isForTimelineView [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> removeSelectedElementEvent [
	^ self removeInfoKey: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> selectedCategoryLabel [
	^ self selectedElementEvent selectedCategoryLabel
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> selectedElementEvent [
	^ self infoAt: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> selectedElementEvent: anEvent [
	^ self infoAt: #selectedElementEvent put: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> userQueryOrSelectionHashes [
	^ self elementName 
			ifNil: [ #() ]
			ifNotNil: [ :value | Array with: value ]
]
