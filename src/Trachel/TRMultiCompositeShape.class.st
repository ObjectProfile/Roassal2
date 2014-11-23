Class {
	#name : #TRMultiCompositeShape,
	#superclass : #TRShape,
	#instVars : [
		'shapeAndOffsets'
	],
	#category : #'Trachel-Core'
}

{ #category : #callbacks }
TRMultiCompositeShape >> addCallback: aCallback [
	super addCallback: aCallback.
"	self shapes ifEmpty: [ ^ self ]."
	"We are adding only to one shape. If we add it to two shapes, then the nesting will register several time the same callback"
	"self shapes last addCallback: aCallback 
"
]

{ #category : #'public - adding' }
TRMultiCompositeShape >> addShape: aShape [
	^ self addShape: aShape translateBy: 0 @ 0
]

{ #category : #'public - adding' }
TRMultiCompositeShape >> addShape: aShape translateBy: aPoint [
	shapeAndOffsets add: (Array with: aShape with: aPoint)
]

{ #category : #actions }
TRMultiCompositeShape >> addedIn: aCanvas [
	self propagateElement.
	shapeAndOffsets
		do: [ :tupple | 
			aCanvas addShape: tupple first.
			tupple first translateBy: tupple second ].
		
	"Make sure we are in the center. This is apparently necessary for element Shape. The following code is not nice at all :-("
	(shapeAndOffsets anySatisfy: [ :tupple | tupple first class == TRLineShape ])
		ifFalse: [ self translateBy: self position negated ]
]

{ #category : #actions }
TRMultiCompositeShape >> addedIn: aCanvas atIndex: index [
	self propagateElement.
	shapeAndOffsets
		do: [ :tupple | 
			aCanvas addShape: tupple first atIndex: index.
			tupple first translateBy: tupple second ].
		
	"Make sure we are in the center"
	self translateBy: self position negated
]

{ #category : #'public - layout' }
TRMultiCompositeShape >> alignRight [
	"Layout the shapes horizontally"

	TRConstraint alignFromRight: (shapeAndOffsets collect: #first).
	shapeAndOffsets do: [ :tuple | tuple at: 2 put: (tuple first position) ].
	self resetInnerShapes.

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
	^ shapeAndOffsets anyOne first canvas	
]

{ #category : #accessing }
TRMultiCompositeShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	self shapes do: [ :s | s canvas: aSurface ]
]

{ #category : #accessing }
TRMultiCompositeShape >> color [
	^ self shapes first color
	"shape2 color: aColor."
]

{ #category : #accessing }
TRMultiCompositeShape >> color: aColor [
	"Simply set the first shape"
	self shapes first color: aColor.

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
TRMultiCompositeShape >> encompassingRectangle [
	^ Rectangle merging: (self shapes collect: #encompassingRectangle)
]

{ #category : #accessing }
TRMultiCompositeShape >> extent [
	^ self encompassingRectangle extent
]

{ #category : #actions }
TRMultiCompositeShape >> extent: anExtent [
	self shapes do: [ :s | s extent: anExtent ]
]

{ #category : #accessing }
TRMultiCompositeShape >> height [
	^ self encompassingRectangle height
]

{ #category : #'public - layout' }
TRMultiCompositeShape >> horizontal [
	"Layout the shapes horizontally"

	| previousShape newPosition |
	previousShape := shapeAndOffsets first first.
	shapeAndOffsets allButFirst
		do: [ :tupple | 
			newPosition := previousShape center + ((previousShape extent x / 2) @ 0) + ((tupple first extent x / 2) @ 0).
			tupple first translateTo: newPosition.
			tupple at: 2 put: newPosition.
			previousShape := tupple first ].
	self resetInnerShapes
]

{ #category : #testing }
TRMultiCompositeShape >> includesPoint: aPoint [
	^ self shapes anySatisfy: [ :s | s includesPoint: aPoint ]
]

{ #category : #accessing }
TRMultiCompositeShape >> indexInCanvas [
	^ canvas privateIndexInCanvasOf: self shapes first
]

{ #category : #initialization }
TRMultiCompositeShape >> initialize [
	super initialize.
	shapeAndOffsets := OrderedCollection new
]

{ #category : #actions }
TRMultiCompositeShape >> isFixed [
	^ self shapes allSatisfy: #isFixed
]

{ #category : #'public - layout' }
TRMultiCompositeShape >> noLayout [
	"Do nothing here"
]

{ #category : #accessing }
TRMultiCompositeShape >> numberOfShapes [
	"Return the number of shapes added into myself"
	^ self shapes size
]

{ #category : #accessing }
TRMultiCompositeShape >> offsetOf: aTrachelShape [
	^ (shapeAndOffsets detect: [ :shapeAndOffset | shapeAndOffset first == aTrachelShape ]) second
]

{ #category : #accessing }
TRMultiCompositeShape >> offsets [ 
	^ shapeAndOffsets collect: #second
]

{ #category : #accessing }
TRMultiCompositeShape >> position [
	self shapes ifEmpty: [ ^ 0 @ 0 ].
	^ self encompassingRectangle center
]

{ #category : #actions }
TRMultiCompositeShape >> propagateElement [
	"Make all the shape aware of the element"
	self shapes do: [ :s | s element: self element ]
]

{ #category : #actions }
TRMultiCompositeShape >> pushBack [
	self shapes do: #pushBack
]

{ #category : #actions }
TRMultiCompositeShape >> pushFront [
	self shapes do: #pushFront
]

{ #category : #'public - layout' }
TRMultiCompositeShape >> relayout [
	"This methods places the contained shapes according to the specified layout"
	| first |
	first := self shapes first.
	shapeAndOffsets do: [ :shapeAndOffset | 
		shapeAndOffset first translateBy: first position + shapeAndOffset second ]

]

{ #category : #actions }
TRMultiCompositeShape >> remove [
	self triggerRemoveCallbacks.
	self shapes do: #remove
]

{ #category : #'public - layout' }
TRMultiCompositeShape >> resetInnerShapes [
	self shapes do: [ :ss | ss translateTo: 0 @ 0 ]
]

{ #category : #'public - layout' }
TRMultiCompositeShape >> resetInnerShapesOffset [
	shapeAndOffsets := shapeAndOffsets collect: [ :tupple | Array with: tupple first with: 0 @ 0 ]
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
	shapeAndOffsets := someShapesWithOffsetAsPoint
]

{ #category : #accessing }
TRMultiCompositeShape >> shapes [ 
	^ shapeAndOffsets collect: #first
]

{ #category : #actions }
TRMultiCompositeShape >> signalUpdate [
	"Signal that the canvas should be refreshed"
	"Do nothing if I have no shapes added"
	self shapes ifEmpty: [ ^ self ].
	self shapes first signalUpdate
]

{ #category : #actions }
TRMultiCompositeShape >> translateBy: aPoint [
	shapeAndOffsets do: [ :tupple | tupple first translateBy: aPoint ]
]

{ #category : #actions }
TRMultiCompositeShape >> translateTo: aPoint [
	| diffPosition |
	diffPosition := aPoint - self position.
	self translateBy: diffPosition.
	self triggerCallbacksForStep: diffPosition
]

{ #category : #'public - layout' }
TRMultiCompositeShape >> vertical [
	"Layout the shapes vertically"
	| previousShape newPosition |
	previousShape := shapeAndOffsets first first.
	shapeAndOffsets allButFirst do: [ :tupple |
		newPosition := (previousShape center + (0 @ (previousShape extent y / 2)) + (0 @ (tupple first extent y / 2))).
		tupple first translateTo: newPosition.
		tupple at: 2 put: newPosition.
		previousShape := tupple first ].
	self resetInnerShapes
]

{ #category : #events }
TRMultiCompositeShape >> when: event do: aBlock [
	self shapes do: [ :s | s announcer when: event do: aBlock ]
]

{ #category : #accessing }
TRMultiCompositeShape >> width [
	^ self encompassingRectangle width
]
