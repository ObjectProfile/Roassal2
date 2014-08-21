Class {
	#name : #RTDraggable,
	#superclass : #RTInteraction,
	#instVars : [
		'groupToDrag'
	],
	#category : 'Roassal2-Core'
}

{ #category : #public }
RTDraggable class >> groupToDrag: elements [
	^ self new groupToDrag: elements
]

{ #category : #accessing }
RTDraggable >> groupToDrag [
	"Return the elements to drag and drop"
	^ groupToDrag
]

{ #category : #accessing }
RTDraggable >> groupToDrag: elements [
	"Set the elements to drag and drop. The variable groupToDrag is initialized with an empty array."
	groupToDrag := elements
]

{ #category : #initialization }
RTDraggable >> initialize [
	super initialize.
	groupToDrag := #()
]

{ #category : #hooks }
RTDraggable >> initializeElement: element [
	element when: TRMouseDragging do: [ :e | 
		| d t |
		t := RTGroup withAll: groupToDrag.
		(t includes: element) ifFalse: [ t add: element ].
		d := element view canvas camera distanceFromPixelToSpace: e step.
		t translateBy: d. 
		e signalUpdate ].
	
"	element when: TRMouseDragging do: [ :e | e element translateBy: e step. e signalUpdate ]"
]
