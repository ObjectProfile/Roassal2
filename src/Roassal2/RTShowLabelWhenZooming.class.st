"
This is an interaction that show label only when the camera reaches a particular zoom scale factor.

Here is an example:
-=-=-=
b := RTMondrian new.
b shape labeledBox.
elements := b nodes: (1 to: 9).
b layout grid.
b view @  RTShowLabelWhenZooming.
b
-=-=-=
"
Class {
	#name : #RTShowLabelWhenZooming,
	#superclass : #RTAbstractInteractionView,
	#instVars : [
		'scaleThreshold',
		'conditionBlock'
	],
	#category : #'Roassal2-Interactions'
}

{ #category : #accessing }
RTShowLabelWhenZooming >> conditionBlock [
	^ conditionBlock
]

{ #category : #accessing }
RTShowLabelWhenZooming >> conditionBlock: aOneArgBlock [
	"The conditionBlock is used to filter the label shapes that should be considered.
	All the Trachel label shapes that matches the argument are considered to be hidden.
	
	Take the trachel shape as argument"
	conditionBlock := aOneArgBlock
]

{ #category : #initialization }
RTShowLabelWhenZooming >> initialize [
	super initialize.
	self scaleThreshold: 1.
	self conditionBlock: true
]

{ #category : #hooks }
RTShowLabelWhenZooming >> initializeElement: aView [
	aView canvas camera
		addCallback:
			(TRCameraScaleCallback new
				block: [ :scaleFactor | 
					| lbls |
					lbls := aView canvas shapes
						select: [ :s | (s isKindOf: TRLabelShape) and: [ conditionBlock rtValue: s ] ].
					"lbls := (aView elements select: [ :el | el shape isKindOf: RTLabel ]) collect: #trachelShape."
					scaleFactor > scaleThreshold
						ifTrue: [ lbls do: #show ]
						ifFalse: [ lbls do: #hide ] ])
]

{ #category : #accessing }
RTShowLabelWhenZooming >> scaleThreshold [
	^ scaleThreshold
]

{ #category : #accessing }
RTShowLabelWhenZooming >> scaleThreshold: aFloat [
	"Set the scale threshold for which elements have to be hidden"
	scaleThreshold := aFloat
]
