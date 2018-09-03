Class {
	#name : #GTABookmarks,
	#superclass : #OrderedCollection,
	#instVars : [
		'announcer'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Bookmarks'
}

{ #category : #'instance creation' }
GTABookmarks class >> from: aCollection computers: aCollection2 [ 
	^ (self new: aCollection size + 10)
			from: aCollection computers: aCollection2;
			yourself
]

{ #category : #adding }
GTABookmarks >> addComputer: aGTAComputer description: aString [ 
	| item |
	item := self add: (GTAComputerBookmark new item: aGTAComputer; description: aString; yourself).
	self announcer announce: GTAItemAdded.
	^ item
]

{ #category : #adding }
GTABookmarks >> addSession: aGTASession description: aString [ 
	| item |
	item := self add: (GTASessionBookmark new item: aGTASession; description: aString; yourself).
	self announcer announce: GTAItemAdded.
	^ item
]

{ #category : #adding }
GTABookmarks >> addSomeSessions: aCollection description: aString [ 
	| item |
	item := self add: (GTASomeSessionsBookmark new
				item: aCollection;
				description: aString;
				yourself).
	self announcer announce: GTAItemAdded.
	^ item
]

{ #category : #accessing }
GTABookmarks >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #initialization }
GTABookmarks >> from: aCollection computers: aGTAComputers [
	aCollection do: [ :eachBookmarkPath | | bookmark |
		bookmark := GTABookmark from: eachBookmarkPath computers: aGTAComputers.
		self add: bookmark.
	]
]

{ #category : #testing }
GTABookmarks >> hasRelatedTo: anObject [ 
	^ self anySatisfy: [ :eachBookmark | eachBookmark isRelatedTo: anObject ]
]

{ #category : #enumerating }
GTABookmarks >> relatedTo: anObject [ 
	^ (self select: [ :eachBookmark | eachBookmark isRelatedTo: anObject ]) as: OrderedCollection
]

{ #category : #removing }
GTABookmarks >> removeBookmark: aBookmark [
	| item |
	item := self remove: aBookmark.
	self announcer announce: GTAItemRemoved.
	^ item
]

{ #category : #storing }
GTABookmarks >> save [
	GTAConfiguration saveBookmarks: self.
	self announcer announce: GTASaved
]
