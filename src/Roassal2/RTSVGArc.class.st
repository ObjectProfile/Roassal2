Class {
	#name : #RTSVGArc,
	#superclass : #RTSVGEntity,
	#instVars : [
		'center',
		'innerRadius',
		'outterRadius',
		'alphaAngle',
		'betaAngle'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGArc >> addOn: stream using: aSVGVisitor [
	| closings |
	aSVGVisitor names at: self element put: self id.
	closings := self addEmbeddingInteractions: aSVGVisitor.
	self openDef: stream.
	self addPath: stream.
	self startStyle: stream.
	self addFillColor: stream.
	self closeTag: stream.
	self startClass: stream.
	self addContainedInteractions: aSVGVisitor.
	self closeTag: stream.
	self closeDef: stream.
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: aSVGVisitor
]

{ #category : #adding }
RTSVGArc >> addPath: stream [
	| p1 sweepFlag end aAngle p2 start alpha beta bAngle |
	alpha := self makePositive: self alphaAngle.
	beta := self makePositive: self betaAngle.
	alpha > beta
		ifTrue: [ sweepFlag := 1 ]
		ifFalse: [ sweepFlag := 0 ].
	aAngle := self toRadian: alpha.
	bAngle := self toRadian: beta.
	start := self getPointFrom: self center angle: aAngle radius: self innerRadius.
	end := self getPointFrom: self center angle: bAngle radius: self innerRadius.
	p1 := self getPointFrom: self center angle: aAngle radius: self outterRadius.
	p2 := self getPointFrom: self center angle: bAngle radius: self outterRadius.
	stream
		nextPutAll: ('d="M<1p>,<2p> ' expandMacrosWith: start x with: start y);
		nextPutAll: ('L<1p>,<2p> ' expandMacrosWith: p1 x with: p1 y);
		nextPutAll: ('A<1p>,<2p> 0 <3p>,1 ' expandMacrosWith: self outterRadius with: self outterRadius with: sweepFlag);
		nextPutAll: ('<1p>,<2p> ' expandMacrosWith: p2 x with: p2 y);
		nextPutAll: ('L<1p>,<2p> ' expandMacrosWith: end x with: end y);
		nextPutAll: ('A<1p>,<2p> 0 <3p>,0 ' expandMacrosWith: self innerRadius with: self innerRadius with: sweepFlag);
		nextPutAll: ('<1p>,<2p>z" ' expandMacrosWith: start x with: start y)
]

{ #category : #accessing }
RTSVGArc >> alphaAngle [
	^ alphaAngle
]

{ #category : #accessing }
RTSVGArc >> alphaAngle: anObject [
	alphaAngle := anObject
]

{ #category : #accessing }
RTSVGArc >> betaAngle [
	^ betaAngle
]

{ #category : #accessing }
RTSVGArc >> betaAngle: anObject [
	betaAngle := anObject
]

{ #category : #accessing }
RTSVGArc >> center [
	^ center
]

{ #category : #accessing }
RTSVGArc >> center: anObject [
	center := anObject
]

{ #category : #accessing }
RTSVGArc >> element: anElement center: aPoint r1: iRadius r2: oRadius aAngle: aAngle bAngle: bAngle color: aColor [
	self element: anElement.
	self center: aPoint.
	self innerRadius: iRadius.
	self outterRadius: oRadius.
	self alphaAngle: aAngle.
	self betaAngle: bAngle.
	self fillColor: aColor.
]

{ #category : #utils }
RTSVGArc >> getPointFrom: aCenter angle: anAngle radius: aNumber [
	|x y|
	x := (aCenter x + (anAngle cos * aNumber)) rounded.
	y := (aCenter y + (anAngle sin * aNumber)) rounded.
	^  x@y
]

{ #category : #initialization }
RTSVGArc >> initialize [
	self type: 'path'.
	self label: 'arc'
]

{ #category : #accessing }
RTSVGArc >> innerRadius [
	^ innerRadius
]

{ #category : #accessing }
RTSVGArc >> innerRadius: anObject [
	innerRadius := anObject
]

{ #category : #utils }
RTSVGArc >> makePositive: anAngle [
	| result |
	anAngle < 0
		ifTrue: [ result := anAngle + 360 ]
		ifFalse: [ result := anAngle ].
	^ result
]

{ #category : #accessing }
RTSVGArc >> outterRadius [
	^ outterRadius
]

{ #category : #accessing }
RTSVGArc >> outterRadius: anObject [
	outterRadius := anObject
]

{ #category : #utils }
RTSVGArc >> toRadian: anAngle [
	| result |
	result := Float pi * anAngle / 180.
	^ result
]
