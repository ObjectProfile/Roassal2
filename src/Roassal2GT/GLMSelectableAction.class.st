Class {
	#name : #GLMSelectableAction,
	#superclass : #GLMRoassal2Action,
	#category : #'Roassal2GT-Glamour-Actions'
}

{ #category : #'as yet unclassified' }
GLMSelectableAction >> execute [
	self roassalView @ RTSelectableView
]

{ #category : #'as yet unclassified' }
GLMSelectableAction >> title [
	^ 'Add selection'
]
