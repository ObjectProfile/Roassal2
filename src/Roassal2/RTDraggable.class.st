Class {
	#name : #RTDraggable,
	#superclass : #RTAbstractDraggable,
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTDraggable class >> groupToDrag: elements [
	^ self new groupToDrag: elements
]

{ #category : #hooks }
RTDraggable >> transformDistance: distanceAsPoint forElement: anElement [
	"Nothing to be transformed since there is no restriction here"
	^ distanceAsPoint
]
