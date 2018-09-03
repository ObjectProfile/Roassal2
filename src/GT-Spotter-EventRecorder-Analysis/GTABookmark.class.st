Class {
	#name : #GTABookmark,
	#superclass : #GTAEmptyBookmark,
	#instVars : [
		'item',
		'description',
		'dateAndTime',
		'garbage'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Bookmarks'
}

{ #category : #'instance creation' }
GTABookmark class >> from: pathCollection computers: aGTAComputers [ 
	^ pathCollection first new from: pathCollection computers: aGTAComputers
]

{ #category : #accessing }
GTABookmark >> dateAndTime [
	^ dateAndTime
]

{ #category : #accessing }
GTABookmark >> dateAndTime: anObject [
	dateAndTime := anObject
]

{ #category : #accessing }
GTABookmark >> description [
	^ description
]

{ #category : #accessing }
GTABookmark >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GTABookmark >> garbage [
	^ garbage
]

{ #category : #accessing }
GTABookmark >> garbage: aBoolean [
	garbage := aBoolean
]

{ #category : #accessing }
GTABookmark >> garbageString [
	^ self garbage
		ifTrue: 'yes'
		ifFalse: 'no'
]

{ #category : #initialization }
GTABookmark >> initialize [
	super initialize.
	dateAndTime := DateAndTime now.
	garbage := false.
]

{ #category : #testing }
GTABookmark >> isRelatedTo: anObject [ 
	^ self item = anObject 
]

{ #category : #accessing }
GTABookmark >> item [
	^ item
]

{ #category : #accessing }
GTABookmark >> item: anObject [
	item := anObject
]

{ #category : #'instance creation' }
GTABookmark >> newDetachedBookmark: aPathCollection [
	^ GTADetachedBookmark new
			path: aPathCollection;
			yourself
]

{ #category : #api }
GTABookmark >> toggleGarbage [
	self garbage: self garbage not
]
