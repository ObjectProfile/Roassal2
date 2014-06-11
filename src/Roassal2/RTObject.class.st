Class {
	#name : #RTObject,
	#superclass : #Object,
	#category : #'Roassal2-Core'
}

{ #category : #converting }
RTObject >> asGroup [
	^ RTGroup with: self

]
