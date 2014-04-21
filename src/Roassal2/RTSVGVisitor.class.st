"
A RTSVGVisitor is a RTVisitor for SVG exporting.

"
Class {
	#name : #RTSVGVisitor,
	#superclass : #RTVisitor,
	#instVars : [
		'view',
		'stream',
		'afterStream',
		'canvas',
		'interactions',
		'markers',
		'center',
		'names',
		'count'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #visitor }
RTSVGVisitor class >> visit: view on: stream [
	self new view: view; stream: stream; visit; yourself.
]

{ #category : #visitor }
RTSVGVisitor class >> visit: view on: stream canvas: aRectangle [
	self new view: view; stream: stream; canvas: aRectangle; visit; yourself.
]

{ #category : #visitor }
RTSVGVisitor class >> visit: view on: stream center: aPoint [
	self new view: view; stream: stream; center: aPoint; visit; yourself.
]

{ #category : #visitor }
RTSVGVisitor class >> visit: view on: stream with: interactions [
	self new view: view; stream: stream; interactions: interactions; visit; yourself.
]

{ #category : #visitor }
RTSVGVisitor class >> visit: view on: stream with: interactions canvas: aRectangle [
	self new view: view; stream: stream; interactions: interactions; canvas: aRectangle; visit; yourself.
]

{ #category : #visitor }
RTSVGVisitor class >> visit: view on: stream with: interactions canvas: aRectangle center: aPoint [
	self new view: view; stream: stream; interactions: interactions; canvas: aRectangle; center: aPoint; visit; yourself.
]

{ #category : #interactions }
RTSVGVisitor >> addContainedInteractions: id element: element [
	| aNumber |
	[aNumber := self alignPoint: (element trachelShape center)] on: Error do: [aNumber := 0].
	(interactions at: element ifAbsent: [OrderedCollection new]) 
		do: [ :i |	 i contained = true
			ifTrue: [ i addEventHandlers: stream id: id  element: element center: aNumber] ]
]

{ #category : #utils }
RTSVGVisitor >> addCurves: points [
	points size >= 3
		ifTrue: [
			stream
				nextPut: $S.
			(1 to: points size - 1) do: [ :i | |p1 p2|
					p1 := (points at: i).
					p2 := ((points at: i) + (points at: i + 1) / 2 ).
					stream
						nextPutAll: ('<1p>,<2p> ' expandMacrosWith: p1 x rounded with: p1 y rounded);
						nextPutAll: ('<1p>,<2p> ' expandMacrosWith: p2 x rounded with: p2 y rounded) 		
				].
			stream
				nextPutAll: ('L<1p>,<2p>" ' expandMacrosWith: points last x rounded with: points last y rounded).
			]
		ifFalse: [		
			points size == 2
				ifTrue: [  
					stream
						nextPutAll: ('Q<1p>,<2p> ' expandMacrosWith: points first x rounded with: points first y rounded);
						nextPutAll: ('<1p>,<2p>" ' expandMacrosWith: points second x rounded with: points second y rounded) 
					] .			
			points size == 3
				ifTrue: [  
					stream
						nextPutAll: ('C<1p>,<2p> ' expandMacrosWith: points first x rounded with: points first y rounded);
						nextPutAll: ('<1p>,<2p> ' expandMacrosWith: points second x rounded with: points second y rounded);
						nextPutAll: ('<1p>,<2p>" ' expandMacrosWith: points last x rounded with: points last y rounded) 
					] ]
]

{ #category : #interactions }
RTSVGVisitor >> addEmbeddingInteractions: id element: element [
	|closings aNumber |
	[aNumber := self alignPoint: (element trachelShape center)] on: Error do: [aNumber := 0].
	closings := OrderedCollection new.
	(interactions at: element ifAbsent: [OrderedCollection new]) 
		do: [ :i |	 (i external = false and: i contained = false)
			ifTrue: [ closings add: (i addEventHandlers: stream id: id  element: element center: aNumber)] ].
	^(closings reverse)
]

{ #category : #interactions }
RTSVGVisitor >> addExternalInteractions: id element: element [
	| aNumber |
	[aNumber := self alignPoint: (element trachelShape center)] on: Error do: [aNumber := 0].
	(interactions at: element ifAbsent: [OrderedCollection new]) 
		do: [ :i |	 i external = true
			ifTrue: [ self afterStream add: [:e | i addEventHandlers: stream id: id  element: element center: aNumber] ]]
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addFillColor: color [
	color = nil
		ifTrue: [
			stream
				nextPutAll: 'fill:none; '
			  ]
		ifFalse: [  
			stream
				nextPutAll:
					('fill:rgb(<1p>,<2p>,<3p>); '
						expandMacrosWith: (color red * 256) rounded
						with: (color green * 256) rounded
						with: (color blue * 256) rounded)]
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addFillOpacity: fillColor [
	stream nextPutAll: ('fill-opacity:<1p>; ' expandMacrosWith: fillColor alpha)
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addMarker: aLineDecoration [
	stream nextPutAll: 'marker-end = "url(#marker' , (self getDecorationId: aLineDecoration) , ')" '
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addPath: pathString [
	stream nextPutAll: 'd="' , pathString , '" '
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addPositionCX: x cy: y rx: rx ry: ry [
	stream
		nextPutAll:
				('cx="<1p>" cy="<2p>" rx="<3p>" ry="<4p>" ' expandMacrosWith: x with: y with: rx with: ry).
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addPositionFrom: aPoint to: aPoint2 [
	stream
		nextPutAll: ('x1="<1p>" y1="<2p>" ' expandMacrosWith: aPoint x rounded with: aPoint y rounded);
		nextPutAll: ('x2="<1p>" y2="<2p>" ' expandMacrosWith: aPoint2 x rounded with: aPoint2 y rounded)
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addPositionX: x y: y [
	stream
		nextPutAll:
				('x="<1p>" y="<2p>" ' expandMacrosWith: x with: y).
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addRotation: angle point: point [
	stream nextPutAll: ('rotate(<1p>,<2p>,<3p>) ' expandMacrosWith: angle with: point x rounded with: point y rounded)
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addScale: anInteger [
	stream nextPutAll: ('scale(<1p>) ' expandMacrosWith: anInteger)
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addStringWithFont: aByteString [
	| converter |
	converter := RTSVGStringConverter new.
	stream
		nextPutAll: '<tspan font-family = "Arial, Helvetica, sans-serif">';
		nextPutAll: (converter convertString: aByteString);
		nextPutAll: '</tspan>'
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addStrokeColor: aColor [
	stream
		nextPutAll:
			('stroke:rgb(<1p>,<2p>,<3p>); '
				expandMacrosWith: (aColor red * 256) rounded
				with: (aColor green * 256) rounded
				with: (aColor blue * 256) rounded)
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addStrokeOpacity: aColor [
	stream nextPutAll: ('stroke-opacity:<1p>; ' expandMacrosWith: aColor alpha)
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addStrokeWidth: aSmallInteger [
	stream nextPutAll: ('stroke-width:<1p>; ' expandMacrosWith: aSmallInteger)
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addTranslation: point [
	stream nextPutAll: ('translate(<1p>,<2p>) ' expandMacrosWith: point x rounded with: point y rounded)
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> addWidth: x height: y [
	stream
		nextPutAll:
				('width="<1p>" height="<2p>" ' expandMacrosWith: x with: y).
]

{ #category : #accessing }
RTSVGVisitor >> afterStream [
	"Collection of evaluation promises, needed to write instructions, such as popups, after the actual svg code of the elements"
	^ afterStream
]

{ #category : #accessing }
RTSVGVisitor >> afterStream: anObject [
	afterStream := anObject
]

{ #category : #alignment }
RTSVGVisitor >> alignLine: aLine [
	|distanceX distanceY fromX fromY|
	distanceX := canvas topLeft x negated + center x.
	distanceY := canvas topLeft y negated + center y.
	fromX := aLine from x + distanceX.
	fromY := aLine from y + distanceY.
	^(TRLineShape new from: fromX@fromY; to: (fromX + aLine to x) @ (fromY + aLine to y))
	
]

{ #category : #alignment }
RTSVGVisitor >> alignPoint: aPoint [
	|distanceX distanceY originX originY|
	distanceX := canvas topLeft x negated + center x.
	distanceY := canvas topLeft y negated + center y.
	originX := aPoint x + distanceX.
	originY := aPoint y + distanceY.
	^originX@originY
	
]

{ #category : #alignment }
RTSVGVisitor >> alignRectangle: aRectangle [
	|distanceX distanceY originX originY|
	distanceX := canvas topLeft x negated + center x.
	distanceY := canvas topLeft y negated + center y.
	originX := aRectangle topLeft x + distanceX.
	originY := aRectangle topLeft y + distanceY.
	^Rectangle origin: originX@originY corner: (originX + aRectangle width) @ (originY + aRectangle height)
	
]

{ #category : #accessing }
RTSVGVisitor >> canvas [

	^canvas
]

{ #category : #accessing }
RTSVGVisitor >> canvas: aCanvas [

	canvas := aCanvas.
]

{ #category : #accessing }
RTSVGVisitor >> center [
	^center
]

{ #category : #accessing }
RTSVGVisitor >> center: aPoint [
	center := aPoint
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> closeDef [
	stream nextPutAll: '/>' , String cr
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> closeDef: type [ 
	stream 
		nextPutAll: '</',type,'>';
		nextPutAll: String cr
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> closeDefWithContent [
	stream nextPutAll: '>' , String cr
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> closeTag [
	stream nextPutAll: '" '
]

{ #category : #utils }
RTSVGVisitor >> count [
	count ifNil: [ count := 0 ].
	count := count + 1.
	^count
]

{ #category : #drawing }
RTSVGVisitor >> drawArc: element center: aCenter innerRadius: aNumber outterRadius: anotherNumber alphaAngle: anAngle betaAngle: anotherAngle color: aColor [
	| start end p1 p2 aAngle bAngle sweepFlag alpha beta id closings |
	id := self getId: element.
	names at: element put: id.
	alpha := self makePositive: anAngle.
	beta := self makePositive: anotherAngle.
	alpha > beta
		ifTrue: [ sweepFlag := 1 ]
		ifFalse: [ sweepFlag := 0 ].
	aAngle := self toRadian: alpha.
	bAngle := self toRadian: beta.
	start := self getPointFrom: aCenter angle: aAngle radius: aNumber.
	end := self getPointFrom: aCenter angle: bAngle radius: aNumber.
	p1 := self getPointFrom: aCenter angle: aAngle radius: anotherNumber.
	p2 := self getPointFrom: aCenter angle: bAngle radius: anotherNumber.
	closings := self addEmbeddingInteractions: 'arc' , id element: element.
	stream
		nextPutAll: '<path id="arc' , id , '" ';
		nextPutAll: ('d="M<1p>,<2p> ' expandMacrosWith: start x with: start y);
		nextPutAll: ('L<1p>,<2p> ' expandMacrosWith: p1 x with: p1 y);
		nextPutAll: ('A<1p>,<2p> 0 <3p>,1 ' expandMacrosWith: anotherNumber with: anotherNumber with: sweepFlag);
		nextPutAll: ('<1p>,<2p> ' expandMacrosWith: p2 x with: p2 y);
		nextPutAll: ('L<1p>,<2p> ' expandMacrosWith: end x with: end y);
		nextPutAll: ('A<1p>,<2p> 0 <3p>,0 ' expandMacrosWith: aNumber with: aNumber with: sweepFlag);
		nextPutAll: ('<1p>,<2p>z" ' expandMacrosWith: start x with: start y);
		nextPutAll: 'style="'.
	self addFillColor: aColor.
	stream nextPutAll: ' class="'.
	self addContainedInteractions: 'arc' , id element: element.
	stream
		nextPutAll: '"';
		nextPutAll: '/>' , String cr.
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: 'arc' , id element: element
]

{ #category : #drawing }
RTSVGVisitor >> drawArrow: id borderColor: anotherColor width: aNumber size: anotherNumber [ 
	|xExtent yExtent|
	xExtent := 10.
	yExtent := 10.
	self openDef: 'marker' label: 'marker' id: id. 
	stream
		nextPutAll:  ('viewBox = "0 0 <1p> <2p>" ' expandMacrosWith: xExtent with: yExtent);
		nextPutAll:  ('refX = "<1p>" refY = "<2p>" ' expandMacrosWith: xExtent with: ((yExtent/2) rounded));
		nextPutAll:  ('markerWidth = "<1p>" markerHeight = "<1p>" ' expandMacrosWith: anotherNumber);
		nextPutAll: 'orient = "auto">',String cr.
	stream
		nextPutAll: '<path d="';
		nextPutAll: ('M 0 0 L <1p> <2p> L 0 <1p> "' expandMacrosWith: xExtent with: ((yExtent/2) rounded)).
	self startStyle.
	self addFillColor: nil.
	self addStrokeColor: anotherColor.
	self addStrokeWidth: aNumber.
	self closeTag.
	self closeDef.
	self closeDef: 'marker'.
]

{ #category : #drawing }
RTSVGVisitor >> drawArrowHead: id color: aColor borderColor: anotherColor width: aNumber size: anotherNumber [ 
	|xExtent yExtent|
	xExtent := 10.
	yExtent := 10.
	self openDef: 'marker' label: 'marker' id: id. 
	stream
		nextPutAll:  ('viewBox = "0 0 <1p> <2p>" ' expandMacrosWith: xExtent with: yExtent);
		nextPutAll:  ('refX = "<1p>" refY = "<2p>" ' expandMacrosWith: xExtent with: ((yExtent/2) rounded));
		nextPutAll:  ('markerWidth = "<1p>" markerHeight = "<1p>" ' expandMacrosWith: anotherNumber);
		nextPutAll: 'orient = "auto">',String cr.
	stream
		nextPutAll: '<path d="';
		nextPutAll: ('M 0 0 L <1p> <2p> L 0 <1p> z"' expandMacrosWith: xExtent with: ((yExtent/2) rounded)).
	self startStyle.
	self addFillColor: aColor.
	self addStrokeColor: anotherColor.
	self addStrokeWidth: aNumber.
	self closeTag.
	self closeDef.
	self closeDef: 'marker'.
]

{ #category : #drawing }
RTSVGVisitor >> drawBezierLine: element points: points width: aSmallInteger color: aColor [
	|id closings from to|
	from := names at: (element from).
	to := names at: (element to).
	id := from,'_',to.
	closings := self addEmbeddingInteractions: 'bezier' , id  element: element.
	self openDef: 'path' label: 'bezier' id: id. 
	stream
		nextPutAll: 'name="bezier[]" ';
		nextPutAll: ('d="M<1p>,<2p> ' expandMacrosWith: (points at: 1) x rounded with: (points at: 1) y rounded).
	self addCurves: points allButFirst.
	self startStyle.
	self addFillColor: nil.
	self addStrokeColor: aColor.
	self addStrokeOpacity: aColor.
	self addStrokeWidth: aSmallInteger.
	self closeTag.
	self startClass.
	self addContainedInteractions: ('bezier',id) element: element.
	self closeTag.
	self closeDef.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('bezier',id) element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawBezierLine: element points: points width: aSmallInteger color: aColor decoration: aLineDecoration [
	|id closings from to|
	from := names at: (element from).
	to := names at: (element to).
	id := from,'_',to.
	closings := self addEmbeddingInteractions: 'bezier' , id  element: element.
	self openDef: 'path' label: 'bezier' id: id. 
	stream
		nextPutAll: 'name="bezier[]" ';
		nextPutAll: ('d="M<1p>,<2p> ' expandMacrosWith: (points at: 1) x rounded with: (points at: 1) y rounded).
	self addCurves: points allButFirst.
	self startStyle.
	self addFillColor: nil.
	self addStrokeColor: aColor.
	self addStrokeOpacity: aColor.
	self addStrokeWidth: aSmallInteger.
	self closeTag.
	self addMarker: aLineDecoration.
	self startClass.
	self addContainedInteractions: ('bezier',id) element: element.
	self closeTag.
	self closeDef.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('bezier',id) element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawBitMap: element form: form box: aRectangle [
	|id closings|
	id := self getId: element.
	names at: element put: id.
	closings := self addEmbeddingInteractions: 'bitmap' , id  element: element.
	stream
		nextPutAll: '<image id="bitmap',id,'" ';
		nextPutAll: ('x="<1p>" y="<2p>"' expandMacrosWith: (aRectangle topLeft x rounded) with: (aRectangle topLeft y rounded) );
		nextPutAll: (' height="<1p>" width="<2p>" ' expandMacrosWith: (aRectangle height rounded) with: (aRectangle width rounded));
		nextPutAll: ' xlink:href="data:image/png;base64,',form,'" ';
		nextPutAll: ' class="'.
	self addContainedInteractions: ('bitmap',id) element: element.
	stream
		nextPutAll: '"';				
		nextPutAll: '/>',String cr.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('bitmap',id) element: element. 
]

{ #category : #drawing }
RTSVGVisitor >> drawDiamond: id color: aColor borderColor: anotherColor width: aNumber size: anotherNumber [ 
	|xExtent yExtent|
	xExtent := 10.
	yExtent := 10.
	self openDef: 'marker' label: 'marker' id: id. 
	stream
		nextPutAll:  ('viewBox = "0 0 <1p> <2p>" ' expandMacrosWith: xExtent with: yExtent);
		nextPutAll:  ('refX = "<1p>" refY = "<2p>" ' expandMacrosWith: xExtent with: ((yExtent/2) rounded));
		nextPutAll:  ('markerWidth = "<1p>" markerHeight = "<2p>" ' expandMacrosWith: (3 *anotherNumber) with: anotherNumber);
		nextPutAll: 'orient = "auto">',String cr.
	stream
		nextPutAll: '<path d="';
		nextPutAll: ('M 0 0 L <1p> <2p> L 0 <3p> L -<1p> <2p> z"' expandMacrosWith: xExtent with: ((yExtent/2) rounded) with: yExtent).
	self startStyle.
	self addFillColor: aColor.
	self addStrokeColor: anotherColor.
	self addStrokeWidth: aNumber.
	self closeTag.
	self closeDef.
	self closeDef: 'marker'.
]

{ #category : #drawing }
RTSVGVisitor >> drawLine: element from: aPoint to: aPoint2 width: aSmallInteger color: aColor [ 
	| id closings from to |
	from := names at: element from.
	to := names at: element to.
	id := from , '_' , to.
	closings := self addEmbeddingInteractions: 'line' , id element: element.
	self openDef: 'line' label: 'line' id: id.
	self addPositionFrom: aPoint to: aPoint2.
	self startStyle.
	self addStrokeColor: aColor.
	self addStrokeOpacity: aColor.
	self addStrokeWidth: aSmallInteger.
	self closeTag.
	self startClass.
	self addContainedInteractions: 'line' , id element: element.
	self closeTag.
	self closeDef.
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: 'line' , id element: element
]

{ #category : #drawing }
RTSVGVisitor >> drawLine: element from: aPoint to: aPoint2 width: aSmallInteger color: aColor decoration: aLineDecoration [
	| id closings from to |
	from := names at: element from.
	to := names at: element to.
	id := from , '_' , to.
	closings := self addEmbeddingInteractions: 'line' , id element: element.
	self openDef: 'line' label: 'line' id: id.
	self addPositionFrom: aPoint to: aPoint2.
	self startStyle.
	self addStrokeColor: aColor.
	self addStrokeOpacity: aColor.
	self addStrokeWidth: aSmallInteger.
	self closeTag.
	self addMarker: aLineDecoration.
	self startClass.
	self addContainedInteractions: 'line' , id element: element.
	self closeTag.
	self closeDef.
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: 'line' , id element: element
]

{ #category : #drawing }
RTSVGVisitor >> drawOval: element box: aRectangle color: aColor borderWidth: aSmallInteger borderColor: aColor4 [ 
	|aCenter w h id closings|
	id := self getId: element.
	names at: element put: id.
	aCenter := aRectangle center.
	w := aRectangle width.
	h := aRectangle height.
	closings := self addEmbeddingInteractions: 'ellipse' , id  element: element.
	self openDef: 'ellipse' label: 'ellipse' id: id. 
	self addPositionCX: (aCenter x rounded) cy: (aCenter y rounded) rx: ((w/ 2) rounded) ry: ((h /2) rounded).
	self startStyle.
	self addFillColor: aColor.
	self addFillOpacity: aColor.
	(aSmallInteger > 0 and: aColor4 ~= nil)
		ifTrue: [ 
			self addStrokeColor: aColor4.
			self addStrokeWidth: aSmallInteger ].
	self closeTag.
	self startClass.
	self addContainedInteractions: ('ellipse', id) element: element.
	self closeTag.
	self closeDef.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('ellipse', id)  element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawPath: element svg: pathString width: aSmallInteger fillColor: fillColor borderColor: borderColor scale: anInteger [
	| distanceX distanceY id closings |
	id := self getId: element.
	names at: element put: id.
	distanceX := center x.
	distanceY := center y.
	closings := self addEmbeddingInteractions: 'p' , id element: element.
	self openDef: 'path' label: 'p' id: id.
	self addPath: pathString.
	self startStyle.
	self addFillColor: fillColor.
	self addFillOpacity: fillColor.
	self addStrokeColor: borderColor.
	self addStrokeWidth: aSmallInteger.
	self closeTag.
	self transformStart.
	self addTranslation: distanceX @ distanceY.
	self addScale: anInteger.
	self closeTag.
	self startClass.
	self addContainedInteractions: 'p' , id element: element.
	self closeTag.
	self closeDef.
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: 'p' , id element: element
]

{ #category : #drawing }
RTSVGVisitor >> drawRectangle: element box: aRectangle fillColor: fillColor borderWidth: aSmallInteger borderColor: aColor [
	| id closings |
	id := self getId: element.
	names at: element put: id.
	closings := self addEmbeddingInteractions: 'rect' , id element: element.
	self openDef: 'rect' label: 'rect' id: id.
	self addPositionX: aRectangle topLeft x rounded y: aRectangle topLeft y rounded.
	self addWidth: aRectangle width rounded height: aRectangle height rounded.
	self startStyle.
	self addFillColor: fillColor.
	self addFillOpacity: fillColor.
	(aSmallInteger > 0 and: aColor ~= nil)
		ifTrue: [ 
			self addStrokeColor: aColor.
			self addStrokeWidth: aSmallInteger ].
	self closeTag.
	self startClass.
	self addContainedInteractions: 'rect' , id element: element.
	self closeTag.
	self closeDef.
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: 'rect' , id element: element
]

{ #category : #drawing }
RTSVGVisitor >> drawString: element text: aByteString at: aPoint color: color [
	|p id closings box|
	id := self getId: element.
	names at: element put: id.
	p := aPoint.
	closings := self addEmbeddingInteractions: 'text' , id  element: element.
	box := TRLabelShape new text: aByteString; encompassingRectangle.
	
	self openDef: 'text' label: 'text' id: id.
	self addPositionX: (p x - (box width / 5)) rounded y: (p y + (box height / 4)) rounded.
	self startStyle.
	self addFillColor: color.
	self closeTag.
	self startClass.
	self addContainedInteractions:('text',id)  element: element.
	self closeTag.
	self closeDefWithContent.
	self addStringWithFont: aByteString.
	self closeDef: 'text'. 
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions:('text',id)  element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawString: element text: aByteString at: aPoint color: color angle: angle [
	| p id closings box |
	id := self getId: element.
	names at: element put: id.
	p := aPoint.
	closings := self addEmbeddingInteractions: 'text' , id element: element.
	box := TRLabelShape new
		text: aByteString;
		encompassingRectangle.
		
	self openDef: 'text' label: 'text' id: id.
	self addPositionX: (p x - (box width / 5)) rounded y: (p y + (box height / 4)) rounded.
	self startStyle.
	self addFillColor: color.
	self closeTag.
	self transformStart.
	self addRotation: angle point: p.
	self closeTag.
	self startClass.
	self addContainedInteractions: 'text' , id element: element.
	self closeTag.
	self closeDefWithContent.
	self addStringWithFont: aByteString.
	self closeDef: 'text'. 
	closings do: [ :c | stream nextPutAll: c ].
	self addExternalInteractions: 'text' , id element: element
]

{ #category : #alignment }
RTSVGVisitor >> fixedEncompassingRectangle [
 	| shapes |
	shapes := self view canvas shapes.
	canvas := shapes first encompassingRectangle.
	shapes do: [ :s| |rect|
				rect := s encompassingRectangle.
				rect height < 0 
					ifTrue: [ rect := Rectangle origin: rect bottomLeft corner: rect topRight].
				canvas := canvas merge: rect.
				 ].
	^canvas 
]

{ #category : #utils }
RTSVGVisitor >> getCorrespondingLine: decorator from: lines [
	lines do: [ :l |
		^(l class = TRBezierShape) 
			ifTrue: [ decorator to = l points last ifTrue: [ lines remove: l. {l . decorator} ] ]
			ifFalse: [ decorator to = l to ifTrue: [ lines remove: l. {l . decorator} ] ].
		 ]
]

{ #category : #utils }
RTSVGVisitor >> getDecorationId: aLineDecorationShape [
	|t w c s lw|
	t := aLineDecorationShape type.
	w := aLineDecorationShape mySize.
	c := aLineDecorationShape color.
	s := aLineDecorationShape strokePaint.
	lw := aLineDecorationShape width.
	^(t asString, w asString, ((c red * 256) + (s red * 256)) rounded asString, ((c green * 256) + (s green * 256)) rounded asString, ((c blue * 256) + (s blue * 256)) rounded asString, lw asString)
	
]

{ #category : #utils }
RTSVGVisitor >> getId: element [
	^ element identityHash asString
]

{ #category : #utils }
RTSVGVisitor >> getPointFrom: aCenter angle: anAngle radius: aNumber [
	|x y|
	x := (aCenter x + (anAngle cos * aNumber)) rounded.
	y := (aCenter y + (anAngle sin * aNumber)) rounded.
	^  x@y
]

{ #category : #initialization }
RTSVGVisitor >> initialize [
	afterStream := OrderedCollection new.
	interactions := Dictionary new.
	markers := OrderedCollection new.
	center := 1@1.
	names := Dictionary new.
]

{ #category : #accessing }
RTSVGVisitor >> interactions [
	^ interactions
]

{ #category : #accessing }
RTSVGVisitor >> interactions: anObject [
	interactions := anObject
]

{ #category : #utils }
RTSVGVisitor >> makePositive: anAngle [
	| result |
	anAngle < 0
		ifTrue: [ result := anAngle + 360 ]
		ifFalse: [ result := anAngle ].
	^ result
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> openDef: type label: label id: id [
	stream nextPutAll: '<',type,' id="',label , id , '" '
]

{ #category : #utils }
RTSVGVisitor >> separateDecorated: lines decorations: decorations [
	|decorated|
	decorated := OrderedCollection new.
	decorations do: [ :d | 
		decorated add: (self getCorrespondingLine: d from: lines).
		].
	^decorated
]

{ #category : #visitor }
RTSVGVisitor >> setCanvas [
	self canvas = nil
		ifTrue: [ self fixedEncompassingRectangle ]
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> startClass [
	stream nextPutAll: 'class="'
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> startStyle [
	stream nextPutAll: 'style="'
]

{ #category : #accessing }
RTSVGVisitor >> stream [

	^stream
]

{ #category : #accessing }
RTSVGVisitor >> stream: aStream [

	stream := aStream.
]

{ #category : #utils }
RTSVGVisitor >> toRadian: anAngle [
	| result |
	result := Float pi * anAngle / 180.
	^ result
]

{ #category : #'drawing-primitives' }
RTSVGVisitor >> transformStart [
	stream nextPutAll: 'transform="'
]

{ #category : #accessing }
RTSVGVisitor >> view [

	^view
]

{ #category : #accessing }
RTSVGVisitor >> view: aView [

	view := aView.
]

{ #category : #visitor }
RTSVGVisitor >> visit [
	self setCanvas.
	self visitView: self view.
	self afterStream do: [ :s | s value: 1 ]
]

{ #category : #visitor }
RTSVGVisitor >> visitAbstractLine: anAbstractLine [
	anAbstractLine accept: anAbstractLine
	
]

{ #category : #visitor }
RTSVGVisitor >> visitAbstractLineDecorationShape: anAbstractLineDecoration [
	anAbstractLineDecoration accept: anAbstractLineDecoration
	
]

{ #category : #visitor }
RTSVGVisitor >> visitArcShape: aShape [
	|center|
	center := self alignPoint: (aShape center).
	self drawArc: aShape element 
		center: center
		innerRadius: aShape innerRadius
		outterRadius: aShape externalRadius 
		alphaAngle: aShape alphaAngle 
		betaAngle: aShape betaAngle 
		color: aShape color
]

{ #category : #visitor }
RTSVGVisitor >> visitArrowHeadShape: arrowHeadShape [
	| aid color bColor w s|
	aid := self getDecorationId: arrowHeadShape.
	color := arrowHeadShape color.
	bColor := arrowHeadShape strokePaint.
	w := arrowHeadShape width.
	s := arrowHeadShape mySize.
	(markers contains: aid)
		ifFalse: [  
			self drawArrowHead: aid color: color borderColor: bColor width: w size: s.
			markers add: aid. 
			]
		
	
]

{ #category : #visitor }
RTSVGVisitor >> visitArrowShape: arrowShape [
	| aid bColor w s|
	aid := self getDecorationId: arrowShape.
	bColor := arrowShape strokePaint.
	w := arrowShape width.
	s := arrowShape mySize.
	(markers contains: aid)
		ifFalse: [  
			self drawArrow: aid borderColor: bColor width: w size: s.
			markers add: aid. 
			]
		
	
]

{ #category : #visitor }
RTSVGVisitor >> visitBezierShape: aBezierShape [
	|points|
	points:= aBezierShape points copy.
	points := points collect: [ :p | self alignPoint: p].
	self drawBezierLine: (aBezierShape element) points: points width: (aBezierShape width) color: (aBezierShape strokePaint)
]

{ #category : #visitor }
RTSVGVisitor >> visitBezierShape: aBezierShape with: aLineDecoration [
	|points|
	points:= aBezierShape points copy.
	points := points collect: [ :p | self alignPoint: p].
	self drawBezierLine: (aBezierShape element) points: points width: (aBezierShape width) color: (aBezierShape strokePaint) decoration: aLineDecoration
]

{ #category : #visitor }
RTSVGVisitor >> visitBitMapShape: aBitmapShape [
	| form box|
	form := aBitmapShape form.
	box := self alignRectangle: (aBitmapShape encompassingRectangle).
	self drawBitMap: aBitmapShape element form: form box: box.
	
]

{ #category : #visitor }
RTSVGVisitor >> visitBoxShape: aBox [
	|borderColor fillColor box|
	((aBox color) isNil)
		ifTrue: [ fillColor := Color r: 0 g: 0 b: 0]
		ifFalse: [ fillColor := aBox color].
	((aBox strokePaint) isNil)
		ifFalse: [ borderColor := aBox strokePaint].
	box := self alignRectangle: (aBox encompassingRectangle).
	self drawRectangle: aBox element
		box: box
		fillColor: fillColor 
		borderWidth: 1 
		borderColor: borderColor 
]

{ #category : #visitor }
RTSVGVisitor >> visitCanvas: aCanvas [
	|elementShapes edgeShapes decoratedEdgeShapes decorationShapes lineClasses lineDecorationClasses|
	lineClasses := {TRLineShape . TRBezierShape}.	
	lineDecorationClasses := TRAbstractLineDecoratorShape withAllSubclasses.
	elementShapes := aCanvas shapes reject: [ :e |  (lineClasses includes: e class)  or: [ lineDecorationClasses includes: e class  ]].
	edgeShapes := (aCanvas shapes select: [ :e |  (lineClasses includes: e class)] ) asOrderedCollection.
	decorationShapes := aCanvas shapes select: [ :e |  lineDecorationClasses includes: e class].
	decoratedEdgeShapes := self separateDecorated: edgeShapes decorations: decorationShapes.
	
	stream 
		nextPutAll: '<defs>'.
	decorationShapes do: [:s | s accept: self ].
	stream 
		nextPutAll: '</defs>'.	
	elementShapes do:[:s | s accept: self].
	edgeShapes do:[:s | s accept: self].
	decoratedEdgeShapes do:[:p | p first accept: self with: p second].
]

{ #category : #visitor }
RTSVGVisitor >> visitCompositeShape: aCompositeShape [
	aCompositeShape shape1 accept: self.
	aCompositeShape shape2 accept: self.
]

{ #category : #visitor }
RTSVGVisitor >> visitDiamondShape: diamondShape [
	| aid color bColor w s|
	aid := self getDecorationId: diamondShape.
	color := diamondShape color.
	bColor := diamondShape strokePaint.
	w := diamondShape width.
	s := diamondShape mySize.
	(markers contains: aid)
		ifFalse: [  
			self drawDiamond: aid color: color borderColor: bColor width: w size: s.
			markers add: aid. 
			]
		
	
]

{ #category : #visitor }
RTSVGVisitor >> visitEllipseShape: anEllipse [	
	|borderColor fillColor box|
	((anEllipse color) isNil)
		ifTrue: [ fillColor := Color r: 0 g: 0 b: 0]
		ifFalse: [ fillColor := anEllipse color].
	((anEllipse strokePaint) isNil)
		ifFalse: [ borderColor := anEllipse strokePaint].
	box := self alignRectangle: (anEllipse encompassingRectangle).
	self drawOval: anEllipse element 
		box: box
		color: fillColor 
		borderWidth: 1 
		borderColor: borderColor 
]

{ #category : #visitor }
RTSVGVisitor >> visitGroup: aRTGroup [
	aRTGroup accept: self.
]

{ #category : #visitor }
RTSVGVisitor >> visitLabelShape: aLabel [
	| color rectangle position text |
	color := aLabel color.	
	rectangle := aLabel encompassingRectangle.
	position := self alignPoint: ((rectangle topLeft x + (rectangle width/4)) @ rectangle center y).
	text := aLabel text.
	self drawString: aLabel element text: text at: position color: color.
]

{ #category : #visitor }
RTSVGVisitor >> visitLineShape: aLine [
	|startingPoint endingPoint|
	startingPoint := self alignPoint: (aLine from).
	endingPoint := self alignPoint: (aLine to).
	self drawLine: (aLine element) from: startingPoint to: endingPoint width: 1 color: (aLine strokePaint).
]

{ #category : #visitor }
RTSVGVisitor >> visitLineShape: aLine with: aLineDecoration [
	|startingPoint endingPoint|
	startingPoint := self alignPoint: (aLine from).
	endingPoint := self alignPoint: (aLine to).
	self drawLine: (aLine element) from: startingPoint to: endingPoint width: 1 color: (aLine strokePaint) decoration: aLineDecoration.
]

{ #category : #visitor }
RTSVGVisitor >> visitMondrianViewBuilder: aView [
	aView view accept: self
]

{ #category : #visitor }
RTSVGVisitor >> visitNoShape: aNoShape [
	"Do nothing"
]

{ #category : #visitor }
RTSVGVisitor >> visitRotatedLabelShape: aRotatedLabel [
	| color rectangle position text angle |
	color := aRotatedLabel color.	
	rectangle := aRotatedLabel encompassingRectangle.
	position := self alignPoint: ((rectangle topLeft x + (rectangle width/4)) @ rectangle center y).
	text := aRotatedLabel text.
	angle := aRotatedLabel angle.
	self drawString: aRotatedLabel element text: text at: position color: color angle: angle.
]

{ #category : #visitor }
RTSVGVisitor >> visitSVGPath: aSVGPath [
	|borderColor fillColor|
	((aSVGPath color) isNil)
		ifTrue: [ fillColor := Color r: 0 g: 0 b: 0]
		ifFalse: [ fillColor := aSVGPath color].
	((aSVGPath strokePaint) isNil)
		ifTrue: [ borderColor := fillColor]
		ifFalse: [ borderColor := aSVGPath strokePaint].
	self drawPath: aSVGPath element 
		svg: aSVGPath pathString
		width: 1 
		fillColor: fillColor
		borderColor: borderColor
		scale: aSVGPath scale 
]

{ #category : #visitor }
RTSVGVisitor >> visitShape: aShape [
	aShape accept: self 
]

{ #category : #visitor }
RTSVGVisitor >> visitView: aView [
	aView canvas accept: self
]
