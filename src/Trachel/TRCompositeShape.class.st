Class {
	#name : #TRCompositeShape,
	#superclass : #TRShape,
	#instVars : [
		'shape1',
		'shape2',
		'offset2'
	],
	#category : #'Trachel-Core'
}

{ #category : #public }
TRCompositeShape class >> sameSizeWith: s1 with: s2 [
	"When being created, the two shapes will have the same extent"
	| max |
	max := s1 encompassingRectangle extent max: s2 encompassingRectangle extent.
	s1 extent: max.
	s2 extent: max.
	^ self new shape1: s1; shape2: s2; yourself
]

{ #category : #public }
TRCompositeShape class >> with: s1 with: s2 [
	^ self new shape1: s1; shape2: s2; yourself
]

{ #category : #visitor }
TRCompositeShape >> accept: aVisitor [
	aVisitor visitCompositeShape: self
]

{ #category : #actions }
TRCompositeShape >> addCallback: aCallback [
	shape1 addCallback: aCallback.
	shape2 addCallback: aCallback
]

{ #category : #actions }
TRCompositeShape >> addedIn: aCanvas [
	aCanvas addShape: shape1.
	aCanvas addShape: shape2.
	shape2 translateBy: offset2.
]

{ #category : #events }
TRCompositeShape >> announce: anEvent [
	shape1 announce: anEvent.
	shape2 announce: anEvent.
]

{ #category : #accessing }
TRCompositeShape >> announcer [
	self error: 'should not be called'
]

{ #category : #accessing }
TRCompositeShape >> announcer: anAnnouncer [
	shape1 announcer: anAnnouncer.
	shape2 announcer: anAnnouncer.
]

{ #category : #accessing }
TRCompositeShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	shape1 canvas: aSurface.
	shape2 canvas: aSurface
]

{ #category : #accessing }
TRCompositeShape >> center [
	^ (shape1 center + shape2 center) / 2
]

{ #category : #accessing }
TRCompositeShape >> color [
	^ shape1 color
	"shape2 color: aColor."
]

{ #category : #accessing }
TRCompositeShape >> color: aColor [
	shape1 color: aColor.
	"shape2 color: aColor."
]

{ #category : #hooks }
TRCompositeShape >> computePath [
	shape1 computePath.
	shape2 computePath
]

{ #category : #drawing }
TRCompositeShape >> drawOn: athensCanvas [

	shape1 drawOn: athensCanvas.
	shape2 drawOn: athensCanvas
]

{ #category : #accessing }
TRCompositeShape >> element [
	^ shape1 element
]

{ #category : #accessing }
TRCompositeShape >> element: anObject [
	"anObject could be any kind of object. A shape has a reference to an object, typically the object odel that the trachel shape represents"
	shape1 element: anObject.
	shape2 element: anObject.
]

{ #category : #accessing }
TRCompositeShape >> encompassingRectangle [
	^ Rectangle merging: (Array with: shape1 encompassingRectangle with: shape2 encompassingRectangle)
]

{ #category : #actions }
TRCompositeShape >> extent: anExtent [

	shape1 extent: anExtent.
	shape2 extent: anExtent
]

{ #category : #accessing }
TRCompositeShape >> height [
	^ self encompassingRectangle height
]

{ #category : #testing }
TRCompositeShape >> includesPoint: aPoint [
	^ (shape1 includesPoint: aPoint) or: [ shape2 includesPoint: aPoint ]
]

{ #category : #initialization }
TRCompositeShape >> initialize [
	super initialize.
	shape1 := TRNoShape instance.
	shape2 := TRNoShape instance.
	offset2 := 0 @ 0
]

{ #category : #accessing }
TRCompositeShape >> offset2 [
	^ offset2
]

{ #category : #accessing }
TRCompositeShape >> offset2: aPoint [
	offset2 := aPoint
]

{ #category : #accessing }
TRCompositeShape >> position [
	^ (shape1 position + shape2 position) / 2
]

{ #category : #actions }
TRCompositeShape >> pushBack [
	shape1 pushBack.
	shape2 pushBack.
]

{ #category : #actions }
TRCompositeShape >> pushFront [
	shape1 pushFront.
	shape2 pushFront.
]

{ #category : #actions }
TRCompositeShape >> remove [
	shape1 remove.
	shape2 remove
]

{ #category : #private }
TRCompositeShape >> resetPath [
	shape1 resetPath.
	shape2 resetPath.
]

{ #category : #accessing }
TRCompositeShape >> shape1 [
	^ shape1
]

{ #category : #accessing }
TRCompositeShape >> shape1: aTRShape [
	shape1 := aTRShape
]

{ #category : #accessing }
TRCompositeShape >> shape2 [
	^ shape2
]

{ #category : #accessing }
TRCompositeShape >> shape2: aTRShape [
	shape2 := aTRShape
]

{ #category : #actions }
TRCompositeShape >> signalUpdate [
	shape1 signalUpdate
]

{ #category : #actions }
TRCompositeShape >> translateBy: aPoint [

	shape1 translateBy: aPoint.
	shape2 translateBy: aPoint
]

{ #category : #actions }
TRCompositeShape >> translateTo: aPoint [
	shape1 translateTo: aPoint.
	shape2 translateTo: (aPoint + offset2).
]

{ #category : #events }
TRCompositeShape >> when: event do: aBlock [
	shape1 announcer when: event do: aBlock.
	shape2 announcer when: event do: aBlock
]

{ #category : #accessing }
TRCompositeShape >> width [
	^ self encompassingRectangle width
]
