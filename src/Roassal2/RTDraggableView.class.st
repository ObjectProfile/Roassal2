Class {
	#name : #RTDraggableView,
	#superclass : #RTInteraction,
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTDraggableView >> initializeElement: aView [
	aView canvas on: TRMouseDragging do: [ :e | aView canvas camera translateBy: e step negated. e signalUpdate ]
]

{ #category : #'as yet unclassified' }
RTDraggableView >> initializeElement: aView [
	aView canvas on: TRMouseDragging do: [ :e | aView canvas camera translateBy: e step negated. e signalUpdate ]
]
