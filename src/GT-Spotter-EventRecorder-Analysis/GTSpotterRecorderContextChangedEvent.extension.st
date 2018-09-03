Extension { #name : #GTSpotterRecorderContextChangedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> analysisIcon [
	^ GTAEventIcons contextChangedIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> currentTextInfoFromString: aString [ 
	currentTextInfo := self textInfoFrom: aString
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Query: '.
	self currentTextSizes 
			ifEmpty: [ aStream nextPutAll: 'no input' ]
			ifNotEmpty: [ :aCollection | 
					aStream
						print: aCollection size;
						nextPutAll: (aCollection size = 1 
											ifTrue: [ ' word of size ' ] 
											ifFalse: [ ' words, each of size: ' ]).
				aCollection 
					do: [ :eachSize | aStream print: eachSize ] 
					separatedBy: [ aStream space ].
				self hasCurrentTextSpecials ifTrue: [ 
					aStream nextPutAll: ', with #keyword' ] ].
	self printDelayFromPreviousEventOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> isForTimelineView [
	^ self isContextChanged
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> userQueryOrSelectionHashes [
	^ self currentTextHashes 
]
