Class {
	#name : #RTDraggableChildren,
	#superclass : #RTInteraction,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTDraggableChildren >> initializeElement: element [
	| recursiveDrag |
	recursiveDrag := [ :elem :step :ancestor |
		elem outgoingEdges do: [ :edge |
			(edge to = ancestor) ifFalse: [
				recursiveDrag value: edge to value: step value: ancestor ] ].
		elem translateBy: step ].
	
	element when: TRMouseDragging do: [ :e |
		recursiveDrag value: e element value: e step value: e element. e signalUpdate ]
]
