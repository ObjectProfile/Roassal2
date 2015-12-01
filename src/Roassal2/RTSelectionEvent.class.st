"
I am an event for RTSelectableView
"
Class {
	#name : #RTSelectionEvent,
	#superclass : #Announcement,
	#instVars : [
		'group',
		'shape'
	],
	#category : #'Roassal2-Selection'
}

{ #category : #accessing }
RTSelectionEvent >> group [
	^ group
]

{ #category : #accessing }
RTSelectionEvent >> group: g [
	group := g
]

{ #category : #accessing }
RTSelectionEvent >> shape [
	^ shape
]

{ #category : #accessing }
RTSelectionEvent >> shape: s [
	shape := s.
]
