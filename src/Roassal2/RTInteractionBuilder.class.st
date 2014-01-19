Class {
	#name : #RTInteractionBuilder,
	#superclass : #RTObject,
	#instVars : [
		'interactions'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'as yet unclassified' }
RTInteractionBuilder >> draggable [
	| i |
	i := RTDraggable new.
	interactions add: i. 
	^ i
]

{ #category : #'as yet unclassified' }
RTInteractionBuilder >> initialize [
	super initialize.
	interactions := OrderedCollection new
]

{ #category : #'as yet unclassified' }
RTInteractionBuilder >> popup [
	| i |
	i := RTPopup new.
	interactions add: i. 
	^ i
]

{ #category : #'as yet unclassified' }
RTInteractionBuilder >> setUpElements: elements [
	"elements is an RTGroup, that contains RTElement or RTEdges"
	
	interactions do: [ :int | elements @ int ]
]
