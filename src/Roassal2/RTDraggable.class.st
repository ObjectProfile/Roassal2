Class {
	#name : #RTDraggable,
	#superclass : #RTInteraction,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTDraggable >> initializeElement: element [
	element on: TRMouseDragging do: [ :e | Halt once. e element translateBy: e step. e signalUpdate ]
]
