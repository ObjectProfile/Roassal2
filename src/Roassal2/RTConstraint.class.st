"
A RTConstraint is a utility class that contains methods to position elements against others.

"
Class {
	#name : #RTConstraint,
	#superclass : #RTObject,
	#category : #'Roassal2-Core'
}

{ #category : #util }
RTConstraint class >> move: element above: anotherElement [
	^ element translateTo: anotherElement position - (0 @ element height)
]
