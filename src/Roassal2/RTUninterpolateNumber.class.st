Class {
	#name : #RTUninterpolateNumber,
	#superclass : #RTUninterpolate,
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTUninterpolateNumber >> uninterpolate: x [
	^ (x - a )/b
]
