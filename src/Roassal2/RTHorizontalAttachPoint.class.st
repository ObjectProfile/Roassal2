Class {
	#name : #RTHorizontalAttachPoint,
	#superclass : #RTAttachPoint,
	#category : 'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTHorizontalAttachPoint >> endingPointOf: aRTEdge [
	^ aRTEdge to encompassingRectangle leftCenter

]

{ #category : #'public - hooks' }
RTHorizontalAttachPoint >> startingPointOf: aRTEdge [
	^ aRTEdge from encompassingRectangle rightCenter

]
