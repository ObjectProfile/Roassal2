Class {
	#name : #RTZoomOutMove,
	#superclass : #RTAbstractZoomMove,
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTZoomOutMove >> step [
	^ 0.2 negated
]
