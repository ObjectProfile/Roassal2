Class {
	#name : #GTADetachedBookmark,
	#superclass : #GTAEmptyBookmark,
	#instVars : [
		'path'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Bookmarks'
}

{ #category : #accessing }
GTADetachedBookmark >> description [
	^ String streamContents: [ :aStream |
		aStream 
			nextPutAll: 'Not found bookmark of ';
			print: self path
		 ]
]

{ #category : #initialization }
GTADetachedBookmark >> from: aCollection computers: aGTAComputers [ 
	self shouldNotImplement 
]

{ #category : #accessing }
GTADetachedBookmark >> garbageString [
	^ ''
]

{ #category : #testing }
GTADetachedBookmark >> isRelatedTo: anObject [
	^ false
]

{ #category : #accessing }
GTADetachedBookmark >> item [
	^ self path
]

{ #category : #accessing }
GTADetachedBookmark >> path [
	^ path
]

{ #category : #accessing }
GTADetachedBookmark >> path: aPathCollection [
	path := aPathCollection
]

{ #category : #api }
GTADetachedBookmark >> toggleGarbage [
	"do nothing"
]

{ #category : #accessing }
GTADetachedBookmark >> typeName [
	^ 'detached'
]
