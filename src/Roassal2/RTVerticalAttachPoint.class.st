Class {
	#name : #RTVerticalAttachPoint,
	#superclass : #RTAttachPoint,
	#category : #'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTVerticalAttachPoint >> endingPointOf: aRTEdge [
	^ inverted 
		ifTrue: [ aRTEdge from encompassingRectangle bottomCenter ]
		ifFalse: [ aRTEdge to encompassingRectangle topCenter ].
]

{ #category : #'public - hooks' }
RTVerticalAttachPoint >> startingPointOf: aRTEdge [
	^ inverted 
		ifTrue: [ aRTEdge to encompassingRectangle topCenter ]
		ifFalse: [ aRTEdge from encompassingRectangle bottomCenter ].

]
