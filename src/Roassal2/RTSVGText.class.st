"
A RTSVGLine is represents the SVG text of a regular or rotated text, as defined in Roassal.

"
Class {
	#name : #RTSVGText,
	#superclass : #RTSVGEntity,
	#instVars : [
		'x',
		'y',
		'angle',
		'content',
		'fontSize'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGText >> addOn: stream using: aSVGVisitor [
	| closings box |
	aSVGVisitor names at: self element put: self id.
	closings := self addEmbeddingInteractions: aSVGVisitor.
	self openDef: stream.
	self addPosition: stream.
	self startStyle: stream.
	self addFillColor: stream.
	self closeTag: stream.
	self startTransform: stream.
	box := element encompassingRectangle.
	self addRotation: self angle point: (self x)@(self y) into: stream.
	
	self closeTag: stream.
	self startClass: stream.
	self addContainedInteractions: aSVGVisitor.
	self closeTag: stream.
	self closeDefWithContent: stream.
	self addStringWithFont: self content fontSize: self fontSize into: stream.
	self closeFullDef: stream.
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: aSVGVisitor
]

{ #category : #adding }
RTSVGText >> addPosition: stream [
	|box fixX fixY|
	box := TRLabelShape new
		text: self content;
		encompassingRectangle.
	fixX := (self x - (box width / 5)) rounded.
	fixY := (self y + (box height / 4)) rounded.
	
	stream
		nextPutAll:
				('x="<1p>" y="<2p>" ' expandMacrosWith: fixX with: fixY).
]

{ #category : #accessing }
RTSVGText >> angle [
	^ angle
]

{ #category : #accessing }
RTSVGText >> angle: anObject [
	angle := anObject
]

{ #category : #accessing }
RTSVGText >> content [
	^ content
]

{ #category : #accessing }
RTSVGText >> content: anObject [
	content := anObject
]

{ #category : #accessing }
RTSVGText >> element: anElement text: aString at: aPoint color: aColor [	
	self element: anElement text: aString at: aPoint color: aColor angle: nil
]

{ #category : #accessing }
RTSVGText >> element: anElement text: aString at: aPoint color: aColor angle: anAngle [
	self element: anElement.
	self content: aString.
	self x: aPoint x; y: aPoint y.
	self fillColor: aColor.
	self angle: anAngle.
	self fontSize: anElement fontSize.
]

{ #category : #accessing }
RTSVGText >> fontSize [
	^ fontSize
]

{ #category : #accessing }
RTSVGText >> fontSize: anObject [
	fontSize := anObject
]

{ #category : #initialization }
RTSVGText >> initialize [
	self type: 'text'.
	self label: 'text'
]

{ #category : #accessing }
RTSVGText >> x [
	^ x
]

{ #category : #accessing }
RTSVGText >> x: anObject [
	x := anObject
]

{ #category : #accessing }
RTSVGText >> y [
	^ y
]

{ #category : #accessing }
RTSVGText >> y: anObject [
	y := anObject
]
