Class {
	#name : #RTCenteredAttachPoint,
	#superclass : #RTAttachPoint,
	#category : #'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTCenteredAttachPoint >> endingPointOf: anEdge [
	^ (inverted ifTrue: [anEdge from] ifFalse: [anEdge to]) position
]

{ #category : #'public - hooks' }
RTCenteredAttachPoint >> startingPointOf: anEdge [
	^ (inverted ifTrue:[anEdge to] ifFalse:[anEdge from]) position
]
