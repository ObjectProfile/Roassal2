"
I am an interaction to translate the view as my parent.
The difference is that I only allow horizontal translations
"
Class {
	#name : #RTVerticalDraggableView,
	#superclass : #RTDraggableView,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTVerticalDraggableView >> initializeElement: aView [
	aView canvas on: TRMouseDragging do: [ :e | aView canvas camera translateBy: 0@(e step negated) y. e signalUpdate ]
]
