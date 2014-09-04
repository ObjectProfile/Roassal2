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
	"super addCallback: aCallback."
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
		
	"Make sure we are in the center"
	self translateBy: self position negated
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

{ #category : #'public - layout' }
TRMultiCompositeShape >> horizontal [
	"PROBABLY DOES NOT WORK. GET INSPIRATION FROM #vertical"
	| previousShape |
	previousShape := shapeAndOffsets first first.
	shapeAndOffsets allButFirst do: [ :tupple |
		tupple first translateTo: (previousShape center + ((previousShape extent x / 2) @ 0) + ((tupple first extent x / 2) @ 0)).
		previousShape := tupple first ].
	self relayout
]

{ #category : #testing }
TRMultiCompositeShape >> includesPoint: aPoint [
	^ self shapes anySatisfy: [ :s | s includesPoint: aPoint ]
]

{ #category : #initialization }
TRMultiCompositeShape >> initialize [
	super initialize.
	shapeAndOffsets := OrderedCollection new
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
	^ (self shapes collect: #position) sum / shapeAndOffsets size
]

{ #category : #actions }
TRMultiCompositeShape >> propagateElement [
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

{ #category : #'layout inner shapes' }
TRMultiCompositeShape >> relayout [

	| first |
	first := self shapes first.
	shapeAndOffsets do: [ :shapeAndOffset | 
		shapeAndOffset first translateBy: first position + shapeAndOffset second ]
	
	"Set as offset the position of the shapes"
	"shapeAndOffsets do: [ :shapeAndOffset | shapeAndOffset at: 2 put: shapeAndOffset first position ]"
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
	shapeAndOffsets := someShapesWithOffsetAsPoint
]

{ #category : #accessing }
TRMultiCompositeShape >> shapes [ 
	^ shapeAndOffsets collect: #first
]

{ #category : #actions }
TRMultiCompositeShape >> signalUpdate [
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

	| previousShape newPosition |
	previousShape := shapeAndOffsets first first.
	shapeAndOffsets allButFirst do: [ :tupple |
		newPosition := (previousShape center + (0 @ (previousShape extent y / 2)) + (0 @ (tupple first extent y / 2))).
		tupple first translateTo: newPosition.
		tupple at: 2 put: newPosition.
		previousShape := tupple first ].
	self shapes do: [ :ss | ss translateTo: 0 @ 0 ]
]

{ #category : #events }
TRMultiCompositeShape >> when: event do: aBlock [
	self shapes do: [ :s | s announcer when: event do: aBlock ]
]

{ #category : #accessing }
TRMultiCompositeShape >> width [
	^ self encompassingRectangle width
]
