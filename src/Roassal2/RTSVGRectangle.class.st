"
A RTSVGLine is represents the SVG Rectangle of a regular rectangle, as defined in Roassal.
"
Class {
	#name : #RTSVGRectangle,
	#superclass : #RTSVGEntity,
	#instVars : [
		'box',
		'width',
		'height'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGRectangle >> addOn: stream using: aSVGVisitor [
	| closings |
	aSVGVisitor names at: self element put: self id.
	closings := self addEmbeddingInteractions: aSVGVisitor.
	self openDef: stream.
	self addPosition: stream.
	self addWidth: (self width) height: (self height) into: stream.
	self startStyle: stream.
	self addFillColor: stream.
	self addFillOpacity: stream.
	((self strokeWidth) > 0 and: (self strokeColor) ~= nil)
		ifTrue: [ 
			self addStrokeColor: stream.
			self addStrokeWidth: stream ].	
	self closeTag: stream.
	self startClass: stream.
	self addContainedInteractions: aSVGVisitor.
	self closeTag: stream.
	self closeDef: stream.
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: aSVGVisitor
]

{ #category : #adding }
RTSVGRectangle >> addPosition: stream [
	stream
		nextPutAll:
				('x="<1p>" y="<2p>" ' expandMacrosWith: self box topLeft x rounded with: self box topLeft y rounded).
]

{ #category : #accessing }
RTSVGRectangle >> box [
	^ box
]

{ #category : #accessing }
RTSVGRectangle >> box: anObject [
	box := anObject
]

{ #category : #accessing }
RTSVGRectangle >> element: anElement box: aRectangle fillColor: aColor borderWidth: anInteger borderColor: anotherColor [
	self element: anElement.
	self box: aRectangle.
	self fillColor: aColor.
	self strokeWidth:  anInteger.
	self strokeColor: anotherColor
]

{ #category : #accessing }
RTSVGRectangle >> height [
	height ifNil: [ height := self box height rounded ].
	^ height
]

{ #category : #accessing }
RTSVGRectangle >> height: anObject [
	height := anObject
]

{ #category : #initialization }
RTSVGRectangle >> initialize [
	self type: 'rect'.
	self label: 'rect'
]

{ #category : #accessing }
RTSVGRectangle >> width [
	width ifNil: [ width := self box width rounded ].
	^ width
]

{ #category : #accessing }
RTSVGRectangle >> width: anObject [
	width := anObject
]
