Class {
	#name : #RTDraggable,
	#superclass : #RTInteraction,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTDraggable >> initializeElement: element [
	element when: TRMouseDragging do: [ :e | 
		| d |
		d := element view canvas camera distanceFromPixelToSpace: e step.
		e element translateBy: d. e signalUpdate ].
	
"	element when: TRMouseDragging do: [ :e | e element translateBy: e step. e signalUpdate ]"
]
