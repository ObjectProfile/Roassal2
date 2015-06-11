Extension { #name : #GTSpotterRecorderSearchFinishedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> associatedContextChanged [
	^ self infoAt: #associatedContextChanged
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> associatedContextChanged: aGTSpotterRecorderContextChangedEvent [ 
	^ self infoAt: #associatedContextChanged put: aGTSpotterRecorderContextChangedEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> currentQueryHashes [
	^ self stringHashesFor: self query
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> currentQuerySizes [
	^ self stringSizesFor: self query
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> currentQuerySpecials [
	^ self stringSpecialsFor: self query
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> eventAnalysisPrintOn: aStream [
	| categories | 
	categories := self notEmptyCategories.
	aStream
		nextPutAll: 'SearchFinished: ';
		nextPutAll: (query ifNil: [ 'no query' ] ifNotNil: [ 'with query' ]);
		nextPutAll: ', ';
		print: categories size;
		nextPutAll: ' categories, ';
		print: (self items ifEmpty: [ 0 ] ifNotEmpty: [ :col | col sum ]);
		nextPutAll: ' findings'.
	categories ifNotEmpty: [ | index |
		index := 1.
		aStream cr.
		categories 
			do: [ :category |
				index \\ 6 = 0 ifTrue: [ aStream cr ].
				aStream 
					nextPutAll: category key;
					nextPutAll: ' (';
					print: category value;
					nextPut: $).
				index := index + 1.
				 ] 
			separatedBy: [ aStream nextPutAll: ', ' ] ].
	self printDelayFromPreviousEventOn: aStream.

]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> hasKnownName [
	^ self query notNil and: [ self processors notNil ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> hasName [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> isForTimelineView [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> isSearchFinishedClass [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> notEmptyCategories [
	| notEmptyCategories |
	notEmptyCategories := OrderedCollection new.
	self processors ifNil: [ ^ notEmptyCategories ].
	self processors pairsDo: [ :processor :items |
		items > 0 ifTrue: [ notEmptyCategories add: (processor -> items) ]
	].
	^ notEmptyCategories
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> removeAssociatedContextChanged [
	^ self removeInfoKey: #associatedContextChanged
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> userQueryOrSelectionHashes [
	^ self currentQueryHashes
]
