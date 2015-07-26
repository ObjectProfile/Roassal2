Class {
	#name : #RTDraggableView,
	#superclass : #RTAbstractDraggableView,
	#category : #'Roassal2-Interactions'
}

{ #category : #hooks }
RTDraggableView >> initializeElement: aView [
	aView canvas when: TRMouseDragging do: [ :e |
		aView canvas camera translateBy: e step negated / aView canvas camera scale.
		e signalUpdate ]
]
