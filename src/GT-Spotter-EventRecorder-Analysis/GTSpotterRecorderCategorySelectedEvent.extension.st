Extension { #name : #GTSpotterRecorderCategorySelectedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> elementSelectionEvents [
	^ self infoAt: #selectedElementEvents ifAbsent: [ #() ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Category: '.
	self categoryLabel
		ifNil: [ aStream nextPutAll: 'unknown category' ]
		ifNotNil: [ :aString |
			aStream 
				nextPutAll: aString;
				nextPutAll: ' with ';
				print: self elementCountOrZero;
				nextPutAll: ' spotted and ';
				print: self selectedElementEvents size;
				nextPutAll: ' selected elements' ].
	self printDelayFromPreviousEventOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> hasKnownName [
	"It is a category name"
	^ self categoryLabel notNil
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> hasName [
	"It is a category name"
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> markAsStrange [
	^ self infoAt: #strange put: true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> selectedElementEvent: anEvent [
	| elements |
	elements := self infoAt: #selectedElementEvents ifAbsentPut: [ OrderedCollection new ].
	elements add: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> selectedElementEvents [
	^ self infoAt: #selectedElementEvents ifAbsent: [ #() ]
]
