Class {
	#name : #RTVisitor,
	#superclass : #RTObject,
	#category : #'Roassal2-Core'
}

{ #category : #visitor }
RTVisitor >> visitCanvas: aCanvas [
]

{ #category : #visitor }
RTVisitor >> visitView: aView [
	aView canvas accept: self
]
