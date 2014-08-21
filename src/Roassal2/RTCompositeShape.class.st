Class {
	#name : #RTCompositeShape,
	#superclass : #RTAbstractCompositeShape,
	#category : 'Roassal2-Core'
}

{ #category : #hooks }
RTCompositeShape >> trachelShapeFor: anElement [
	| s1 s2 c |
	s1 := shape1 trachelShapeFor: anElement.
	s2 := shape2 trachelShapeFor: anElement.
	c := TRCompositeShape 
			sameSizeWith: s1 with: s2.
	c offset2: offset2.
	^ c
]
