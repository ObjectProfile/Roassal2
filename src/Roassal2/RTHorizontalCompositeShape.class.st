Class {
	#name : #RTHorizontalCompositeShape,
	#superclass : #RTAbstractCompositeShape,
	#category : #'Roassal2-Core'
}

{ #category : #hooks }
RTHorizontalCompositeShape >> trachelShapeFor: anElement [
	| s1 s2 c |
	s1 := shape1 trachelShapeFor: anElement.
	s2 := shape2 trachelShapeFor: anElement.
	c := TRCompositeShape 
			with: s1 
			with: s2.
"	c offset1: (s1 width / 2) negated @ 0."
"	c offset2: (s2 width / 2) @ 0."
	^ c
]
