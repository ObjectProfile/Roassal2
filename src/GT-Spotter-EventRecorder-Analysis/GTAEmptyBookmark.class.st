Class {
	#name : #GTAEmptyBookmark,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Bookmarks'
}

{ #category : #initialization }
GTAEmptyBookmark >> from: aCollection computers: aGTAComputers [ 
	self subclassResponsibility
]

{ #category : #testing }
GTAEmptyBookmark >> isRelatedTo: anObject [
	^ self subclassResponsibility
]

{ #category : #accessing }
GTAEmptyBookmark >> path [
	^ self subclassResponsibility.
]

{ #category : #api }
GTAEmptyBookmark >> toggleGarbage [
	self subclassResponsibility
]

{ #category : #accessing }
GTAEmptyBookmark >> typeName [
	^ self subclassResponsibility
]
