"
A RTDraggableChildren makes an element draggable. When dragged, children of the elements are also being dragged.
"
Class {
	#name : #RTDraggableChildren,
	#superclass : #RTInteraction,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTDraggableChildren >> initializeElement: element [
	| recursiveDrag set |
	
	set := Set new.
	
	recursiveDrag := [ :elem :ancestor|
		set add: elem.
		elem outgoingEdges do: [ :edge |
			(edge to = ancestor) ifFalse: [
				recursiveDrag value: edge to value: ancestor].
			].
		].
	
	element when: TRMouseDragging do: [ :e |
		recursiveDrag value: e element value: e element. e signalUpdate.
		set do: [ :e1 | e1 translateBy: e step ].
		 ]
	
]
