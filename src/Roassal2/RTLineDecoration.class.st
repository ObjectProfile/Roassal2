Class {
	#name : #RTLineDecoration,
	#superclass : #RTShape,
	#instVars : [
		'width',
		'size',
		'attachPoint',
		'line',
		'baseSize'
	],
	#category : #'Roassal2-Core'
}

{ #category : #accessing }
RTLineDecoration >> attachPoint [
	^ attachPoint
]

{ #category : #accessing }
RTLineDecoration >> attachPoint: anObject [
	attachPoint := anObject
]

{ #category : #accessing }
RTLineDecoration >> baseSize: aNumberOrBlockOrIdentifier [
	baseSize := [ :e | aNumberOrBlockOrIdentifier rtValue: e].
	
]

{ #category : #configuration }
RTLineDecoration >> defaultBaseSize [
	"Set the size of the base size of the line head decoration"
	^ 10
]

{ #category : #initialization }
RTLineDecoration >> initialize [
	super initialize.
	attachPoint := RTCenteredAttachPoint new.
	baseSize := self defaultBaseSize
]

{ #category : #accessing }
RTLineDecoration >> line: aRTLine [
	line := aRTLine
]

{ #category : #accessing }
RTLineDecoration >> mySize [
	^size
]

{ #category : #accessing }
RTLineDecoration >> size: aNumberOrBlockOrIdentifier [
	size := [ :e | aNumberOrBlockOrIdentifier rtValue: e ].
	
]

{ #category : #hooks }
RTLineDecoration >> trachelShapeClass [
	^ TRAbstractLineDecoratorShape 
]

{ #category : #public }
RTLineDecoration >> trachelShapeFor: anEdge [
	| f shape |
	f := attachPoint startingPointOf: anEdge.
	line ~= nil
		ifTrue: [ 
			| tShape |
			tShape := line trachelShapeFor: anEdge.
			tShape class = TRBezierShape
				ifTrue: [ f := tShape points allButLast last ] ].
	shape := self trachelShapeClass
		from: f
		to: (attachPoint endingPointOf: anEdge)
		width: (self widthFor: anEdge)
		size: (self mySize rtValue: anEdge)
		color: (self colorFor: anEdge)
		stroke: (self colorFor: anEdge).
	shape baseSize: (baseSize rtValue: anEdge).
	^ shape
]

{ #category : #hooks }
RTLineDecoration >> updateFor: edge trachelShape: trachelShape [
	| f |
	f := (attachPoint startingPointOf: edge).
	(line ~= nil)
		ifTrue: [ | tShape |
			tShape := edge trachelShape shape1.
			tShape class = TRBezierShape 
				ifTrue: [	f := tShape points allButLast last ]].
	trachelShape from: f.
	trachelShape to: (attachPoint endingPointOf: edge).
	trachelShape color: (self colorFor: edge).
	trachelShape width: (self widthFor: edge).
	trachelShape resetPath.

]

{ #category : #accessing }
RTLineDecoration >> width: aBlockOrValue [
	width := aBlockOrValue
]

{ #category : #hooks }
RTLineDecoration >> widthFor: anElement [
	^ width rtValue: anElement
]
