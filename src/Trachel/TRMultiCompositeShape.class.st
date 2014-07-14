Class {
	#name : #TRMultiCompositeShape,
	#superclass : #TRShape,
	#instVars : [
		'shapes'
	],
	#category : #'Trachel-Core'
}

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> addCallback: aCallback [
	self shapes first addCallback: aCallback.
	"We are adding only to one shape. If we add it to two shapes, then the nesting will register several time the same callback"
	"shape2 addCallback: aCallback"
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> addShape: aShape [
	^ self addShape: aShape translateBy: 0 @ 0
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> addShape: aShape translateBy: aPoint [
	shapes add: (Array with: aShape with: aPoint)
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> addedIn: aCanvas [
	shapes do: [ :tupple | 
		aCanvas addShape: tupple first.
		tupple first translateBy: tupple second ]

]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> announce: anEvent [
	self shapes do: [ :s | s announce: anEvent ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> announcer [
	self error: 'should not be called'
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> announcer: anAnnouncer [
	self shapes do: [ :s | s announcer: anAnnouncer ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> canvas [
	"Return the canvas of one of the shapes"
	^ shapes first canvas	
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	self shapes do: [ :s | s canvas: aSurface ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> center [
	^ (self shapes collect: #center) sum / shapes size
	
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> color [
	^ self shapes first color
	"shape2 color: aColor."
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> color: aColor [
	self shapes first color: aColor.
	"shape2 color: aColor."
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> computePath [
	self shapes do: [ :s | s computePath ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> drawOn: athensCanvas [
	self shapes do: [ :s | s drawOn: athensCanvas ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> element [
	^ self shapes first element
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> element: anObject [
	"anObject could be any kind of object. A shape has a reference to an object, typically the object odel that the trachel shape represents"
	self shapes do: [ :s | s element: anObject ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> encompassingRectangle [
	^ Rectangle merging: (self shapes collect: #encompassingRectangle)
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> extent: anExtent [
	self shapes do: [ :s | s extent: anExtent ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> height [
	^ self encompassingRectangle height
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> includesPoint: aPoint [
	^ self shapes anySatisfy: [ :s | s includesPoint: aPoint ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> initialize [
	super initialize.
	shapes := OrderedCollection new
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> position [
	self shapes ifEmpty: [ ^ 0 @ 0 ].
	^ (self shapes collect: #position) sum / shapes size
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> pushBack [
	self shapes do: #pushBack
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> pushFront [
	self shapes do: #pushFront
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> remove [
	self shapes do: #remove
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> resetPath [
	self shapes do: #resetPath
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> setAsFixed [
	self shapes do: #setAsFixed
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> setShapes: someShapesWithOffsetAsPoint [
	shapes := someShapesWithOffsetAsPoint
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> shapes [ 
	^ shapes collect: #first
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> signalUpdate [
	self shapes first signalUpdate
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> translateBy: aPoint [
	shapes do: [ :tupple | tupple first translateBy: aPoint ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> translateTo: aPoint [
	shapes do: [ :tupple | tupple first translateTo: (aPoint + tupple second) ]

]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> when: event do: aBlock [
	self shapes do: [ :s | s announcer when: event do: aBlock ]
]

{ #category : #'as yet unclassified' }
TRMultiCompositeShape >> width [
	^ self encompassingRectangle width
]
