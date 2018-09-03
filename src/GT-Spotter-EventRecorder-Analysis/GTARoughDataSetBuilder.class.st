Class {
	#name : #GTARoughDataSetBuilder,
	#superclass : #Object,
	#instVars : [
		'objects',
		'groups',
		'comparator',
		'gap',
		'newGroupBlock'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #adding }
GTARoughDataSetBuilder >> addToActualGroup: anObject [ 
	self ensureGroup.
	self groups last addLast: anObject.
]

{ #category : #adding }
GTARoughDataSetBuilder >> addToNewGroup: anObject [
	^ self groups add: (self newGroupObject add: anObject; yourself) 
]

{ #category : #building }
GTARoughDataSetBuilder >> build [
	| lastObject |
	lastObject := self objects first.
	self objects doWithIndex: [ :object :index |
		index > 1 
			ifTrue: [ 
				(comparator cull: object cull: lastObject) < self gap
					ifTrue: [ self addToActualGroup: object ]
					ifFalse: [ self addToNewGroup: object ] ]
			ifFalse: [ self addToNewGroup: object ].
		lastObject := object.
	 ].

]

{ #category : #accessing }
GTARoughDataSetBuilder >> comparator [
	^ comparator
]

{ #category : #accessing }
GTARoughDataSetBuilder >> comparator: anObject [
	comparator := anObject
]

{ #category : #private }
GTARoughDataSetBuilder >> ensureGroup [
	self groups ifEmpty: [ :aGroup | aGroup add: self newGroupObject ]
]

{ #category : #accessing }
GTARoughDataSetBuilder >> gap [
	^ gap
]

{ #category : #accessing }
GTARoughDataSetBuilder >> gap: anInteger [ 
	gap := anInteger
]

{ #category : #accessing }
GTARoughDataSetBuilder >> groupClass: aClass [
	self newGroupBlock: [ aClass new ]
]

{ #category : #accessing }
GTARoughDataSetBuilder >> groups [
	^ groups ifNil: [ groups := GTAGroups new ]
]

{ #category : #initialization }
GTARoughDataSetBuilder >> initialize [
	super initialize.
	comparator := [ :actualObject :previousObject | actualObject - previousObject ].
	newGroupBlock := [ GTAGroup new ].
]

{ #category : #accessing }
GTARoughDataSetBuilder >> newGroupBlock [
	^ newGroupBlock
]

{ #category : #accessing }
GTARoughDataSetBuilder >> newGroupBlock: aBlockClosure [ 
	newGroupBlock := aBlockClosure
]

{ #category : #'instance creation' }
GTARoughDataSetBuilder >> newGroupObject [
	^ self newGroupBlock value
]

{ #category : #helpers }
GTARoughDataSetBuilder >> numberOfGroups [
	^ self groups size 
]

{ #category : #accessing }
GTARoughDataSetBuilder >> objects [
	^ objects
]

{ #category : #accessing }
GTARoughDataSetBuilder >> objects: aCollection [ 
	objects := aCollection.
	groups := nil.
]

{ #category : #initialization }
GTARoughDataSetBuilder >> setSessionComparator [
	self comparator: [ :actualObject :previousObject | actualObject start - previousObject end ]
]
