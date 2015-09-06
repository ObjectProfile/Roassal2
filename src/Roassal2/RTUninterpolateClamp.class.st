Class {
	#name : #RTUninterpolateClamp,
	#superclass : #RTUninterpolate,
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTUninterpolateClamp >> uninterpolate: x [
	^ 0 max: (1 min: ((x -a )/ b))
]
