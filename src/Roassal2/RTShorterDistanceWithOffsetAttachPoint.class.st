Class {
	#name : #RTShorterDistanceWithOffsetAttachPoint,
	#superclass : #RTAbstractShorterDistanceAttachPoint,
	#instVars : [
		'offset'
	],
	#category : 'Roassal2-Core'
}

{ #category : #'public - hooks' }
RTShorterDistanceWithOffsetAttachPoint >> attachPointsFor: anEdge on: anElement [
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

{ #category : #'as yet unclassified' }
RTShorterDistanceWithOffsetAttachPoint >> endingPointOf: anEdge [
	^ (super endingPointOf: anEdge) + (self offsetNormalFor: anEdge)
]

{ #category : #initialization }
RTShorterDistanceWithOffsetAttachPoint >> initialize [
	super initialize.
	offset := 5.
]

{ #category : #accessing }
RTShorterDistanceWithOffsetAttachPoint >> offset [
	^ offset
]

{ #category : #accessing }
RTShorterDistanceWithOffsetAttachPoint >> offset: anInteger [
	"In case fromElement and toElement have more than one edge between the same two extremities, offset is the distance between lines"
	offset := anInteger
]

{ #category : #'as yet unclassified' }
RTShorterDistanceWithOffsetAttachPoint >> offsetNormalFor: anEdge [
	"Return the offset in case of multiple edges with the same starting and ending points"
	| indexOfEdge multipleEdges |
	multipleEdges := anEdge to connectedEdges select: [ :e | 
		((e from == anEdge from) and: [ e to == anEdge to ]) or: 
			[ (e to == anEdge from) and: [ e from == anEdge to ] ]
		].	

	multipleEdges size <= 1 ifTrue: [ ^ 0 @ 0 ].
	indexOfEdge := multipleEdges indexOf: anEdge.
"	indexOfEdge even
		ifTrue: [ indexOfEdge := 1 + indexOfEdge / -2 ].
"	^ indexOfEdge * offset * (anEdge to position - anEdge from position) normal
]

{ #category : #'as yet unclassified' }
RTShorterDistanceWithOffsetAttachPoint >> startingPointOf: anEdge [
	^ (super startingPointOf: anEdge) + (self offsetNormalFor: anEdge)
]
