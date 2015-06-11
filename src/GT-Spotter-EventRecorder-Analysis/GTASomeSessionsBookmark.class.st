Class {
	#name : #GTASomeSessionsBookmark,
	#superclass : #GTABookmark,
	#category : #'GT-Spotter-EventRecorder-Analysis-Bookmarks'
}

{ #category : #'as yet unclassified' }
GTASomeSessionsBookmark >> from: aCollection computers: aGTAComputers [ 
	| computer |
	self item: (GTASomeSessions new: aCollection size - 5).
	computer := aGTAComputers 
		detect: [ :eachComputer | eachComputer computerUUID = (aCollection at: 2) ]
		ifNone: [  ^ self newDetachedBookmark: aCollection ].
	self item computer: computer.
	self description: (aCollection at: 3).
	self dateAndTime: (aCollection at: 4).
	self garbage: (aCollection at: 5).
	6 to: aCollection size do: [ :index |
		self item add: (GTABookmark from: (aCollection at: index) computers: aGTAComputers) item ].

]

{ #category : #accessing }
GTASomeSessionsBookmark >> path [
	| collection |
	collection := (Array new: self item size + 5).
	collection at: 1 put: self class.
	collection at: 2 put: self item computer computerUUID.
	collection at: 3 put: self description.
	collection at: 4 put: self dateAndTime.
	collection at: 5 put: self garbage.
	1 to: self item size do: [ :index |
		collection at: index + 5 put: (GTASessionBookmark new item: (self item at: index)) path.
	].
	^ collection
]

{ #category : #accessing }
GTASomeSessionsBookmark >> typeName [
	^ 'sessions'
]
