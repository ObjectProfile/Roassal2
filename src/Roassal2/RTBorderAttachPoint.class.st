"
I am an attach point that will end the line on the border of the end shapes.

Unline ContinuousAttachPoint & co. you don't need to care about what the end shape is, as long as it is one of the basic shapes.

Supported shapes:
	- Box
	-RoundedBox
	- Ellipse/Circle

Todo:
	- Polygon

Supported lines:
	- Line (straight line)

Todo:
	- MultiLine
	- BezierLine
"
Class {
	#name : #RTBorderAttachPoint,
	#superclass : #RTAttachPoint,
	#instVars : [
		'offset'
	],
	#category : #'Roassal2-AttachPoint'
}

{ #category : #'public - hooks' }
RTBorderAttachPoint >> basicEndingPointOf: anEdge [
	^ self basicPointFrom: anEdge to to: anEdge from of: anEdge
]

{ #category : #'public - hooks' }
RTBorderAttachPoint >> basicPointFrom: fromElement to: toElement of: anEdge [
	| source target line shift |
	source := self geometryFor: fromElement.
	target := self geometryFor: toElement.
	shift := self offsetNormalFor: anEdge.
	line := GLineSegment from: source center to: target center.
	shift := line vector normal * shift.
	anEdge from = toElement
		ifTrue: [ shift := shift * -1 ].
	line := GLineSegment from: source center + shift to: target center + shift.
	^ self borderPointFrom: source to: target via: line
]

{ #category : #'public - hooks' }
RTBorderAttachPoint >> basicStartingPointOf: anEdge [
	^ self basicPointFrom: anEdge from to: anEdge to of: anEdge
]

{ #category : #'public - hooks' }
RTBorderAttachPoint >> borderPointFrom: aSource to: aTarget via: aLine [
	^ ((aLine intersect: aSource) detectMin: [ :p | p dist: aLine to ])
		ifNil: [ aSource center ]
]

{ #category : #accessing }
RTBorderAttachPoint >> geometryFor: anElement [
	| shape rect |
	shape := anElement trachelShape.
	shape class = TRCompositeShape
		ifTrue: [ shape := shape shapes first ].
	shape class = TREllipseShape ifTrue: [ 
		rect := shape encompassingRectangle.
		^ GEllipse center: anElement position a: rect width*0.5 b: rect height*0.5 ].
	shape class = TRRoundedBoxShape ifTrue: [ 
		rect := shape encompassingRectangle.
		rect := GRectangle origin: rect origin corner: rect corner.
		^ GRoundedRectangle rectangle: rect borderRadius: shape borderRadius ].
	shape class = TRPolygonShape ifTrue: [ 
		^ GPolygon newVertices: shape vertices ].
	rect := shape encompassingRectangle.
	^ GRectangle origin: rect origin corner: rect corner
]

{ #category : #initialization }
RTBorderAttachPoint >> initialize [
	super initialize.
	offset := 5
]

{ #category : #accessing }
RTBorderAttachPoint >> offset: aNumber [
	offset := aNumber
]

{ #category : #'public - hooks' }
RTBorderAttachPoint >> offsetNormalFor: anEdge [
	"Return the offset in case of multiple edges with the same starting and ending points"

	| indexOfEdge multipleEdges |
	multipleEdges := OrderedCollection new.
	multipleEdges
		addAll:
			(anEdge to connectedEdges
				select: [ :e | e from == anEdge from and: [ e to == anEdge to ] ]).
	multipleEdges
		addAll:
			(anEdge to connectedEdges
				select: [ :e | e to == anEdge from and: [ e from == anEdge to ] ]).
	multipleEdges size <= 1
		ifTrue: [ ^ 0 @ 0 ].
	indexOfEdge := multipleEdges indexOf: anEdge.
	^ (indexOfEdge - 1 - (multipleEdges size / 2)) * offset
]
