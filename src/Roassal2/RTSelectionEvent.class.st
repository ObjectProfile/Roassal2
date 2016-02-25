"
I am an event for RTSelectableView
"
Class {
	#name : #RTSelectionEvent,
	#superclass : #TRUserInputEvent,
	#instVars : [
		'group'
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
