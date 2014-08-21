"
A RTSVGBezierLine is represents the SVG path of a bezier line, as defined in Roassal.
"
Class {
	#name : #RTSVGBezierLine,
	#superclass : #RTSVGAbstractLine,
	#instVars : [
		'points'
	],
	#category : 'Roassal2-Exporter-SVG'
}

{ #category : #adding }
RTSVGBezierLine >> addCurves: stream [
	| rPoints |
	rPoints := self points allButFirst.
	rPoints size >= 3
		ifTrue: [
			stream
				nextPut: $S.
			(1 to: rPoints size - 1) do: [ :i | |p1 p2|
					p1 := (rPoints at: i).
					p2 := ((rPoints at: i) + (rPoints at: i + 1) / 2 ).
					stream
						nextPutAll: ('<1p>,<2p> ' expandMacrosWith: p1 x rounded with: p1 y rounded);
						nextPutAll: ('<1p>,<2p> ' expandMacrosWith: p2 x rounded with: p2 y rounded) 		
				].
			stream
				nextPutAll: ('L<1p>,<2p>" ' expandMacrosWith: rPoints last x rounded with: rPoints last y rounded).
			]
		ifFalse: [		
			rPoints size == 2
				ifTrue: [  
					stream
						nextPutAll: ('Q<1p>,<2p> ' expandMacrosWith: rPoints first x rounded with: rPoints first y rounded);
						nextPutAll: ('<1p>,<2p>" ' expandMacrosWith: rPoints second x rounded with: rPoints second y rounded) 
					] .			
			rPoints size == 3
				ifTrue: [  
					stream
						nextPutAll: ('C<1p>,<2p> ' expandMacrosWith: rPoints first x rounded with: rPoints first y rounded);
						nextPutAll: ('<1p>,<2p> ' expandMacrosWith: rPoints second x rounded with: rPoints second y rounded);
						nextPutAll: ('<1p>,<2p>" ' expandMacrosWith: rPoints last x rounded with: rPoints last y rounded) 
					] ]
]

{ #category : #adding }
RTSVGBezierLine >> addOn: stream using: aSVGVisitor [
	| closings from to|
	from := aSVGVisitor names at: self element from.
	to := aSVGVisitor names at: self element to.
	self id: from , '_' , to.
	closings := self addEmbeddingInteractions: aSVGVisitor.
	self openDef: stream.
	self addPath: stream.
	self startStyle: stream.
	self addFillColor: stream.
	self addStrokeColor: stream.
	self addStrokeOpacity: stream.
	self addStrokeWidth: stream.
	self closeTag: stream.
	self decoration ifNotNil: [ self addMarker: stream ].
	self startClass: stream.
	self addContainedInteractions: aSVGVisitor.
	self closeTag: stream.
	self closeDef: stream.
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: aSVGVisitor
]

{ #category : #adding }
RTSVGBezierLine >> addPath: stream [
	stream
		nextPutAll: 'name="bezier[]" ';
		nextPutAll: ('d="M<1p>,<2p> ' expandMacrosWith: (self points at: 1) x rounded with: (self points at: 1) y rounded).
		self addCurves: stream.
]

{ #category : #accessing }
RTSVGBezierLine >> element: anElement points: somePoints width: anInteger color: aColor [
	self element: anElement.
	self points: somePoints.
	self strokeWidth: anInteger.
	self strokeColor: aColor.
]

{ #category : #accessing }
RTSVGBezierLine >> element: anElement points: somePoints width: anInteger color: aColor decoration: aLineDecoration [
	self element: anElement points: somePoints width: anInteger color: aColor.
	self decoration: aLineDecoration
]

{ #category : #initialization }
RTSVGBezierLine >> initialize [
	self type: 'path'.
	self label: 'bezier'
]

{ #category : #accessing }
RTSVGBezierLine >> points [
	^ points
]

{ #category : #accessing }
RTSVGBezierLine >> points: anObject [
	points := anObject
]
