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
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTSetEdgeAlpha >> initialize [
	super initialize.
	highAlpha := 1.0.
	lowAlpha := 0.1.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
RTSetEdgeAlpha >> setAlpha: alpha for: element [
	element connectedEdges do: [ :e | e trachelShape color: (e trachelShape color alpha: alpha) ]
]

{ #category : #'as yet unclassified' }
RTSetEdgeAlpha >> setHighAlphaFor: element [
	self setAlpha: highAlpha for: element
]

{ #category : #'as yet unclassified' }
RTSetEdgeAlpha >> setLowAlphaFor: element [
	self setAlpha: lowAlpha for: element
]
