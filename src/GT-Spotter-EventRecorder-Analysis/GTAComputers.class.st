Class {
	#name : #GTAComputers,
	#superclass : #GTASomeComputers,
	#traits : 'TGTSpotterUpdateEvents',
	#classTraits : 'TGTSpotterUpdateEvents classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTAComputers >> bookmarks [
	^ self optionAt: #bookmarks ifAbsentPut: [ GTAConfiguration loadBookmarks: self ]
]

{ #category : #accessing }
GTAComputers >> computers [
	^ self
]

{ #category : #'gt-inspector-extension' }
GTAComputers >> gtInspectorBookmarksIn: composite [
	<gtInspectorPresentationOrder: 9>
	(composite table)
		title: 'Bookmarks';
		display: [ :aComputers | aComputers bookmarks ];
		column: 'Type'
			evaluated: [ :each | each typeName ]
			width: 57;
		column: 'Garbage'
			evaluated: [ :each | each garbageString ]
			width: 57;
		column: 'Description'
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each description asString ];
		act: [ :aPresentation :aComputers | aComputers saveBookmarks ]
			icon: Smalltalk ui icons glamorousSave
			entitled: 'Save bookmarks';
		selectionPopulate: #selection
			entitled: 'Open bookmark'
			with: [ :aTable | aTable rawSelection gtInspectorInterestingObject ];
		selectionAct: [ :list :bookmark | 
				self toggleGarbage: list rawSelection.
				list update ]
			entitled: 'Toggle garbage';
		selectionAct: [ :list :bookmark | 
				self removeBookmark: list rawSelection.
				list update ]
			entitled: 'Remove bookmark';
		updateOn: GTACollectionAnnouncement 
			from: [ :aComputers | aComputers bookmarks announcer ];
		send: [ :result | result ifNotNil: [ result item ] ];
		showOnly: 50 
]

{ #category : #bookmarks }
GTAComputers >> removeBookmark: aGTABookmark [ 
	self bookmarks 
		removeBookmark: aGTABookmark;
		save.
]

{ #category : #bookmarks }
GTAComputers >> saveBookmarks [
	self bookmarks ifNotEmpty: [ self bookmarks save ]
]

{ #category : #bookmarks }
GTAComputers >> toggleGarbage: aGTASessionBookmark [ 
	aGTASessionBookmark toggleGarbage.
	self saveBookmarks.
]
