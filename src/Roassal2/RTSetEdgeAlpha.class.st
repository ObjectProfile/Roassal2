"
A RTSetEdgeAlpha is an interaction raises the transparency of the incoming and outgoing edges for a given element when the mouse enter the element.

Instance Variables
	highAlpha:		<Object>
	lowAlpha:		<Object>

highAlpha
	- xxxxx

lowAlpha
	- xxxxx

"
Class {
	#name : #RTSetEdgeAlpha,
	#superclass : #RTInteraction,
	#instVars : [
		'highAlpha',
		'lowAlpha'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #initialization }
RTSetEdgeAlpha >> initialize [
	super initialize.
	highAlpha := 1.0.
	lowAlpha := 0.1.
]

{ #category : #hooks }
RTSetEdgeAlpha >> initializeElement: element [
	self setLowAlphaFor: element.
	element
		when: TRMouseEnter
		do: [ :e | 
			self setHighAlphaFor: element.
			e signalUpdate ].
	element
		when: TRMouseLeave
		do: [ :e | 
			self setLowAlphaFor: element.
			e signalUpdate ]
]

{ #category : #utility }
RTSetEdgeAlpha >> setAlpha: alpha for: element [
	element connectedEdges do: [ :e | e trachelShape allColor: (e trachelShape color alpha: alpha) ]
]

{ #category : #utility }
RTSetEdgeAlpha >> setHighAlphaFor: element [
	self setAlpha: highAlpha for: element
]

{ #category : #utility }
RTSetEdgeAlpha >> setLowAlphaFor: element [
	self setAlpha: lowAlpha for: element
]
