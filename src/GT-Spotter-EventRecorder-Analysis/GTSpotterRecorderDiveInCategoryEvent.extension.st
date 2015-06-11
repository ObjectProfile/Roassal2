Extension { #name : #GTSpotterRecorderDiveInCategoryEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> addSameLevelEvent: anEvent [ 
	| events |
	events := self infoAt: #sameLevelEvents ifAbsentPut: [ OrderedCollection new ].
	events add: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> analysisIcon [
	^ self isMissStep 
			ifFalse: [ GTAEventIcons diveInCategoryIcon ]
			ifTrue: [ GTAEventIcons diveInCategoryMissStepIcon ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> duration [
	self children ifEmpty: [ ^ 0 seconds ].
	^ (self children last dateAndTime) - self dateAndTime 
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> eventAnalysisPrintOn: aStream [
	self isMissStep ifTrue: [ aStream nextPutAll: 'MissStep ' ].
	aStream nextPutAll: 'Dive In Category for '.
	aStream 
		print: self duration;
		nextPutAll: ': '.
	self categoryTitle
		ifNil: [ aStream nextPutAll: 'unknown category' ]
		ifNotNil: [ :aString | 
			aStream nextPutAll: aString ].
	self eventTypePrintOn: aStream.
	self printDelayFromPreviousEventOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> hasDiveIn [
	^ self children contains: #isDiveIn 
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> hasKnownName [
	^ self categoryTitle notNil
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> hasName [
	"In that case it is category title"
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> hasQuery [
	^ self children contains: #isContextChanged
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> isCategoryDiveIn [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> isForTimelineView [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> removeSelectedElementEvent [
	^ self removeInfoKey: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> selectedCategoryLabel [
	^ self selectedElementEvent selectedCategoryLabel
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> selectedElementEvent [
	^ self infoAt: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> selectedElementEvent: anEvent [
	^ self infoAt: #selectedElementEvent put: anEvent
]
