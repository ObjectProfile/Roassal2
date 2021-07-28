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
	#category : #'Roassal2-Core-AttachPoint'
}

{ #category : #'public - hooks' }
RTBorderAttachPoint >> basicEndingPointOf: anEdge [
	^ self basicPointFrom: anEdge to to: anEdge from of: anEdge
]

{ #category : #'public - hooks' }
RTBorderAttachPoint >> basicPointFrom: fromElement to: toElement of: anEdge [
	| source target line shift vector unit res |
	source := self geometryFor: fromElement.
	target := self geometryFor: toElement.
	shift := self offsetNormalFor: anEdge.
	line := GLine through: source center and: target center.
	vector := line v2 asPoint - line v1 asPoint.
	vector := vector x @ vector y.
	unit := vector / (vector r max: 1).
	
	shift := vector normal * shift.
	anEdge from = toElement
		ifTrue: [ shift := shift * -1 ].
	line := GLine
		through: source center asPoint + shift
		and: target center asPoint + shift.
	res := self borderPointFrom: source to: target via: line.
	^ res asPoint
]

{ #category : #'public - hooks' }
RTBorderAttachPoint >> basicStartingPointOf: anEdge [
	^ self basicPointFrom: anEdge from to: anEdge to of: anEdge
]

{ #category : #'public - hooks' }
RTBorderAttachPoint >> borderPointFrom: aSource to: aTarget via: aLine [
	^ ((aLine intersectionsWith: aSource) detectMin: [ :p | p asPoint distanceTo: aLine v2 ])
		ifNil: [ aSource center ]
]

{ #category : #accessing }
RTBorderAttachPoint >> geometryFor: anElement [
	"using double dispatch to retrieve the geometry"
	^ anElement geometry
	"anElement isMultiElement
		ifTrue: [ ^ anElement geometryFor: anElement ].
	(anElement shape isKindOf: RTEllipse)
		ifTrue: [ ^ GEllipse center: anElement position a: anElement width / 2 b: anElement height / 2 ].
	(anElement shape isKindOf: RTRoundedBox)
		ifTrue: [ | rect r |
			r := anElement shape borderRadiusFor: anElement.
			rect := GRectangle
				origin: anElement encompassingRectangle origin
				corner: anElement encompassingRectangle corner.
			^ GRoundedRectangle rectangle: rect borderRadius: r ].
	^ GRectangle
		origin: anElement encompassingRectangle origin
		corner: anElement encompassingRectangle corner"
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
