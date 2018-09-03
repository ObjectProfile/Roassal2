Class {
	#name : #GTAEventCollection,
	#superclass : #GTACollection,
	#traits : 'TGTABookmarkIt',
	#classTraits : 'TGTABookmarkIt classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTAEventCollection >> computerUUID [
	self ifEmpty: [ ^ 0 ].
	^ self any computerUUID
]

{ #category : #enumerating }
GTAEventCollection >> contextChanges [
	^ self select: #isContextChanged
]

{ #category : #enumerating }
GTAEventCollection >> differentSearchStrings [
	^ self searchStrings asSet
]

{ #category : #enumerating }
GTAEventCollection >> divesOut [
	^ self select: #isDiveOut
]

{ #category : #enumerating }
GTAEventCollection >> finishedSearches [
	^ self select: #isSearchFinished
]

{ #category : #testing }
GTAEventCollection >> hasMissSteps [
	^ self missSteps notEmpty
]

{ #category : #printing }
GTAEventCollection >> humanReadablePrintString [
	"Return a String with a human readable representation of me"
	^ String streamContents: [ :out | 
		self printHumanReadableOn: out ]
]

{ #category : #helpers }
GTAEventCollection >> numberOfContextChanged [
	^ self contextChanges size
]

{ #category : #helpers }
GTAEventCollection >> numberOfDifferentSearchStrings [
	^ self differentSearchStrings size
]

{ #category : #helpers }
GTAEventCollection >> numberOfDivesIn [
	^ self divesIn size
]

{ #category : #helpers }
GTAEventCollection >> numberOfDivesOut [
	^ self divesOut size
]

{ #category : #helpers }
GTAEventCollection >> numberOfFinishedSearches [
	^ self finishedSearches size
]

{ #category : #helpers }
GTAEventCollection >> numberOfMissSteps [
	^ self missSteps size
]

{ #category : #helpers }
GTAEventCollection >> numberOfUserSelections [
	^ self userSelections size
]

{ #category : #printing }
GTAEventCollection >> sessionPopupText [
	^ String streamContents: [ :aStream |
			self sessionPopupTextOn: aStream
		 ]
]

{ #category : #printing }
GTAEventCollection >> sessionPopupTextOn: aStream [
	aStream
		nextPutAll: 'Duration: ';
		print: self duration;
		cr;
		nextPutAll: 'Events: ';
		print: self size;
		cr;
		nextPutAll: 'Number of user input changes: ';
		print: self numberOfContextChanged;
		cr;
		nextPutAll: 'Number of different search strings: ';
		print: self numberOfDifferentSearchStrings;
		cr;
		nextPutAll: 'Number of finished searches: ';
		print: self numberOfFinishedSearches;
		cr;
		nextPutAll: 'Number of user item selections: ';
		print: self numberOfUserSelections;
		cr;
		nextPutAll: 'Dive in/out: ';
		print: self numberOfDivesIn;
		nextPut: $/;
		print: self numberOfDivesOut;
		cr;
		"using of #i, etc."
		nextPutAll: (self isWithPreview ifTrue: [ 'With Preview' ] ifFalse: [ 'Without Preview' ])
]

{ #category : #enumerating }
GTAEventCollection >> userSelections [
	^ self select: #isUserSelection
]
