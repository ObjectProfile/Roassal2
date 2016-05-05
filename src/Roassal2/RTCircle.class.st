"
A RTCircle is a circle described by its 'center' and 'radius'.
"
Class {
	#name : #RTCircle,
	#superclass : #RTObject,
	#instVars : [
		'center',
		'radius'
	],
	#category : #'Roassal2-AttachPoint'
}

{ #category : #'instance creation' }
RTCircle class >> center: aPoint radius: aRadius [
	^ self basicNew setCenter: aPoint radius: aRadius
]

{ #category : #'instance creation' }
RTCircle class >> new [
	^ self error: 'Use #center:radius: instead.'
]

{ #category : #accessing }
RTCircle >> center [
	^ center
]

{ #category : #testing }
RTCircle >> includesPoint: aPoint [
	^ (center dist: aPoint) <= radius
]

{ #category : #comparing }
RTCircle >> intersectCircle: aCircle [
	| radii a h d p2 x1 y1 x2 y2 |
	d := self center dist: aCircle center.
	radii := self radius + aCircle radius.
	"too far apart"
	d > radii
		ifTrue: [ ^ #() ].
	"one within another"
	d < (self radius - aCircle radius) abs
		ifTrue: [ ^ #() ].
	a := (self radius squared - aCircle radius squared + d squared) / (2 * d).
	h := (self radius squared - a squared) sqrt.
	p2 := (aCircle center - self center) * (a / d) + self center.
	x1 := p2 x + (h * (aCircle center y - self center y) / d).
	y1 := p2 y - (h * (aCircle center x - self center x) / d).
	x2 := p2 x - (h * (aCircle center y - self center y) / d).
	y2 := p2 y + (h * (aCircle center x - self center x) / d).
	^ {(x1 @ y1).
	(x2 @ y2)} asSet asArray
]

{ #category : #printing }
RTCircle >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	center printOn: aStream.
	aStream nextPutAll: ' radius: '.
	aStream nextPutAll: radius asString.
	aStream nextPut: $)
]

{ #category : #accessing }
RTCircle >> radius [
	^ radius
]

{ #category : #initialization }
RTCircle >> setCenter: aCenter radius: aRadius [
	center := aCenter.
	radius := aRadius
]
