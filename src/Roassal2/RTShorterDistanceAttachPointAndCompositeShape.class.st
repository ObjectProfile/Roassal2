"
A RTShorterDistanceAttachPointAndCompositeShape assumes that the elements to be connected to or from have a composite shape
"
Class {
	#name : #RTShorterDistanceAttachPointAndCompositeShape,
	#superclass : #RTAbstractShorterDistanceAttachPoint,
	#instVars : [
		'composedShapeSelection'
	],
	#category : #'Roassal2-AttachPoint'
}

{ #category : #'public - hooks' }
RTShorterDistanceAttachPointAndCompositeShape >> attachPointsFor: anEdge on: anElement [
	"Return the four possible attach points for each of the four sides for given edge on given element."
	| rec center |
	rec := (composedShapeSelection rtValue: anElement trachelShape shapes) encompassingRectangle.
	center := rec center.
	^ Array 
		"upper side"
		with: ((center x) @ rec top)
		 "right side"
		with: (rec right @ (center y))
		"lower side"
		with: ((center x) @ rec bottom)
		"left side"
		with: (rec left @ (center y))
	
]

{ #category : #'as yet unclassified' }
RTShorterDistanceAttachPointAndCompositeShape >> composedShapeSelection: aSymbol [
	"aSymbol can be #first, #second, #third, or a one arg block"
	"The argument is used to select which of the shapes in the composed shape of the element to pick"
	composedShapeSelection := aSymbol
]

{ #category : #initialization }
RTShorterDistanceAttachPointAndCompositeShape >> initialize [
	super initialize.
	composedShapeSelection := #first
]
