Class {
	#name : #RTUninterpolateNumber,
	#superclass : #RTUninterpolate,
	#category : #'Roassal2-Builder-Grapher-Scaling'
}

{ #category : #interpolating }
RTUninterpolateNumber >> uninterpolate: x [
	^ (x - a )/b
]
