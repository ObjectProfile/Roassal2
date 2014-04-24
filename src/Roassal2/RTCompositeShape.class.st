Class {
	#name : #RTCompositeShape,
	#superclass : #RTAbstractCompositeShape,
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTCompositeShape class >> with: s1 with: s2 [
	^ self new shape1: s1; shape2: s2; yourself
]
