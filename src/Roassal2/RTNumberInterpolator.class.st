Class {
	#name : #RTNumberInterpolator,
	#superclass : #RTInterpolator,
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTNumberInterpolator >> interpolate: t [
	^ (start * (1 - t)) + (stop * t).
]
