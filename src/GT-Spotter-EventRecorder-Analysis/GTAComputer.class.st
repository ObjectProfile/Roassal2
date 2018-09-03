Class {
	#name : #GTAComputer,
	#superclass : #GTASomeSessions,
	#traits : 'TGTSpotterUpdateEvents',
	#classTraits : 'TGTSpotterUpdateEvents classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #api }
GTAComputer >> bookmarkIt [
	self bookmarks
		addComputer: self
		description: 'Added at ', DateAndTime now rounded asString;
		save
]

{ #category : #accessing }
GTAComputer >> bookmarks [
	^ self computers bookmarks
]

{ #category : #accessing }
GTAComputer >> computer [
	^ self
]

{ #category : #accessing }
GTAComputer >> computers [
	^ self optionAt: #computers
]

{ #category : #accessing }
GTAComputer >> computers: aCollection [ 
	^ self optionAt: #computers put: aCollection
]

{ #category : #enumerating }
GTAComputer >> differentSearchStrings [
	^ self searchStrings asSet
]

{ #category : #testing }
GTAComputer >> hasSessionsWithSpecialKeywords [
	^ self anySatisfy: #hasSpecialKeywords
]

{ #category : #testing }
GTAComputer >> hasSpecialKeywords [
	^ self anySatisfy: #hasSpecialKeywords
]

{ #category : #enumerating }
GTAComputer >> sessionsWithNumberOfInputsGreaterThen: anInteger [
	^ self select: [ :each | each numberOfContextChanged > anInteger ]
]

{ #category : #enumerating }
GTAComputer >> sessionsWithNumberOfInputsGreaterThenOne [
	^ self sessionsWithNumberOfInputsGreaterThen: 1
]

{ #category : #enumerating }
GTAComputer >> sessionsWithSpecialKeywords [
	^ self select: #hasSpecialKeywords
]

{ #category : #update }
GTAComputer >> updateEvents [
	^ self do: #updateEvents
]

{ #category : #enumerating }
GTAComputer >> userQueryOrSelectionHashes [
	^ self flatCollect: #userQueryOrSelectionHashes as: OrderedCollection
]
