Class {
	#name : #RTCenteredAttachPoint,
	#superclass : #RTAttachPoint,
	#category : 'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTCenteredAttachPoint >> endingPointOf: anEdge [
	^ anEdge to position asIntegerPoint
]

{ #category : #'public - hooks' }
RTCenteredAttachPoint >> startingPointOf: anEdge [
	^ anEdge from position asIntegerPoint
]
