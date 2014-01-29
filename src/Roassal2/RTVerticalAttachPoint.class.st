Class {
	#name : #RTVerticalAttachPoint,
	#superclass : #RTAttachPoint,
	#category : #'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTVerticalAttachPoint >> endingPointOf: aRTEdge [
	^ (aRTEdge to position 
		- (0 @ (aRTEdge from height / 2))) asIntegerPoint
]

{ #category : #'public - hooks' }
RTVerticalAttachPoint >> startingPointOf: aRTEdge [
	^ (aRTEdge from position 
		+ (0 @ (aRTEdge from height / 2))) asIntegerPoint
]
