Class {
	#name : #TRComposedShape,
	#superclass : #TRShape,
	#instVars : [
		'shape1',
		'shape2'
	],
	#category : #Trachel
}

{ #category : #'as yet unclassified' }
TRComposedShape class >> with: s1 with: s2 [
	^ self new shape1: s1; shape2: s2; yourself
]

{ #category : #'as yet unclassified' }
TRComposedShape >> addCallback: aCallback [
	shape1 addCallback: aCallback.
	shape2 addCallback: aCallback
]

{ #category : #'as yet unclassified' }
TRComposedShape >> addedIn: aCanvas [
	aCanvas addShape: shape1.
	aCanvas addShape: shape2.

]

{ #category : #'as yet unclassified' }
TRComposedShape >> announce: anEvent [
	shape1 announce: anEvent.
	shape2 announce: anEvent.
]

{ #category : #'as yet unclassified' }
TRComposedShape >> announcer [
	self error: 'should not be called'
]

{ #category : #'as yet unclassified' }
TRComposedShape >> announcer: anAnnouncer [
	shape1 announcer: anAnnouncer.
	shape2 announcer: anAnnouncer.
]

{ #category : #'as yet unclassified' }
TRComposedShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	shape1 canvas: aSurface.
	shape2 canvas: aSurface
]

{ #category : #'as yet unclassified' }
TRComposedShape >> computePath [
	shape1 computePath.
	shape2 computePath
]

{ #category : #'as yet unclassified' }
TRComposedShape >> drawOn: athensCanvas [

	shape1 drawOn: athensCanvas.
	shape2 drawOn: athensCanvas
]

{ #category : #'as yet unclassified' }
TRComposedShape >> element [
	^ shape1 element
]

{ #category : #'as yet unclassified' }
TRComposedShape >> element: anObject [
	"anObject could be any kind of object. A shape has a reference to an object, typically the object odel that the trachel shape represents"
	shape1 element: anObject.
	shape2 element: anObject.
]

{ #category : #'as yet unclassified' }
TRComposedShape >> encompassingRectangle [
	^ Rectangle merging: (Array with: shape1 encompassingRectangle with: shape2 encompassingRectangle)
]

{ #category : #'as yet unclassified' }
TRComposedShape >> height [
	^ self encompassingRectangle height
]

{ #category : #'as yet unclassified' }
TRComposedShape >> includesPoint: aPoint [
	^ (shape1 includesPoint: aPoint) or: [ shape2 includesPoint: aPoint ]
]

{ #category : #'as yet unclassified' }
TRComposedShape >> on: event do: aBlock [
	shape1 announcer on: event do: aBlock.
	shape2 announcer on: event do: aBlock
]

{ #category : #'as yet unclassified' }
TRComposedShape >> shape1 [
	^ shape1
]

{ #category : #'as yet unclassified' }
TRComposedShape >> shape1: aTRShape [
	shape1 := aTRShape
]

{ #category : #'as yet unclassified' }
TRComposedShape >> shape2 [
	^ shape2
]

{ #category : #'as yet unclassified' }
TRComposedShape >> shape2: aTRShape [
	shape2 := aTRShape
]

{ #category : #'as yet unclassified' }
TRComposedShape >> width [
	^ self encompassingRectangle width
]
