Class {
	#name : #TRCamera,
	#superclass : #TRObject,
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

{ #category : #utility }
TRCamera >> encompassingRectangle [

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

{ #category : #convertion }
TRCamera >> fromPixelToSpace: aPoint [
	| tr |
	tr := ((canvas extent / 2) - self position) negated.
	^ AthensAffineTransform new translation: tr; transform: aPoint
]

{ #category : #convertion }
TRCamera >> fromSpaceToPixel: aPoint [
	| tr |
	tr := (canvas extent / 2) - self position.
	^ AthensAffineTransform new translation: tr; transform: aPoint
]

{ #category : #initialization }
TRCamera >> initialize [
	super initialize.
	position := 0 @ 0.
	scale := 1.0
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
	position := position + aPoint
]

{ #category : #actions }
TRCamera >> translateTo: newPosition [
	position := newPosition
]
