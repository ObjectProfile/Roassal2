Class {
	#name : #RTUnoptimizedComposer,
	#superclass : #RTComposer,
	#category : #'Roassal2-Builder-Composer'
}

{ #category : #'as yet unclassified' }
RTUnoptimizedComposer >> group [
	^ self group: ('group', (mapping size asString)) asSymbol
]

{ #category : #'as yet unclassified' }
RTUnoptimizedComposer >> group: aName [
	"Compute the group of added objects"
	| group |
	group := self newElementsAsGroup.
	groups add: group.
	mapping at: aName put: group.
]

{ #category : #'as yet unclassified' }
RTUnoptimizedComposer >> newElementsAsGroup [
	^ RTGroup withAll: (view elements copyWithoutAll: self allGroupedElements)
]
