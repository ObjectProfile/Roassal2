Class {
	#name : #RTUninterpolateNumber,
	#superclass : #RTUninterpolate,
	#category : #'Roassal2-Scaling'
}

{ #category : #interpolating }
RTUninterpolateNumber >> uninterpolate: x [
	^ (x - a )/b
]
