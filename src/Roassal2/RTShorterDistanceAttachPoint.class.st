Class {
	#name : #RTShorterDistanceAttachPoint,
	#superclass : #RTAbstractShorterDistanceAttachPoint,
	#category : 'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTShorterDistanceAttachPoint >> attachPointsFor: anEdge on: anElement [
	"Return the four possible attach points for each of the four sides for given edge on given element."
	| rec center |
	rec := anElement encompassingRectangle.
	center := rec center.
	^ Array 
		"upper side"
		with: ((center x) @ rec top) asIntegerPoint
		 "right side"
		with: (rec right @ (center y)) asIntegerPoint
		"lower side"
		with: ((center x) @ rec bottom) asIntegerPoint
		"left side"
		with: (rec left @ (center y)) asIntegerPoint
	
]
