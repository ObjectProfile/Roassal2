Class {
	#name : #RTShorterDistanceAttachPoint,
	#superclass : #RTAttachPoint,
	#instVars : [
		'offset'
	],
	#category : #'Roassal2-Core'
}

{ #category : #util }
RTShorterDistanceAttachPoint >> attachPointFor: anEdge on: anElement with: elementsPossibleAttachPoints [
	"Returns the attach point having the shortest route for given edge on given element."
	| p dp t |
	p := anElement encompassingRectangle bottomRight.
	
	"We get the list of dot products"
	dp := elementsPossibleAttachPoints collect: [ :pp | 
		t := p - pp.
		Array with: (t dotProduct: t) with:  pp ].
	
	"We look for the shortest path and return the point"
	^ (dp inject: dp first into: [ :shorter :el | (shorter first < el first) ifTrue: [ shorter ] ifFalse: [ el ]]) second
]

{ #category : #util }
RTShorterDistanceAttachPoint >> attachPointsFor: anEdge on: anElement [
	"Return the four possible attach points for each of the four sides for given edge on given element."
	| rec center |
	rec := anElement encompassingRectangle.
	center := rec center.
	^ Array 
		"upper side"
		with: ((center x + offset) @ rec top) asIntegerPoint
		 "right side"
		with: (rec right @ (center y + offset)) asIntegerPoint
		"lower side"
		with: ((center x + offset) @ rec bottom) asIntegerPoint
		"left side"
		with: (rec left @ (center y + offset)) asIntegerPoint
	
]

{ #category : #util }
RTShorterDistanceAttachPoint >> destinationAttachPointsFor: anEdge [
	"Return the four possible attach points for each of the four sides for this edges destination node."
	^ self attachPointsFor: anEdge on: (anEdge to).
]

{ #category : #'public - hooks' }
RTShorterDistanceAttachPoint >> endingPointOf: anEdge [
	^ self attachPointFor: anEdge on: (anEdge from) with: (self destinationAttachPointsFor: anEdge).
]

{ #category : #initialization }
RTShorterDistanceAttachPoint >> initialize [
	super initialize.
	offset := 0.
]

{ #category : #accessing }
RTShorterDistanceAttachPoint >> offset [
	^ offset
]

{ #category : #accessing }
RTShorterDistanceAttachPoint >> offset: anObject [
	offset := anObject
]

{ #category : #util }
RTShorterDistanceAttachPoint >> startingAttachPointsFor: anEdge [
	"Return the four possible attach points for each of the four sides for this edges starting node."
	^ self attachPointsFor: anEdge on: (anEdge from).
]

{ #category : #'public - hooks' }
RTShorterDistanceAttachPoint >> startingPointOf: anEdge [
	^ self attachPointFor: anEdge on: (anEdge to) with: (self startingAttachPointsFor: anEdge).
]
