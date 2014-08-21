"
I am main tool which helps to move across Trachel's canvas.

My two main properties are position and scale.

- position 
  is a point representing coordinates of the canvas on which the ""viewing window"" will be centered.
  position can be changes with:
  * #translateBy:
  * #translateTo:
  both methods accept canvas based coordinates

- scale
  defines a magnitude of zooming applied to the canvas and it's elements.

I provide two methods that allow conversion between coanvas (space) coordinate system and real window(pixel)'s coordinates.
* #fromPixelToSpace:
* #fromSpaceToPixel:

Also I provide handy methods for centering camera on current elements and zoomeing to fit everuthing in the square with desired size (default 500pnt).
* #focusOnCenter
* #focusOnCenterScaled
* #focusOnCenterScaled:
"
Class {
	#name : #TRCamera,
	#superclass : #TRCallableObject,
	#instVars : [
		'position',
		'canvas',
		'scale'
	],
	#category : #'Trachel-Core'
}

{ #category : #public }
TRCamera class >> forCanvas: aTrachelCanvas [

	^ super new canvas: aTrachelCanvas
]

{ #category : #public }
TRCamera class >> new [
	self error: 'Instance of this class have to be created with #forCanvas:'
]

{ #category : #accessing }
TRCamera >> canvas [
	"Return the trachel canvas I am observing"
	^ canvas
]

{ #category : #accessing }
TRCamera >> canvas: aTrachelCanvas [
	"Set the canvas to observe"
	canvas := aTrachelCanvas
]

{ #category : #convertion }
TRCamera >> distanceFromPixelToSpace: aPoint [
	^ (aPoint / self scale) asFloatPoint
	"^ AthensAffineTransform new scaleBy: (1 / self scale) asFloat; translation: aPoint; transform: aPoint"
]

{ #category : #utility }
TRCamera >> encompassingRectangle [
	"Return the encompassing rectangle of all the elements contained in the canvas"
	"Maybe a method encompassingRectangle has to be defined in TRCanvas?"
	^ self encompassingRectangleOf: canvas shapes
]

{ #category : #utility }
TRCamera >> encompassingRectangleOf: shapes [
	| encompassingRectangle |
	encompassingRectangle := shapes anyOne encompassingRectangle.
	shapes do: [ :e | encompassingRectangle := encompassingRectangle merge: e encompassingRectangle ].
	^ encompassingRectangle 
]

{ #category : #actions }
TRCamera >> focusOnCenter [
	"Do nothing if no shape are present"
	canvas numberOfShapes = 0 ifTrue: [ ^ self ]. 
	self translateTo: self encompassingRectangle center
]

{ #category : #actions }
TRCamera >> focusOnCenterScaled [
	self focusOnCenterScaled: 500.
	
	
]

{ #category : #actions }
TRCamera >> focusOnCenterScaled: aFactor [
	| sc rec max |
	
	canvas numberOfShapes = 0 ifTrue: [ ^ self ].
	rec := self encompassingRectangle.
	max := rec width max: rec height.
	sc := aFactor / max.
	self scale: sc.
]

{ #category : #convertion }
TRCamera >> fromPixelToSpace: aPoint [

	^ AthensAffineTransform new
		translateBy: self position;
		scaleBy: 1 / self scale;
		translateBy: (self canvas extent / 2) negated;
		transform: aPoint
]

{ #category : #convertion }
TRCamera >> fromSpaceToPixel: aPoint [

	^ AthensAffineTransform new
		translateBy: self canvas extent / 2;
		scaleBy: self scale;
		translateBy: self position negated;
		transform: aPoint
	
]

{ #category : #initialization }
TRCamera >> initialize [
	super initialize.
	position := 0 @ 0.
	scale := 1.0
]

{ #category : #'testing visibility' }
TRCamera >> isVisible: aShape [
	| p pOnScreen ext |
	p := aShape position.
	pOnScreen := self fromSpaceToPixel: p.
	ext := self canvas extent.
	^ (0 @ 0 extent: ext) containsPoint: pOnScreen
]

{ #category : #accessing }
TRCamera >> position [
	^ position
]

{ #category : #accessing }
TRCamera >> scale [
	^ scale
]

{ #category : #accessing }
TRCamera >> scale: aNewScale [
	scale := aNewScale
]

{ #category : #actions }
TRCamera >> translateBy: aPoint [
	position := position + aPoint.
	self triggerCallbacksForStep: aPoint
]

{ #category : #actions }
TRCamera >> translateTo: newPosition [
	| step |
	step := newPosition - position.
	position := newPosition.
	self triggerCallbacksForStep: step.
]
