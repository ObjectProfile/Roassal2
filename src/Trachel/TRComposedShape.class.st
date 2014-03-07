Class {
	#name : #TRComposedShape,
	#superclass : #TRShape,
	#instVars : [
		'shape1',
		'shape2'
	],
	#category : #'Trachel-Core'
}

{ #category : #'as yet unclassified' }
TRComposedShape class >> with: s1 with: s2 [
	|max|
	max := s1 encompassingRectangle extent max: s2 encompassingRectangle extent.
	s1 extent: max.
	s2 extent: max.
	^ self new shape1: s1; shape2: s2; yourself
]

{ #category : #actions }
TRComposedShape >> addCallback: aCallback [
	shape1 addCallback: aCallback.
	shape2 addCallback: aCallback
]

{ #category : #actions }
TRComposedShape >> addedIn: aCanvas [
	aCanvas addShape: shape1.
	aCanvas addShape: shape2.

]

{ #category : #events }
TRComposedShape >> announce: anEvent [
	shape1 announce: anEvent.
	shape2 announce: anEvent.
]

{ #category : #accessing }
TRComposedShape >> announcer [
	self error: 'should not be called'
]

{ #category : #accessing }
TRComposedShape >> announcer: anAnnouncer [
	shape1 announcer: anAnnouncer.
	shape2 announcer: anAnnouncer.
]

{ #category : #accessing }
TRComposedShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	shape1 canvas: aSurface.
	shape2 canvas: aSurface
]

{ #category : #hooks }
TRComposedShape >> computePath [
	shape1 computePath.
	shape2 computePath
]

{ #category : #drawing }
TRComposedShape >> drawOn: athensCanvas [

	shape1 drawOn: athensCanvas.
	shape2 drawOn: athensCanvas
]

{ #category : #accessing }
TRComposedShape >> element [
	^ shape1 element
]

{ #category : #accessing }
TRComposedShape >> element: anObject [
	"anObject could be any kind of object. A shape has a reference to an object, typically the object odel that the trachel shape represents"
	shape1 element: anObject.
	shape2 element: anObject.
]

{ #category : #accessing }
TRComposedShape >> encompassingRectangle [
	^ Rectangle merging: (Array with: shape1 encompassingRectangle with: shape2 encompassingRectangle)
]

{ #category : #accessing }
TRComposedShape >> height [
	^ self encompassingRectangle height
]

{ #category : #testing }
TRComposedShape >> includesPoint: aPoint [
	^ (shape1 includesPoint: aPoint) or: [ shape2 includesPoint: aPoint ]
]

{ #category : #initialization }
TRComposedShape >> initialize [
	super initialize.
	shape1 := TRNoShape instance.
	shape2 := TRNoShape instance.
]

{ #category : #accessing }
TRComposedShape >> position [
	^ (shape1 position + shape2 position) / 2
]

{ #category : #actions }
TRComposedShape >> remove [
	shape1 remove.
	shape2 remove
]

{ #category : #actions }
TRComposedShape >> resetPath [
	shape1 resetPath.
	shape2 resetPath.
]

{ #category : #accessing }
TRComposedShape >> shape1 [
	^ shape1
]

{ #category : #accessing }
TRComposedShape >> shape1: aTRShape [
	shape1 := aTRShape
]

{ #category : #accessing }
TRComposedShape >> shape2 [
	^ shape2
]

{ #category : #accessing }
TRComposedShape >> shape2: aTRShape [
	shape2 := aTRShape
]

{ #category : #actions }
TRComposedShape >> signalUpdate [
	shape1 signalUpdate
]

{ #category : #actions }
TRComposedShape >> translateTo: aPoint [
	shape1 translateTo: aPoint.
	shape2 translateTo: aPoint.
]

{ #category : #events }
TRComposedShape >> when: event do: aBlock [
	shape1 announcer when: event do: aBlock.
	shape2 announcer when: event do: aBlock
]

{ #category : #accessing }
TRComposedShape >> width [
	^ self encompassingRectangle width
]
