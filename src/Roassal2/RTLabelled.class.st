"
This class is here for compatibility.
"
Class {
	#name : #RTLabelled,
	#superclass : #RTLabeled,
	#category : #'Roassal2-Interactions'
}

{ #category : #'instance creation' }
RTLabelled class >> new [
	self error: 'RTLabelled is deprecated. Please use RTLabeled'.
	^ super new
]
