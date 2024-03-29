"
A DCLineSegment is line from 'from' point to 'to' point
"
Class {
	#name : #RTLineSegment,
	#superclass : #RTObject,
	#instVars : [
		'from',
		'to'
	],
	#category : #'Roassal2-Core-AttachPoint'
}

{ #category : #'instance-creation' }
RTLineSegment class >> from: fromPoint to: toPoint [
	^ self new
		from: fromPoint to: toPoint;
		yourself
]

{ #category : #comparing }
RTLineSegment >> = anotherSegment [
	"Answer true if the receiver's species, from and to matches anotherSegment."

	^ self species = anotherSegment species
		ifTrue: [ ^ from = anotherSegment from and: [ to = anotherSegment to ] ]
		ifFalse: [ ^ false ]
]

{ #category : #'line forms' }
RTLineSegment >> a [
	"value from normal form (ax + by + c) of line on which line segment lies on"

	^ to y - from y
]

{ #category : #geometry }
RTLineSegment >> angleInDeg [
	^ self vector degrees
]

{ #category : #geometry }
RTLineSegment >> angleInRad [
	^ self angleInDeg degreesToRadians
]

{ #category : #'line forms' }
RTLineSegment >> b [
	"value from normal form (ax + by + c) of line on which line segment lies on"

	^ from x - to x
]

{ #category : #accessing }
RTLineSegment >> bottom [
	^ from y < to y
		ifTrue: [ from ]
		ifFalse: [ to ]
]

{ #category : #'line forms' }
RTLineSegment >> c [
	"value from normal form (ax + by + c) of line on which line segment lies on"

	^ (self a * from x + (self b * from y)) negated
]

{ #category : #geometry }
RTLineSegment >> cotan [
	| vector |
	vector := self vector.
	vector y isZero
		ifTrue: [ ^ nil ].
	^ vector x / vector y
]

{ #category : #accessing }
RTLineSegment >> from [
	^ from
]

{ #category : #accessing }
RTLineSegment >> from: fromPoint [
	from := fromPoint
]

{ #category : #accessing }
RTLineSegment >> from: fromPoint to: toPoint [
	from := fromPoint.
	to := toPoint.  
]

{ #category : #comparing }
RTLineSegment >> hash [
	"Hash is reimplemented because = is implemented."

	^ from hash bitXor: to hash
]

{ #category : #initialization }
RTLineSegment >> initialize [
	super initialize.
	from := 0 @ 0.
	to := 0 @ 0
]

{ #category : #private }
RTLineSegment >> intersectHorizontal: other [
	"Intersection with other line segment. Self must be horizontal (optimization purposes)"

	| pt |
	(pt := self intersectHorizontalLine: other) ifNil: [ ^ nil ].
	pt x < self left x | (pt x > self right x) | (pt y < other bottom y) | (pt y > other top y)
		ifTrue: [ ^ nil ].
	^ pt
]

{ #category : #private }
RTLineSegment >> intersectHorizontalLine: other [
	"point of intersection of line on which line segment lies with line of other line segment or nil if parallel. Self must be horizontal (optimization purposes)"

	| x y vector |
	vector := other vector.
	vector y isZero
		ifTrue: [ ^ nil ].
	y := self from y.
	x := (self from y - other from y) * other cotan + other from x.
	^ x @ y
]

{ #category : #comparing }
RTLineSegment >> intersectLines: other [
	"point of intersection of line on which line segment lies with line of other line segment or nil if parallel"

	| det x y |
	self isHorizontal
		ifTrue: [ ^ self intersectHorizontalLine: other ].
	self isVertical
		ifTrue: [ ^ self intersectVerticalLine: other ].
	det := self a * other b - (other a * self b).
	det isZero
		ifTrue: [ ^ nil ].
	x := (self b * other c - (other b * self c)) / det.
	y := (other a * self c - (self a * other c)) / det.
	^ x @ y
]

{ #category : #comparing }
RTLineSegment >> intersectRectangle: aRectangle [
	"collection of points of intersection with not rotated rectangle"

	| pts bottomLeft bottomRight topLeft topRight |
	bottomLeft := aRectangle bottomLeft.
	bottomRight := aRectangle bottomRight.
	topLeft := aRectangle topLeft.
	topRight := aRectangle topRight.
	pts := Set new.
	pts add: ((self class from: topLeft to: topRight) intersectHorizontal: self).
	pts add: ((self class from: bottomLeft to: bottomRight) intersectHorizontal: self).
	pts add: ((self class from: topLeft to: bottomLeft) intersectVertical: self).
	pts add: ((self class from: topRight to: bottomRight) intersectVertical: self).
	pts remove: nil ifAbsent: [  ].
	^ pts
]

{ #category : #private }
RTLineSegment >> intersectVertical: other [
	"Intersection with other line segment. Self must be vertical (optimization purposes)"

	| pt |
	pt := self transposed intersectHorizontal: other transposed.
	pt ifNil: [ ^ nil ].
	^ pt transposed
]

{ #category : #private }
RTLineSegment >> intersectVerticalLine: other [
	"point of intersection of line on which line segment lies with line of other line segment or nil if parallel. Self must be vertical (optimization purposes)"

	| pt |
	pt := self transposed intersectHorizontalLine: other transposed.
	pt ifNil: [ ^ nil ].
	^ pt transposed
]

{ #category : #comparing }
RTLineSegment >> intersection: other [
	"point of intersection with other line segment or nil if it does not exists"

	| intersection |
	self isHorizontal
		ifTrue: [ ^ self intersectHorizontal: other ].
	self isVertical
		ifTrue: [ ^ self intersectVertical: other ].
	intersection := self intersectLines: other.
	intersection ifNil: [ ^ nil ].
	(intersection onLineFrom: self from to: self to) & (intersection onLineFrom: other from to: other to)
		ifFalse: [ ^ nil ].
	^ intersection
]

{ #category : #testing }
RTLineSegment >> isHorizontal [
	^ from y = to y
]

{ #category : #testing }
RTLineSegment >> isVertical [
	^ from x = to x
]

{ #category : #accessing }
RTLineSegment >> left [
	^ from x < to x
		ifTrue: [ from ]
		ifFalse: [ to ]
]

{ #category : #geometry }
RTLineSegment >> length [
	^ self vector r
]

{ #category : #geometry }
RTLineSegment >> pointForBalance: aNumber [
	"Return point on the line as specified by the balance.
	Balance is
		\in <0,1> for relative (e.g. 0 start, 1 end, 0.5 middle).
		>1 for absolute starting from source (e.g. '10' is 10 pixels from the FROM)
		<1 for absolute starting from end (e.g. '-10' is 10 pixesl from the TO)
	"

	| balance |
	balance := aNumber.
	(aNumber between: 0 and: 1)
		ifTrue: [ balance := self length * aNumber ].
	balance < 0
		ifTrue: [ balance := self length - balance negated ].
	^ self length > 0
		ifTrue: [ from + (self vector / self length * balance) ]
		ifFalse: [ from ]
]

{ #category : #accessing }
RTLineSegment >> right [
	^ from x > to x
		ifTrue: [ from ]
		ifFalse: [ to ]
]

{ #category : #geometry }
RTLineSegment >> sideOfPoint: aPoint [
	"Compute on which side of the segment a point is.
	For line going from left A=(a_x, a_y) to right B=(b_x, b_y) the value is
	d = (x - a_x)(b_y - a_y) - (y - a_y)(b_x - a_x)
	1 - above the line
	0 - on the line
  -1 - below the line
	"

	^ ((aPoint x - from x) * (to y - from y) - ((aPoint y - from y) * (to x - from x))) sign
]

{ #category : #geometry }
RTLineSegment >> tan [
	| vector |
	vector := self vector.
	vector x isZero
		ifTrue: [ ^ nil ].
	^ vector y / vector x
]

{ #category : #accessing }
RTLineSegment >> to [
	^ to
]

{ #category : #accessing }
RTLineSegment >> to: toPoint [
	to := toPoint
]

{ #category : #accessing }
RTLineSegment >> top [
	^ from y > to y
		ifTrue: [ from ]
		ifFalse: [ to ]
]

{ #category : #geometry }
RTLineSegment >> transposed [
	^ self class from: from transposed to: to transposed
]

{ #category : #geometry }
RTLineSegment >> vector [
	^ to - from
]
