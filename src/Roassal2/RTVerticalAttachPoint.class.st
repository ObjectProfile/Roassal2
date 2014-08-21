Class {
	#name : #RTVerticalAttachPoint,
	#superclass : #RTAttachPoint,
	#category : 'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTVerticalAttachPoint >> endingPointOf: aRTEdge [
	^ aRTEdge to encompassingRectangle topCenter
]

{ #category : #'public - hooks' }
RTVerticalAttachPoint >> startingPointOf: aRTEdge [
	^ aRTEdge from encompassingRectangle bottomCenter

]
