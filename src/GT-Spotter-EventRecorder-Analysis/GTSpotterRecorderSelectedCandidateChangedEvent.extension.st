Extension { #name : #GTSpotterRecorderSelectedCandidateChangedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> analysisIcon [
	^ GTAEventIcons selectedCandidateChangedIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> categoryEvent [
	^ self infoAt: #selectedCategoryEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Selection of '.
	self elementNamePrintOn: aStream.
	self selectedCategoryLabel ifNotNil: [ :aLabelString |
		aStream
			cr
			nextPutAll: 'in category ';
			nextPutAll: aLabelString ].
	self eventTypePrintOn: aStream.
	self printDelayFromPreviousEventOn: aStream.

]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> existsUserSelectionsOfTheSameElement [
	| index |
	index := self session identityIndexOf: self.
	^ self session anySatisfy: [ :each | 
			((each isUserSelectionClass and: [ 
				each elementName = self elementName ]) 
					and: [ (each == self) not ]) 
						and: [ (self session identityIndexOf: each) < index ] ] 
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> hasKnownName [
	^ self elementName notNil
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> hasName [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> isForTimelineView [
	^ self isUserSelection
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> isInTheSameCategoryAsPreviousSelection [
	^ self previousSelection isNil or: [ 
			self selectedCategoryLabel = self previousSelection selectedCategoryLabel ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> isUserSelection [
	^ true "(self isInTheSameCategoryAsPreviousSelection not and: [ self eventType notNil ]) or: [ 
		(self eventType notNil) and: [ (self eventType = #unknown) not ] ]"
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> previousSelection [
	^ self infoAt: #previousSelection ifAbsent: [ nil ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> previousSelection: aGTSpotterRecorderSelectedCandidateChangedEvent [ 
	self infoAt: #previousSelection put: aGTSpotterRecorderSelectedCandidateChangedEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> removePreviousSelection [
	^ self removeInfoKey: #previousSelection
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> selectedCategoryEvent [
	^ self infoAt: #selectedCategoryEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> selectedCategoryEvent: anEvent [
	self infoAt: #selectedCategoryEvent put: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> selectedCategoryLabel [
	^ self selectedCategoryEvent ifNotNil: [ :catEvent | catEvent categoryLabel ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> userQueryOrSelectionHashes [
	^ self elementName 
			ifNil: [ #() ]
			ifNotNil: [ :value | Array with: value ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> userSelectionsOfTheSameElement [
	| index |
	index := self session identityIndexOf: self.
	^ self session select: [ :each | 
			((each isUserSelectionClass and: [ 
				each elementName = self elementName ]) 
					and: [ (each == self) not ]) 
						and: [ (self session identityIndexOf: each) < index ] ] 
]
