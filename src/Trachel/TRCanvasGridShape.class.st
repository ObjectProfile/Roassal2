"
I am a shape for RTGridView
"
Class {
	#name : #TRCanvasGridShape,
	#superclass : #TRShape,
	#instVars : [
		'offset',
		'spacing',
		'dashes'
	],
	#category : #'Trachel-Shapes'
}

{ #category : #visiting }
TRCanvasGridShape >> accept: aVisitor [

	aVisitor visitGrid: self
]

{ #category : #accessing }
TRCanvasGridShape >> addToOffset: aPoint [
	offset := offset + aPoint
]

{ #category : #private }
TRCanvasGridShape >> basicEncompassingRectangle [

	^ (0 @ 0) corner: (0 @ 0)
]

{ #category : #accessing }
TRCanvasGridShape >> center [

	^ self canvas camera position
]

{ #category : #private }
TRCanvasGridShape >> computePath [

	| width height |
	self shouldBeVisible ifFalse: [ ^ self ].
	width := self canvas extent x / canvas camera scale roundUpTo:
		         spacing.
	height := self canvas extent y / canvas camera scale roundUpTo:
		          spacing.
	path := self athensCanvas createPath: [ :builder | 
		        builder absolute.
		        height negated to: height by: spacing do: [ :i | 
			        builder
				        moveTo: width negated @ i;
				        lineTo: width @ i ].
		        width negated to: width by: spacing do: [ :i | 
			        builder
				        moveTo: i @ height negated;
				        lineTo: i @ height ] ]
]

{ #category : #accessing }
TRCanvasGridShape >> dashes [
	"Return the dash pattern associated"
	^ dashes
]

{ #category : #accessing }
TRCanvasGridShape >> dashes: integers [
	"Set the dash pattern for the line. Could be #(1 20) for example"
	dashes := integers
]

{ #category : #drawing }
TRCanvasGridShape >> drawOn: athensCanvas [

	"The shape is first moved by offset, which will always center it on camera, then it is moved by moduled offset, so it will alway move only by at most the modulo"

	| s |
	self shouldBeVisible ifFalse: [ ^ self ].
	athensCanvas pathTransform restoreAfter: [ 
		athensCanvas pathTransform translateBy: offset.
		athensCanvas pathTransform translateBy:
			(offset x % spacing @ (offset y % spacing)) negated.
		athensCanvas setShape: self path.
		s := athensCanvas setStrokePaint: self color.
		s width: 1.0 / (self canvas camera scale max: 0.05).
		dashes ifNotNil: [ s dashes: dashes offset: spacing ].
		athensCanvas draw ]
]

{ #category : #accessing }
TRCanvasGridShape >> encompassingRectangle [

	^ self basicEncompassingRectangle
]

{ #category : #initialization }
TRCanvasGridShape >> initialize [
	super initialize.
	color := Color black alpha: 0.05.
	offset := 0 @ 0
]

{ #category : #asserting }
TRCanvasGridShape >> shouldBeVisible [

	^ spacing > (13.0 / (self canvas camera scale max: 0.05))
]

{ #category : #accessing }
TRCanvasGridShape >> spacing: aNumber [
	spacing := aNumber
]
