Class {
	#name : #RTDraggable,
	#superclass : #RTInteraction,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTDraggable >> initializeElement: element [
	element on: TRMouseDragging do: [ :e | e element translateBy: e step. e signalUpdate ]
]

{ #category : #hooks }
RTDraggable >> initializeElement: element [
	element on: TRMouseDragging do: [ :e | e element translateBy: e step. e signalUpdate ]
]
