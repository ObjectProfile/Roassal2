Class {
	#name : #GTASessionBookmark,
	#superclass : #GTABookmark,
	#category : #'GT-Spotter-EventRecorder-Analysis-Bookmarks'
}

{ #category : #initialization }
GTASessionBookmark >> from: aCollection computers: aGTAComputers [ 
	| computer session |
	computer := aGTAComputers 
						detect: [ :each | each computerUUID = aCollection second ] 
						ifNone: [ ^ self newDetachedBookmark: aCollection ].
	session := computer 
						detect: [ :each | each start = aCollection third ] 
						ifNone: [ ^ self newDetachedBookmark: aCollection ].
	self
		item: session;
		description: aCollection fourth;
		dateAndTime: aCollection fifth;
		garbage: aCollection sixth
]

{ #category : #accessing }
GTASessionBookmark >> path [
	^ Array
		with: self class
		with: self item computerUUID
		with: self item start
		with: self description
		with: self dateAndTime
		with: self garbage
]

{ #category : #accessing }
GTASessionBookmark >> typeName [
	^ 'session'
]
