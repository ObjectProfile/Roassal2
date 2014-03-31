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
		'count',
		'interactions',
		'center'
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

{ #category : #utils }
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
				nextPutAll: ('L<1p>,<2p>"' expandMacrosWith: points last x rounded with: points last y rounded).
			]
		ifFalse: [		
			points size == 2
				ifTrue: [  
					stream
						nextPutAll: ('Q<1p>,<2p> ' expandMacrosWith: points first x rounded with: points first y rounded);
						nextPutAll: ('<1p>,<2p>"' expandMacrosWith: points second x rounded with: points second y rounded) 
					] .			
			points size == 3
				ifTrue: [  
					stream
						nextPutAll: ('C<1p>,<2p> ' expandMacrosWith: points first x rounded with: points first y rounded);
						nextPutAll: ('<1p>,<2p> ' expandMacrosWith: points second x rounded with: points second y rounded);
						nextPutAll: ('<1p>,<2p>"' expandMacrosWith: points last x rounded with: points last y rounded) 
					] ]
]

{ #category : #utils }
RTSVGVisitor >> addEmbeddingInteractions: id element: element [
	|closings aNumber |
	[aNumber := self alignPoint: (element trachelShape center)] on: Error do: [aNumber := 0].
	closings := OrderedCollection new.
	(interactions at: element ifAbsent: [OrderedCollection new]) 
		do: [ :i |	 (i external = false and: i contained = false)
			ifTrue: [ closings add: (i addEventHandlers: stream id: id  element: element center: aNumber)] ].
	^(closings reverse)
]

{ #category : #utils }
RTSVGVisitor >> addExternalInteractions: id element: element [
	| aNumber |
	[aNumber := self alignPoint: (element trachelShape center)] on: Error do: [aNumber := 0].
	(interactions at: element ifAbsent: [OrderedCollection new]) 
		do: [ :i |	 i external = true
			ifTrue: [ self afterStream add: [:e | i addEventHandlers: stream id: id  element: element center: aNumber] ]]
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

{ #category : #utils }
RTSVGVisitor >> alignLine: aLine [
	|distanceX distanceY fromX fromY|
	distanceX := canvas topLeft x negated + center x.
	distanceY := canvas topLeft y negated + center y.
	fromX := aLine from x + distanceX.
	fromY := aLine from y + distanceY.
	^(TRLineShape new from: fromX@fromY; to: (fromX + aLine to x) @ (fromY + aLine to y))
	
]

{ #category : #utils }
RTSVGVisitor >> alignPoint: aPoint [
	|distanceX distanceY originX originY|
	distanceX := canvas topLeft x negated + center x.
	distanceY := canvas topLeft y negated + center y.
	originX := aPoint x + distanceX.
	originY := aPoint y + distanceY.
	^originX@originY
	
]

{ #category : #utils }
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

{ #category : #accessing }
RTSVGVisitor >> count [
	|return |
	count = nil 
		ifTrue: [count := 0].
	return := count.
	count := count + 1.
	^return
]

{ #category : #drawing }
RTSVGVisitor >> drawArc: element center: aCenter innerRadius: aNumber outterRadius: anotherNumber alphaAngle: anAngle betaAngle: anotherAngle color: aColor [
	| start end p1 p2 aAngle bAngle sweepFlag alpha beta id closings|
	id := self count asString.
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
	closings := self addEmbeddingInteractions: 'arc' , id  element: element.
	stream
		nextPutAll: '<path id="arc' , id , '" ';
		nextPutAll: ('d="M<1p>,<2p> ' expandMacrosWith: start x with: start y);
		nextPutAll: ('L<1p>,<2p> ' expandMacrosWith: p1 x with: p1 y);
		nextPutAll: ('A<1p>,<2p> 0 <3p>,1 ' expandMacrosWith: anotherNumber with: anotherNumber with: sweepFlag);
		nextPutAll: ('<1p>,<2p> ' expandMacrosWith: p2 x with: p2 y);
		nextPutAll: ('L<1p>,<2p> ' expandMacrosWith: end x with: end y);
		nextPutAll: ('A<1p>,<2p> 0 <3p>,0 ' expandMacrosWith: aNumber with: aNumber with: sweepFlag);
		nextPutAll: ('<1p>,<2p>z" ' expandMacrosWith: start x with: start y);
		nextPutAll:
				('style="fill:rgb(<1p>,<2p>,<3p>);" '
						expandMacrosWith: (aColor red * 256) rounded
						with: (aColor green * 256) rounded
						with: (aColor blue * 256) rounded);
		nextPutAll: 'class="'.
	self addContainedInteractions: 'arc' , id element: element.
	stream
		nextPutAll: '"';
		nextPutAll: '/>' , String cr.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: 'arc' , id element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawBezierLine: element points: points width: aSmallInteger color: aColor [
	|id closings|
	id := self count asString.
	closings := self addEmbeddingInteractions: 'bezier' , id  element: element.
	stream
		nextPutAll: '<path id="bezier',id,'" ';
		nextPutAll: ('d="M<1p>,<2p> ' expandMacrosWith: (points at: 1) x rounded with: (points at: 1) y rounded).
	self addCurves: points allButFirst.
	stream
		nextPutAll:
				(' style="fill:none;stroke:rgb(<1p>,<2p>,<3p>);'
						expandMacrosWith: (aColor red * 256) rounded
						with: (aColor green * 256) rounded
						with: (aColor blue * 256) rounded);
		nextPutAll: ('stroke-width:<1p>;' expandMacrosWith: aSmallInteger);
		nextPutAll: ('stroke-opacity:<1p>" ' expandMacrosWith: aColor alpha);
		nextPutAll: 'class="'.
	self addContainedInteractions: ('bezier',id) element: element.
	stream
		nextPutAll: '"';					
		nextPutAll: '/>',String cr.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('bezier',id) element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawLine: element from: aPoint to: aPoint2 width: aSmallInteger color: aColor [ 
	|id closings|
	id := self count asString.
	closings := self addEmbeddingInteractions: 'line' , id  element: element.
	stream 
		nextPutAll: '<line id="line',id,'" ';
		nextPutAll: ('x1="<1p>" y1="<2p>" ' expandMacrosWith: aPoint x rounded  with: aPoint y rounded);
		nextPutAll: ('x2="<1p>" y2="<2p>" ' expandMacrosWith: aPoint2 x rounded with: aPoint2 y rounded );
		nextPutAll: ('style="stroke:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (aColor red * 256) rounded with: (aColor green * 256) rounded with: (aColor blue * 256) rounded );
		nextPutAll: ('stroke-width:<1p> ' expandMacrosWith: aSmallInteger );
		nextPutAll: ('stroke-opacity:<1p>" ' expandMacrosWith: aColor alpha);
		nextPutAll: 'class="'.
	self addContainedInteractions: ('line',id) element: element.
	stream
		nextPutAll: '"';				
		nextPutAll: '/>',String cr.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('line',id) element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawOval: element box: aRectangle color: aColor borderWidth: aSmallInteger borderColor: aColor4 [ 
	|aCenter w h id closings|
	id := self count asString.
	aCenter := aRectangle center.
	w := aRectangle width.
	h := aRectangle height.
	closings := self addEmbeddingInteractions: 'ellipse' , id  element: element.
	stream 
		nextPutAll: '<ellipse id="ellipse',id,'" ';
		nextPutAll: ('cx= "<1p>" cy="<2p>" ' expandMacrosWith: aCenter x rounded  with: aCenter y rounded);
		nextPutAll: ('rx="<1p>" ry="<2p>" ' expandMacrosWith: (w/ 2) rounded with: (h /2) rounded);
		nextPutAll: ('style="fill:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (aColor red *256) rounded with: (aColor green * 256) rounded with: (aColor blue * 256) rounded );
		nextPutAll: ('fill-opacity:<1p>;' expandMacrosWith: aColor alpha).
	aColor4 = nil
		ifTrue: [ 
			stream nextPutAll: '"'] 
		ifFalse: [  
			stream	
				nextPutAll: ('stroke: rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (aColor4 red *256) rounded with: (aColor4 green * 256) rounded with: (aColor4 blue * 256) rounded );
				nextPutAll: ('stroke-width: <1p>" ' expandMacrosWith: aSmallInteger)].
			stream
				nextPutAll: 'class="'.
	self addContainedInteractions: ('ellipse', id) element: element.
	stream
		nextPutAll: '"';				
		nextPutAll: '/>',String cr.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('ellipse', id)  element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawPath: element svg: pathString width: aSmallInteger fillColor: fillColor borderColor: borderColor scale: anInteger [
	| distanceX distanceY id closings|
	id := self count asString.
	distanceX := canvas topLeft x negated + 1.
	distanceY := canvas topLeft y negated + 1.
	closings := self addEmbeddingInteractions: 'p' , id  element: element.
 	stream 
		nextPutAll: '<path id="p',id,'" ';
		nextPutAll: ('d="',pathString,'" ');
		nextPutAll: ('style="fill:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (fillColor red * 256) rounded with: (fillColor green * 256) rounded with: (fillColor blue * 256) rounded);
		nextPutAll: ('fill-opacity:<1p>;' expandMacrosWith: fillColor alpha);		
		nextPutAll: ('stroke:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (borderColor red * 256) rounded with: (borderColor green * 256) rounded with: (borderColor blue * 256) rounded );
		nextPutAll: ('stroke-width:<1p>" ' expandMacrosWith: aSmallInteger );
		nextPutAll: ('transform="translate(<1p>,<2p>) ' expandMacrosWith: distanceX with: distanceY);
		nextPutAll: ('scale(<1p>)" ' expandMacrosWith: anInteger );
		nextPutAll: 'class="'.
	self addContainedInteractions: ('p',id) element: element.
	stream
		nextPutAll: '"';				
		nextPutAll: '/>',String cr.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('p',id) element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawRectangle: element box: aRectangle fillColor: fillColor borderWidth: aSmallInteger borderColor: aColor [ 
	|id closings|
	id := self count asString.
	closings := self addEmbeddingInteractions: 'rect' , id  element: element.
	stream
		nextPutAll: '<rect id="rect',id,'" ';
		nextPutAll: ('x="<1p>" y="<2p>"' expandMacrosWith: (aRectangle topLeft x rounded) with: (aRectangle topLeft y rounded) );
		nextPutAll: (' height="<1p>" width="<2p>" ' expandMacrosWith: (aRectangle height rounded) with: (aRectangle width rounded));
		nextPutAll: 'style="';
		nextPutAll: ('fill:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (fillColor red * 256) rounded with: (fillColor green * 256) rounded with: (fillColor blue * 256) rounded);
		nextPutAll: ('fill-opacity:<1p>;' expandMacrosWith: fillColor alpha).	
		(aSmallInteger > 0 or: aColor ~= nil)
			ifTrue: [
				stream 
					nextPutAll: (';stroke:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (aColor red * 256) rounded with: (aColor green * 256) rounded with: (aColor blue * 256) rounded);
					nextPutAll: ('stroke-width:<1p>" ' expandMacrosWith: aSmallInteger)
			]
			ifFalse: [stream nextPutAll: '" '].
	stream
		nextPutAll: 'class="'.
	self addContainedInteractions: ('rect',id) element: element.
	stream
		nextPutAll: '"';				
		nextPutAll: '/>',String cr.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('rect',id) element: element. 
]

{ #category : #drawing }
RTSVGVisitor >> drawString: element text: aByteString at: aPoint color: color [
	|p id closings|
	id := self count asString.
	p := aPoint.
	closings := self addEmbeddingInteractions: 'text' , id  element: element.
	stream 
		nextPutAll: '<text id="text',id,'" ';
		nextPutAll: ('x="<1p>" y="<2p>" ' expandMacrosWith: p x rounded  with:  p y rounded);
		nextPutAll: ('fill="rgb(<1p>,<2p>,<3p>)" ' expandMacrosWith: (color red * 256) rounded  with: (color green * 256) rounded with: (color blue * 256) rounded);
		nextPutAll: 'class="'.
	self addContainedInteractions:('text',id)  element: element.
	stream
		nextPutAll: '"';		
		nextPutAll: '>';
		nextPutAll: '<tspan font-family = "Arial, Helvetica, sans-serif">';
		nextPutAll: aByteString ;
		nextPutAll: '</tspan></text>';
		nextPutAll: String cr.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions:('text',id)  element: element.
]

{ #category : #drawing }
RTSVGVisitor >> drawString: element text: aByteString at: aPoint color: color angle: angle [
	|p id closings|
	id := self count asString.
	p := aPoint.
	closings := self addEmbeddingInteractions: 'text' , id  element: element.
	stream 
		nextPutAll: '<text id="text',id,'" ';
		nextPutAll: ('x="<1p>" y="<2p>" ' expandMacrosWith: p x rounded  with:  p y rounded);
		nextPutAll: ('fill="rgb(<1p>,<2p>,<3p>)" ' expandMacrosWith: (color red * 256) rounded  with: (color green * 256) rounded with: (color blue * 256) rounded);
		nextPutAll: ('transform="rotate(<1p>,<2p>,<3p>)" ' expandMacrosWith: angle with: p x rounded with: p y rounded);
		nextPutAll: 'class="'.
	self addContainedInteractions:('text',id)  element: element.
	stream
		nextPutAll: '"';		
		nextPutAll: '>';
		nextPutAll: '<tspan font-family = "Arial, Helvetica, sans-serif">';
		nextPutAll: aByteString ;
		nextPutAll: '</tspan></text>';
		nextPutAll: String cr.
	closings do: [ :c | stream nextPutAll: c].
	self addExternalInteractions: ('text',id) element: element.
]

{ #category : #utils }
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
	center := 1@1.
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

{ #category : #visitor }
RTSVGVisitor >> setCanvas [
	self canvas = nil
		ifTrue: [ self fixedEncompassingRectangle ]
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
RTSVGVisitor >> visitBezierShape: aBezierShape [
	|points|
	points:= aBezierShape points copy.
	points := points collect: [ :p | self alignPoint: p].
	self drawBezierLine: (aBezierShape element) points: points width: (aBezierShape width) color: (aBezierShape strokePaint)
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
	aCanvas shapes do:[:s | s accept: self]
]

{ #category : #visitor }
RTSVGVisitor >> visitEllipseShape: anEllipse [	
	|borderColor fillColor box|
	((anEllipse color) isNil)
		ifTrue: [ fillColor := Color r: 0 g: 0 b: 0]
		ifFalse: [ fillColor := anEllipse color].
	((anEllipse strokePaint) isNil)
		ifFalse: [ borderColor := anEllipse strokePaint].
	box := self alignRectangle: (anEllipse rectangle).
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
