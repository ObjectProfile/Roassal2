"
I am a shape for RTGridView
"
Class {
	#name : #TRCanvasGridShape,
	#superclass : #TRShape,
	#instVars : [
		'offset',
		'spacing'
	],
	#category : #'Trachel-Shapes'
}

{ #category : #accessing }
TRCanvasGridShape >> addToOffset: aPoint [
	offset := offset + aPoint
]

{ #category : #private }
TRCanvasGridShape >> computePath [
	| width height |
	width := self canvas extent x / canvas camera scale roundUpTo: spacing.
	height := self canvas extent y / canvas camera scale roundUpTo: spacing.
	path := self athensCanvas
		createPath:
			[ :builder | 
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

{ #category : #drawing }
TRCanvasGridShape >> drawOn: athensCanvas [
	"The shape is first moved by offset, which will always center it on camera, then it is moved by moduled offset, so it will alway move only by at most the modulo"

	athensCanvas pathTransform
		restoreAfter:
			[ athensCanvas pathTransform translateBy: offset.
			athensCanvas pathTransform
				translateBy: ((offset x % spacing) @ (offset y % spacing)) negated.
			athensCanvas setShape: self path.
			(athensCanvas setStrokePaint: self color) width: 1.
			athensCanvas draw ]
]

{ #category : #accessing }
TRCanvasGridShape >> encompassingRectangle [
	^ 0 @ 0 corner: 0@0
]

{ #category : #accessing }
TRCanvasGridShape >> initialize [
	super initialize.
	color := Color black alpha: 0.05.
	offset := 0 @ 0
]

{ #category : #accessing }
TRCanvasGridShape >> spacing: aNumber [
	spacing := aNumber
]
