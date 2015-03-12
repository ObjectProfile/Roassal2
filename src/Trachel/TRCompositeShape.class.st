Class {
	#name : #TRCompositeShape,
	#superclass : #TRShape,
	#instVars : [
		'shapeAndOffsets'
	],
	#category : #'Trachel-Core'
}

{ #category : #visitor }
TRCompositeShape >> accept: aVisitor [
	aVisitor visitMultiCompositeShape: self.
]

{ #category : #'public - adding' }
TRCompositeShape >> addShape: aShape [
	^ self addShape: aShape translateBy: 0 @ 0
]

{ #category : #'public - adding' }
TRCompositeShape >> addShape: aShape translateBy: aPoint [
	shapeAndOffsets add: (Array with: aShape with: aPoint)
]

{ #category : #actions }
TRCompositeShape >> addedIn: aCanvas [
	"Make sure we are in the center. This is apparently necessary for element Shape. The following code is not nice at all :-("
	self propagateElement.
	shapeAndOffsets do: [ :tupple | tupple first addedIn: aCanvas ].
	self positionShapesAfterBeingAdded.
	
]

{ #category : #actions }
TRCompositeShape >> addedIn: aCanvas atIndex: index [
	self propagateElement.
	shapeAndOffsets
		do: [ :tupple | 
			aCanvas addShape: tupple first atIndex: index.
			tupple first translateBy: tupple second ].
		
	"Make sure we are in the center"
	self translateBy: self position negated
]

{ #category : #'public - layout' }
TRCompositeShape >> alignRight [
	"Layout the shapes horizontally"

	TRConstraint alignFromRight: (shapeAndOffsets collect: #first).
	shapeAndOffsets do: [ :tuple | tuple at: 2 put: (tuple first position) ].
	self resetInnerShapes.

]

{ #category : #'public - layout' }
TRCompositeShape >> allOfSameSize [
	"All the same will have the same maximum size"

	| maxSize |
	maxSize := shapeAndOffsets inject: 0 @ 0 into: [ :max :tuple | tuple first extent max: max  ].
	shapeAndOffsets do: [ :tuple | tuple first extent: maxSize ].
]

{ #category : #events }
TRCompositeShape >> announce: anEvent [
	self shapes do: [ :s | s announce: anEvent ]
]

{ #category : #accessing }
TRCompositeShape >> announcer [
	self error: 'should not be called'
]

{ #category : #accessing }
TRCompositeShape >> announcer: anAnnouncer [
	self shapes do: [ :s | s announcer: anAnnouncer ]
]

{ #category : #accessing }
TRCompositeShape >> canvas [
	"Return the canvas of one of the shapes"
	^ shapeAndOffsets anyOne first canvas	
]

{ #category : #accessing }
TRCompositeShape >> canvas: aSurface [
	"aCanvas is a AthensCairoSurface"
	self shapes do: [ :s | s canvas: aSurface ]
]

{ #category : #accessing }
TRCompositeShape >> center [
	^ self encompassingRectangle center
]

{ #category : #accessing }
TRCompositeShape >> color [
	^ self shapes first color
	"shape2 color: aColor."
]

{ #category : #accessing }
TRCompositeShape >> color: aColor [
	"Simply set the first shape"
	self shapes first color: aColor.

]

{ #category : #private }
TRCompositeShape >> computePath [
	self shapes do: [ :s | s computePath ]
]

{ #category : #drawing }
TRCompositeShape >> drawOn: athensCanvas [
	self shapes do: [ :s | s drawOn: athensCanvas ]
]

{ #category : #accessing }
TRCompositeShape >> encompassingRectangle [
	"Really ugly method."
	| ans c |
	(self shapes anySatisfy: [ :ss | ss canvas notNil ])
		ifTrue: [ ^ Rectangle merging: (self shapes collect: #encompassingRectangle). ]. 
	
	c := shapeAndOffsets collect: [ :s | s first position ].
	self positionShapesAfterBeingAdded.
	ans := Rectangle merging: (self shapes collect: #encompassingRectangle).
	shapeAndOffsets with: c do: [ :s :p | s first translateTo: p ].
	^ ans
]

{ #category : #accessing }
TRCompositeShape >> extent [
	| res |
"	shapeAndOffsets
		do: [ :tupple | 
			tupple first translateTo: 0 @ 0 ].
"
	shapeAndOffsets
		do: [ :tupple | 
			tupple first translateBy: tupple second ].
 
	res := self encompassingRectangle extent.
	shapeAndOffsets
		do: [ :tupple | 
			tupple first translateTo: 0 @ 0 ].
	
	^ res.
	
	"We cannot do that, because we may need to get the extent, without having the elements added (and correctly positioned)"
	"^ self encompassingRectangle extent"
]

{ #category : #actions }
TRCompositeShape >> extent: anExtent [
	self shapes do: [ :s | s extent: anExtent ]
]

{ #category : #accessing }
TRCompositeShape >> height [
	^ self encompassingRectangle height
]

{ #category : #accessing }
TRCompositeShape >> height: aValue [
	^ self extent: self width @ aValue
]

{ #category : #'public - layout' }
TRCompositeShape >> horizontal [
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
TRCompositeShape >> includesPoint: aPoint [
	^ self shapes anySatisfy: [ :s | s includesPoint: aPoint ]
]

{ #category : #accessing }
TRCompositeShape >> indexInCanvas [
	^ canvas privateIndexInCanvasOf: self shapes first
]

{ #category : #initialization }
TRCompositeShape >> initialize [
	super initialize.
	shapeAndOffsets := OrderedCollection new
]

{ #category : #actions }
TRCompositeShape >> isFixed [
	^ self shapes allSatisfy: #isFixed
]

{ #category : #'public - layout' }
TRCompositeShape >> noLayout [
	"Do nothing here"
]

{ #category : #accessing }
TRCompositeShape >> numberOfShapes [
	"Return the number of shapes added into myself"
	^ self shapes size
]

{ #category : #accessing }
TRCompositeShape >> offsetOf: aTrachelShape [
	^ (shapeAndOffsets detect: [ :shapeAndOffset | shapeAndOffset first == aTrachelShape ]) second
]

{ #category : #accessing }
TRCompositeShape >> offsets [ 
	^ shapeAndOffsets collect: #second
]

{ #category : #accessing }
TRCompositeShape >> position [
	self shapes ifEmpty: [ ^ 0 @ 0 ].
	^ (Rectangle merging: (self shapes collect: #encompassingRectangle)) center
	"^ self encompassingRectangle center"
]

{ #category : #actions }
TRCompositeShape >> positionShapesAfterBeingAdded [
	| p |
	shapeAndOffsets do: [ :tupple | tupple first translateTo: tupple second ].	
		
	"Make sure we are in the center. This is apparently necessary for element Shape. The following code is not nice at all :-("
	p := self position negated.
	(shapeAndOffsets anySatisfy: [ :tupple | tupple first isKindOf: TRAbstractLineShape ])
		ifFalse: [ self translateBy: p ]
]

{ #category : #actions }
TRCompositeShape >> propagateElement [
	"Make all the shape aware of the element"
	self shapes do: [ :s | s element: self element ]
]

{ #category : #actions }
TRCompositeShape >> pushBack [
	self shapes do: #pushBack
]

{ #category : #actions }
TRCompositeShape >> pushFront [
	self shapes do: #pushFront
]

{ #category : #'public - layout' }
TRCompositeShape >> relayout [
	"This methods places the contained shapes according to the specified layout"
	| first |
	first := self shapes first.
	shapeAndOffsets do: [ :shapeAndOffset | 
		shapeAndOffset first translateBy: first position + shapeAndOffset second ]

]

{ #category : #actions }
TRCompositeShape >> remove [
	self triggerRemoveCallbacks.
	self shapes do: #remove
]

{ #category : #'public - layout' }
TRCompositeShape >> resetInnerShapes [
	self shapes do: [ :ss | ss translateTo: 0 @ 0 ]
]

{ #category : #'public - layout' }
TRCompositeShape >> resetInnerShapesOffset [
	shapeAndOffsets := shapeAndOffsets collect: [ :tupple | Array with: tupple first with: 0 @ 0 ]
]

{ #category : #private }
TRCompositeShape >> resetPath [
	self shapes do: #resetPath
]

{ #category : #actions }
TRCompositeShape >> setAsFixed [
	self shapes do: #setAsFixed
]

{ #category : #accessing }
TRCompositeShape >> setShapes: someShapesWithOffsetAsPoint [
	shapeAndOffsets := someShapesWithOffsetAsPoint
]

{ #category : #accessing }
TRCompositeShape >> shapes [ 
	^ shapeAndOffsets collect: #first
]

{ #category : #actions }
TRCompositeShape >> signalUpdate [
	"Signal that the canvas should be refreshed"
	"Do nothing if I have no shapes added"
	self shapes ifEmpty: [ ^ self ].
	self shapes first signalUpdate
]

{ #category : #actions }
TRCompositeShape >> translateBy: aPoint [
	shapeAndOffsets do: [ :tupple | tupple first translateBy: aPoint ]
	
"	shapeAndOffsets do: [ :tupple | 
		tupple first class == TRMultiCompositeShape
			ifTrue: [ tupple first translateBy: aPoint + (tupple first encompassingRectangle extent / 2) ]
			ifFalse: [ tupple first translateBy: aPoint ] ]"
]

{ #category : #actions }
TRCompositeShape >> translateTo: aPoint [
	| diffPosition |
	diffPosition := aPoint - self position.
	self translateBy: diffPosition.
	self triggerCallbacksForStep: diffPosition
]

{ #category : #'public - layout' }
TRCompositeShape >> vertical [
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

{ #category : #'public - layout' }
TRCompositeShape >> verticalAndLeft [
	"Layout the shapes vertically and aligned on the left hand side"
	TRConstraint alignFromLeft: (shapeAndOffsets collect: #first).
	RTVerticalLineLayout new gapSize: 0; on: (shapeAndOffsets collect: #first).
	shapeAndOffsets doWithIndex: [ :tuple :index | tuple at: 2 put: (tuple first position "x @ (index * 20)") ].
	self resetInnerShapes.


"	| previousShape newPosition maxWidth offsetX |
	maxWidth := (shapeAndOffsets collect: [ :tuple | tuple first width ]) max.
	
	previousShape := shapeAndOffsets first first.
	shapeAndOffsets allButFirst do: [ :tupple |
		offsetX := (maxWidth - tupple first width) / -4.
		newPosition := (previousShape center + (offsetX @ (previousShape extent y / 2)) + (0 @ (tupple first extent y / 2))).
		tupple first translateTo: newPosition.
		tupple at: 2 put: newPosition.
		previousShape := tupple first ].
	self resetInnerShapes"
]

{ #category : #events }
TRCompositeShape >> when: event do: aBlock [
	self shapes do: [ :s | s announcer when: event do: aBlock ]
]

{ #category : #accessing }
TRCompositeShape >> width [
	^ self encompassingRectangle width
]

{ #category : #accessing }
TRCompositeShape >> width: aValue [
	^ self extent: aValue @ self height
]
