Class {
	#name : #RTDraggable,
	#superclass : #RTInteraction,
	#category : #Roassal2
}

{ #category : #hooks }
RTDraggable >> initializeElement: element [
	element on: TRMouseDragging do: [ :e | e element translateBy: e step. e signalUpdate ]
]
