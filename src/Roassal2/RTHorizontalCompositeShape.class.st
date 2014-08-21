Class {
	#name : #RTHorizontalCompositeShape,
	#superclass : #RTAbstractCompositeShape,
	#category : 'Roassal2-Core'
}

{ #category : #hooks }
RTHorizontalCompositeShape >> trachelShapeFor: anElement [
	| s1 s2 c   center |
	s1 := shape1 trachelShapeFor: anElement.
	s2 := shape2 trachelShapeFor: anElement.
	c := TRCompositeShape 
			with: s1 
			with: s2.

	c offset1: (s2 width / 2) negated @ 0.
	c offset2: ((s1 width / 2 ) @ 0).

"	s1 translateBy: (s2 width / 2) negated @ 0.
	s2 translateBy: ((s1 width / 2 ) @ 0).
""	center := c position / 2.
	s1 translateBy: center negated.
	s2 translateBy: center negated.
"
"	s1 translateBy:  ((s2 width / 2) negated @ 0).
	s2 translateBy:  offset2 + (((s1 width / 2 ) @ 0)).
"	


"	o1 := s1 width / 2 - (s1 width + s2 width / 2).
	o2 := (s1 width ) + (s2 width / 2) - (s1 width + s2 width / 2).
	c offset1: o1 @ 0.
	c offset2: o2 @ 0.
"


	^ c
]
