Class {
	#name : #GTAComputerBookmark,
	#superclass : #GTABookmark,
	#category : #'GT-Spotter-EventRecorder-Analysis-Bookmarks'
}

{ #category : #initialization }
GTAComputerBookmark >> from: aCollection computers: aGTAComputers [ 
	| computer |
	computer := aGTAComputers 
						detect: [ :each | each computerUUID = aCollection second ]
						ifNone: [ ^ self newDetachedBookmark: aCollection ].
	self
		item: computer;
		description: aCollection third;
		dateAndTime: aCollection fourth;
		garbage: aCollection fifth
]

{ #category : #accessing }
GTAComputerBookmark >> path [
	^ Array
		with: self class
		with: self item computerUUID
		with: self description
		with: self dateAndTime
		with: self garbage
]

{ #category : #accessing }
GTAComputerBookmark >> typeName [
	^ 'computer'
]
