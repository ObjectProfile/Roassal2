Extension { #name : #GTSpotterRecorderDiveInElementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> addSameLevelEvent: anEvent [ 
	| events |
	events := self infoAt: #sameLevelEvents ifAbsentPut: [ OrderedCollection new ].
	events add: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> analysisIcon [
	^ self isMissStep 
			ifFalse: [ GTAEventIcons diveInElementIcon ]
			ifTrue: [ GTAEventIcons diveInElementMissStepIcon ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> duration [
	self children ifEmpty: [ ^ 0 seconds ].
	^ (self children last dateAndTime) - self dateAndTime 
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> eventAnalysisPrintOn: aStream [
	self isMissStep ifTrue: [ aStream nextPutAll: 'MissStep ' ].
	aStream 
		nextPutAll: 'Dive In Element of category ';
		nextPutAll: self selectedCategoryLabel;
		cr;
		nextPutAll: 'for ';
		print: self duration.
	self eventTypePrintOn: aStream.
	self printDelayFromPreviousEventOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> hasDiveIn [
	^ self children contains: #isDiveIn 
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> hasKnownName [
	"In that case a hash"
	^ self elementName notNil
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> hasName [
	"In that case a hash"
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> hasQuery [
	^ self children contains: #isContextChanged
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> isElementDiveIn [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> isForTimelineView [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> removeSelectedElementEvent [
	^ self removeInfoKey: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> selectedCategoryLabel [
	^ self selectedElementEvent selectedCategoryLabel
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> selectedElementEvent [
	^ self infoAt: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> selectedElementEvent: anEvent [
	^ self infoAt: #selectedElementEvent put: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> userQueryOrSelectionHashes [
	^ self elementName 
			ifNil: [ #() ]
			ifNotNil: [ :value | Array with: value ]
]
