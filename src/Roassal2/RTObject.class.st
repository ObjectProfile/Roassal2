Class {
	#name : #RTObject,
	#superclass : #Object,
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTObject class >> basicNew [
	^ super basicNew
]

{ #category : #converting }
RTObject >> asGroup [
	^ RTGroup with: self

]
