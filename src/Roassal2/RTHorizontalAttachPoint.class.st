Class {
	#name : #RTHorizontalAttachPoint,
	#superclass : #RTAttachPoint,
	#category : #'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTHorizontalAttachPoint >> endingPointOf: aRTEdge [
	^ (aRTEdge to position 
		- ((aRTEdge from width / 2) @ 0)) asIntegerPoint
]

{ #category : #'public - hooks' }
RTHorizontalAttachPoint >> startingPointOf: aRTEdge [
	^ (aRTEdge from position 
		+ ((aRTEdge from width / 2) @ 0)) asIntegerPoint
]
