Class {
	#name : #GLMBoxZoomAction,
	#superclass : #GLMRoassal2Action,
	#category : #'Roassal2GT-Glamour-Actions'
}

{ #category : #'as yet unclassified' }
GLMBoxZoomAction >> execute [
	| int |
	int := RTZoomableBoxView new.
	self roassalView @ int.
]

{ #category : #'as yet unclassified' }
GLMBoxZoomAction >> title [
	^ 'Add Box zoom'
]
