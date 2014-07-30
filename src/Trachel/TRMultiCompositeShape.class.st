Class {
	#name : #TRMultiCompositeShape,
	#superclass : #TRShape,
	#instVars : [
		'shapes'
	],
	#category : #'Trachel-Core'
}

{ #category : #callbacks }
TRMultiCompositeShape >> addCallback: aCallback [
	"self shapes first addCallback: aCallback."
	super addCallback: aCallback
	"We are adding only to one shape. If we add it to two shapes, then the nesting will register several time the same callback"
	"shape2 addCallback: aCallback"
]

{ #category : #adding }
TRMultiCompositeShape >> addShape: aShape [
	^ self addShape: aShape translateBy: 0 @ 0
]

{ #category : #adding }
TRMultiCompositeShape >> addShape: aShape translateBy: aPoint [
	shapes add: (Array with: aShape with: aPoint)
]

{ #category : #actions }
TRMultiCompositeShape >> addedIn: aCanvas [
	shapes do: [ :tupple | 
		aCanvas addShape: tupple first.
		tupple first translateBy: tupple second ]

]

{ #category : #events }
TRMultiCompositeShape >> announce: anEvent [
	self shapes do: [ :s | s announce: anEvent ]
]

{ #category : #accessing }
TRMultiCompositeShape >> announcer [
	self error: 'should not be called'
]

{ #category : #accessing }
TRMultiCompositeShape >> announcer: anAnnouncer [
	self shapes do: [ :s | s announcer: anAnnouncer ]
]

{ #category : #accessing }
TRMultiCompositeShape >> canvas [
	"Return the canvas of one of the shapes"
	^ shapes first canvas	
]

{ #category : #accessing }
TRMultiCompositeShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	self shapes do: [ :s | s canvas: aSurface ]
]

{ #category : #accessing }
TRMultiCompositeShape >> center [
	^ (self shapes collect: #center) sum / shapes size
	
]

{ #category : #accessing }
TRMultiCompositeShape >> color [
	^ self shapes first color
	"shape2 color: aColor."
]

{ #category : #accessing }
TRMultiCompositeShape >> color: aColor [
	self shapes first color: aColor.
	"shape2 color: aColor."
]

{ #category : #private }
TRMultiCompositeShape >> computePath [
	self shapes do: [ :s | s computePath ]
]

{ #category : #drawing }
TRMultiCompositeShape >> drawOn: athensCanvas [
	self shapes do: [ :s | s drawOn: athensCanvas ]
]

{ #category : #accessing }
TRMultiCompositeShape >> element [
	^ self shapes first element
]

{ #category : #accessing }
TRMultiCompositeShape >> element: anObject [
	"anObject could be any kind of object. A shape has a reference to an object, typically the object odel that the trachel shape represents"
	self shapes do: [ :s | s element: anObject ]
]

{ #category : #accessing }
TRMultiCompositeShape >> encompassingRectangle [
	^ Rectangle merging: (self shapes collect: #encompassingRectangle)
]

{ #category : #actions }
TRMultiCompositeShape >> extent: anExtent [
	self shapes do: [ :s | s extent: anExtent ]
]

{ #category : #accessing }
TRMultiCompositeShape >> height [
	^ self encompassingRectangle height
]

{ #category : #'public action' }
TRMultiCompositeShape >> horizontal [

	| previousShape |
	previousShape := shapes first first.
	shapes allButFirst do: [ :tupple |
		tupple first translateTo: (previousShape center + ((previousShape extent x / 2) @ 0) + ((tupple first extent x / 2) @ 0)).
		previousShape := tupple first. ]
]

{ #category : #testing }
TRMultiCompositeShape >> includesPoint: aPoint [
	^ self shapes anySatisfy: [ :s | s includesPoint: aPoint ]
]

{ #category : #initialization }
TRMultiCompositeShape >> initialize [
	super initialize.
	shapes := OrderedCollection new
]

{ #category : #accessing }
TRMultiCompositeShape >> position [
	self shapes ifEmpty: [ ^ 0 @ 0 ].
	^ (self shapes collect: #position) sum / shapes size
]

{ #category : #actions }
TRMultiCompositeShape >> pushBack [
	self shapes do: #pushBack
]

{ #category : #actions }
TRMultiCompositeShape >> pushFront [
	self shapes do: #pushFront
]

{ #category : #'layout inner shapes' }
TRMultiCompositeShape >> relayout [
	"DO WE NEED THIS METHOD????"
	"One of the shape has been modified (position or extent), and the shapes may have to layouted correctly. This is what this method is about"
	| lastPosition |
	shapes size <= 1 ifTrue: [ ^ self ].
	lastPosition := shapes first first position.
	shapes allButFirst do: [ :tupple |
		tupple first translateTo: lastPosition + tupple second.
	]

]

{ #category : #actions }
TRMultiCompositeShape >> remove [
	self shapes do: #remove
]

{ #category : #private }
TRMultiCompositeShape >> resetPath [
	self shapes do: #resetPath
]

{ #category : #actions }
TRMultiCompositeShape >> setAsFixed [
	self shapes do: #setAsFixed
]

{ #category : #accessing }
TRMultiCompositeShape >> setShapes: someShapesWithOffsetAsPoint [
	shapes := someShapesWithOffsetAsPoint
]

{ #category : #accessing }
TRMultiCompositeShape >> shapes [ 
	^ shapes collect: #first
]

{ #category : #actions }
TRMultiCompositeShape >> signalUpdate [
	self shapes first signalUpdate
]

{ #category : #actions }
TRMultiCompositeShape >> translateBy: aPoint [
	shapes do: [ :tupple | tupple first translateBy: aPoint ]
]

{ #category : #actions }
TRMultiCompositeShape >> translateTo: aPoint [
	| oldPosition |
	oldPosition := self position.
	shapes do: [ :tupple | tupple first translateTo: (aPoint + tupple second) ].
	self triggerCallbacksForStep: (self position - oldPosition)

]

{ #category : #'public action' }
TRMultiCompositeShape >> vertical [

	| previousShape |

	previousShape := shapes first first.
	shapes allButFirst do: [ :tupple |
		tupple first translateTo: (previousShape center + (0 @ (previousShape extent y / 2)) + (0 @ (tupple first extent y / 2))).
		previousShape := tupple first. ]
]

{ #category : #events }
TRMultiCompositeShape >> when: event do: aBlock [
	self shapes do: [ :s | s announcer when: event do: aBlock ]
]

{ #category : #accessing }
TRMultiCompositeShape >> width [
	^ self encompassingRectangle width
]
