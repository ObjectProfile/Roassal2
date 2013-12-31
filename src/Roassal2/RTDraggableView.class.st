Class {
	#name : #RTDraggableView,
	#superclass : #RTInteraction,
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTDraggableView >> initializeElement: aView [
	aView canvas on: TRMouseDragging do: [ :e | aView canvas camera translateBy: e step negated. e signalUpdate ]
]
