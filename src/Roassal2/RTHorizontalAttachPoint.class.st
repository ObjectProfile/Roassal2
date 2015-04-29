Class {
	#name : #RTHorizontalAttachPoint,
	#superclass : #RTAttachPoint,
	#category : #'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTHorizontalAttachPoint >> endingPointOf: aRTEdge [
	^ inverted 
		ifTrue: [ aRTEdge from encompassingRectangle rightCenter ]
		ifFalse: [ aRTEdge to encompassingRectangle leftCenter ].

]

{ #category : #'public - hooks' }
RTHorizontalAttachPoint >> startingPointOf: aRTEdge [
	^ inverted 
		ifTrue: [ aRTEdge to encompassingRectangle leftCenter ] 
		ifFalse: [ aRTEdge from encompassingRectangle rightCenter]

]
