Class {
	#name : #GLMAddScrollbarAction,
	#superclass : #GLMRoassal2Action,
	#category : #'Roassal2GT-Glamour-Actions'
}

{ #category : #'as yet unclassified' }
GLMAddScrollbarAction >> execute [
	self roassalView @ RTDoubleScrollBar.
	self roassalUpdate
]

{ #category : #'as yet unclassified' }
GLMAddScrollbarAction >> title [
	^ 'Add scrollbars'
]
