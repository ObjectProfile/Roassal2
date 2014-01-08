Class {
	#name : #RTDraggableView,
	#superclass : #RTInteraction,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTDraggableView >> initializeElement: aView [
	aView canvas on: TRMouseDragging do: [ :e | aView canvas camera translateBy: e step negated. e signalUpdate ]
]
