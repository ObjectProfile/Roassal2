Class {
	#name : #RTCenteredAttachPoint,
	#superclass : #RTAttachPoint,
	#category : #'Roassal2-AttachPoint'
}

{ #category : #'public - hooks' }
RTCenteredAttachPoint >> basicEndingPointOf: anEdge [
	^ anEdge to position
]

{ #category : #'public - hooks' }
RTCenteredAttachPoint >> basicStartingPointOf: anEdge [
	^ anEdge from position
]
