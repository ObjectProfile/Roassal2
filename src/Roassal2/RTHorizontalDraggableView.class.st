"
I am an interaction to translate the view as my parent.
The difference is that I only allow horizontal translations
"
Class {
	#name : #RTHorizontalDraggableView,
	#superclass : #RTDraggableView,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTHorizontalDraggableView >> initializeElement: aView [
	aView canvas on: TRMouseDragging do: [ :e | aView canvas camera translateBy: (e step negated)x @ 0. e signalUpdate ]
]
