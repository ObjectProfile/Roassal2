Class {
	#name : #RTUninterpolateClamp,
	#superclass : #RTUninterpolate,
	#category : #'Roassal2-Builder-Grapher-Scaling'
}

{ #category : #interpolating }
RTUninterpolateClamp >> uninterpolate: x [
	^ 0 max: (1 min: ((x - a ) / b))
]
