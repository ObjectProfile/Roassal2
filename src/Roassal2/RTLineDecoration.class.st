Class {
	#name : #RTLineDecoration,
	#superclass : #RTShape,
	#instVars : [
		'width',
		'size',
		'attachPoint',
		'line'
	],
	#category : #'Roassal2-Core'
}

{ #category : #initialization }
RTLineDecoration >> initialize [
	super initialize.
	attachPoint := RTCenteredAttachPoint new.
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
	size := [ :e |  aNumberOrBlockOrIdentifier rtValue: e].
	
]

{ #category : #hooks }
RTLineDecoration >> trachelShapeClass [
	^ TRAbstractLineDecoratorShape 
]

{ #category : #public }
RTLineDecoration >> trachelShapeFor: anEdge [
	|f shape |
	f :=  anEdge from position.
	(line ~= nil)
		ifTrue: [ | tShape |
			tShape := line trachelShapeFor: anEdge.
			tShape class = TRBezierShape 
				ifTrue: [	f := tShape points allButLast last ]].
	shape := self trachelShapeClass from: f to: anEdge to position width: (self widthFor: anEdge) size: self mySize color: (self colorFor: anEdge) stroke: (self colorFor: anEdge).
	^ shape
]

{ #category : #hooks }
RTLineDecoration >> updateFor: edge trachelShape: trachelShape [
	| f |
	f := (attachPoint endingPointOf: edge).
	(line ~= nil)
		ifTrue: [ 
			trachelShape class = TRBezierShape 
				ifTrue: [	f := trachelShape points allButLast last ]].
	trachelShape from: (attachPoint startingPointOf: edge).
	trachelShape to: f.
	trachelShape color: (self colorFor: edge).
	trachelShape width: (self widthFor: edge).
	trachelShape resetPath

]

{ #category : #accessing }
RTLineDecoration >> width: aBlockOrValue [
	width := aBlockOrValue
]

{ #category : #hooks }
RTLineDecoration >> widthFor: anElement [
	^ width rtValue: anElement
]
