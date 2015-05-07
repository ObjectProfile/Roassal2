"
I am an event for RTSelectableView
"
Class {
	#name : #RTSelectionEvent,
	#superclass : #Announcement,
	#instVars : [
		'group'
	],
	#category : #'Roassal2-Selection'
}

{ #category : #'as yet unclassified' }
RTSelectionEvent >> group [
	^ group
]

{ #category : #'as yet unclassified' }
RTSelectionEvent >> group: g [
	group := g
]
