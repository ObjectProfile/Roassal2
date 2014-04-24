Class {
	#name : #RTVerticalCompositeShape,
	#superclass : #RTAbstractCompositeShape,
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTVerticalCompositeShape >> trachelShapeFor: anElement [
	| s1 s2 c |
	s1 := shape1 trachelShapeFor: anElement.
	s2 := shape2 trachelShapeFor: anElement.
	c := TRCompositeShape 
			with: s1 
			with: s2.
	c offset2: (0 @ ((s1 height / 2) + (s2 height / 2))).
	^ c
]
