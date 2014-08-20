"
A RTEventForwarder is used to forward event from one element to other elements
"
Class {
	#name : #RTEventForwarder,
	#superclass : #RTInteraction,
	#instVars : [
		'toObject',
		'eventClass'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTEventForwarder >> initialize [
	super initialize.
	eventClass := TREvent. 
	toObject := [ :element | element view ]
]

{ #category : #'as yet unclassified' }
RTEventForwarder >> initializeElement: element [
	element
		when: eventClass
		do: [ :e | 
			(toObject rtValue: element) announce: e ]
]
