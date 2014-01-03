"
A ROInteraction is xxxxxxxxx.

"
Class {
	#name : #RTInteraction,
	#superclass : #RTObject,
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTInteraction class >> initializeElement: element [
	^ self new initializeElement: element; yourself
]

{ #category : #public }
RTInteraction class >> initializeElement: element [
	^ self new initializeElement: element; yourself
]

{ #category : #hooks }
RTInteraction >> initializeElement: element [
	self subclassResponsibility 
]

{ #category : #hooks }
RTInteraction >> initializeElement: element [
	self subclassResponsibility 
]
