"
A RTSVGVisitor is a RTVisitor for SVG exporting.

"
Class {
	#name : #RTSVGVisitor,
	#superclass : #RTVisitor,
	#instVars : [
		'view',
		'stream',
		'canvas'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #visitor }
RTSVGVisitor class >> visit: view on: stream canvas: aRectangle [
	self new view: view; stream: stream; canvas: aRectangle; visit; yourself.
]

{ #category : #utils }
RTSVGVisitor >> addCurves: points [
	"false"points size >= 3
		ifTrue: [
			(1 to: points size // 2) do: [ :i | 
					stream
						nextPutAll: ('S<1p>,<2p> ' expandMacrosWith: (points at: 2*i - 1) x rounded with: (points at: 2*i - 1)  y rounded);
						nextPutAll: ('<1p>,<2p> ' expandMacrosWith: (points at: 2*i)  x rounded with: (points at: 2*i) y rounded) 		
				].
			stream
				nextPut: $".
			]
		ifFalse: [		
			points size == 2
				ifTrue: [  
					stream
						nextPutAll: ('Q<1p>,<2p> ' expandMacrosWith: points first x rounded with: points first y rounded);
						nextPutAll: ('<1p>,<2p>"' expandMacrosWith: points second x rounded with: points second y rounded) 
					] .			
			points size ">= 3"== 3
				ifTrue: [  
					stream
						nextPutAll: ('C<1p>,<2p> ' expandMacrosWith: points first x rounded with: points first y rounded);
						nextPutAll: ('<1p>,<2p> ' expandMacrosWith: points second x rounded with: points second y rounded);
						nextPutAll: ('<1p>,<2p>"' expandMacrosWith: points last x rounded with: points last y rounded) 
					] ]
]

{ #category : #utils }
RTSVGVisitor >> alignLine: aLine [
	|distanceX distanceY fromX fromY|
	distanceX := canvas topLeft x negated + 1.
	distanceY := canvas topLeft y negated + 1.
	fromX := aLine from x + distanceX.
	fromY := aLine from y + distanceY.
	^(TRLineShape new from: fromX@fromY; to: (fromX + aLine to x) @ (fromY + aLine to y))
	
]

{ #category : #utils }
RTSVGVisitor >> alignPoint: aPoint [
	|distanceX distanceY originX originY|
	distanceX := canvas topLeft x negated + 1.
	distanceY := canvas topLeft y negated + 1.
	originX := aPoint x + distanceX.
	originY := aPoint y + distanceY.
	^originX@originY
	
]

{ #category : #utils }
RTSVGVisitor >> alignRectangle: aRectangle [
	|distanceX distanceY originX originY|
	distanceX := canvas topLeft x negated + 1.
	distanceY := canvas topLeft y negated + 1.
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

{ #category : #drawing }
RTSVGVisitor >> drawArc: center innerRadius: aNumber outterRadius: anotherNumber alphaAngle: anAngle betaAngle: anotherAngle color: aColor [
	| start end p1 p2 aAngle bAngle sweepFlag alpha beta |
	alpha := self makePositive: anAngle.
	beta := self makePositive: anotherAngle.
	alpha > beta
		ifTrue: [ sweepFlag := 1 ]
		ifFalse: [ sweepFlag := 0 ].
	aAngle := self toRadian: alpha.
	bAngle := self toRadian: beta.
	start := self getPointFrom: center angle: aAngle radius: aNumber.
	end := self getPointFrom: center angle: bAngle radius: aNumber.
	p1 := self getPointFrom: center angle: aAngle radius: anotherNumber.
	p2 := self getPointFrom: center angle: bAngle radius: anotherNumber.
	stream
		nextPutAll: '<path ';
		nextPutAll: ('d="M<1p>,<2p> ' expandMacrosWith: start x with: start y);
		nextPutAll: ('L<1p>,<2p> ' expandMacrosWith: p1 x with: p1 y);
		nextPutAll: ('A<1p>,<2p> 0 <3p>,1 ' expandMacrosWith: anotherNumber with: anotherNumber with: sweepFlag);
		nextPutAll: ('<1p>,<2p> ' expandMacrosWith: p2 x with: p2 y);
		nextPutAll: ('L<1p>,<2p> ' expandMacrosWith: end x with: end y);
		nextPutAll: ('A<1p>,<2p> 0 <3p>,0 ' expandMacrosWith: aNumber with: aNumber with: sweepFlag);
		nextPutAll: ('<1p>,<2p>z" ' expandMacrosWith: start x with: start y);
		nextPutAll:
				('style="fill:rgb(<1p>,<2p>,<3p>);"/>'
						expandMacrosWith: (aColor red * 256) rounded
						with: (aColor green * 256) rounded
						with: (aColor blue * 256) rounded);
		nextPutAll: String cr
]

{ #category : #drawing }
RTSVGVisitor >> drawBezierLine: points width: aSmallInteger color: aColor [
	stream
		nextPutAll: '<path ';
		nextPutAll: ('d="M<1p>,<2p> ' expandMacrosWith: (points at: 1) x rounded with: (points at: 1) y rounded).
	self addCurves: points allButFirst.
	stream
		nextPutAll:
				('style="fill:none;stroke:rgb(<1p>,<2p>,<3p>);'
						expandMacrosWith: (aColor red * 256) rounded
						with: (aColor green * 256) rounded
						with: (aColor blue * 256) rounded);
		nextPutAll: ('stroke-width:<1p>"/>' expandMacrosWith: aSmallInteger);
		nextPutAll: String cr
]

{ #category : #drawing }
RTSVGVisitor >> drawLine: aPoint to: aPoint2 width: aSmallInteger color: aColor [ 
	stream 
		nextPutAll: '<line ';
		nextPutAll: ('x1="<1p>" y1="<2p>" ' expandMacrosWith: aPoint x rounded  with: aPoint y rounded);
		nextPutAll: ('x2="<1p>" y2="<2p>" ' expandMacrosWith: aPoint2 x rounded with: aPoint2 y rounded );
		nextPutAll: ('style="stroke:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (aColor red * 256) rounded with: (aColor green * 256) rounded with: (aColor blue * 256) rounded );
		nextPutAll: ('stroke-width:<1p>"/>' expandMacrosWith: aSmallInteger );
		nextPutAll: String cr.
]

{ #category : #drawing }
RTSVGVisitor >> drawOval: aRectangle color: aColor borderWidth: aSmallInteger borderColor: aColor4 [ 
	|center w h|
	center := aRectangle center.
	w := aRectangle width.
	h := aRectangle height.
	
	stream 
		nextPutAll: '<ellipse ';
		nextPutAll: ('cx= "<1p>" cy="<2p>" ' expandMacrosWith: center x rounded  with: center y rounded);
		nextPutAll: ('rx="<1p>" ry="<2p>" ' expandMacrosWith: (w/ 2) rounded with: (h /2) rounded);
		nextPutAll: ('style="fill:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (aColor red *256) rounded with: (aColor green * 256) rounded with: (aColor blue * 256) rounded );
		nextPutAll: ('fill-opacity:<1p>;' expandMacrosWith: aColor alpha);	
		nextPutAll: ('stroke: rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (aColor4 red *256) rounded with: (aColor4 green * 256) rounded with: (aColor4 blue * 256) rounded ); 
		nextPutAll: ('stroke-width: <1p>"/>' expandMacrosWith: aSmallInteger);		
		nextPutAll: String cr.
]

{ #category : #drawing }
RTSVGVisitor >> drawPath: pathString width: aSmallInteger fillColor: fillColor borderColor: borderColor scale: anInteger [
	| distanceX distanceY |
	distanceX := canvas topLeft x negated + 1.
	distanceY := canvas topLeft y negated + 1.
 	stream 
		nextPutAll: '<path ';
		nextPutAll: ('d="',pathString,'" ');
		nextPutAll: ('style="fill:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (fillColor red * 256) rounded with: (fillColor green * 256) rounded with: (fillColor blue * 256) rounded);
		nextPutAll: ('fill-opacity:<1p>;' expandMacrosWith: fillColor alpha);		
		nextPutAll: ('stroke:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (borderColor red * 256) rounded with: (borderColor green * 256) rounded with: (borderColor blue * 256) rounded );
		nextPutAll: ('stroke-width:<1p>" ' expandMacrosWith: aSmallInteger );
		nextPutAll: ('transform="translate(<1p>,<2p>) ' expandMacrosWith: distanceX with: distanceY);
		nextPutAll: ('scale(<1p>)"/>' expandMacrosWith: anInteger );
		nextPutAll: String cr.
]

{ #category : #drawing }
RTSVGVisitor >> drawRectangle: aRectangle fillColor: fillColor borderWidth: aSmallInteger borderColor: aColor [ 
	stream
		nextPutAll: '<rect ';
		nextPutAll: ('x="<1p>" y="<2p>"' expandMacrosWith: (aRectangle topLeft x rounded) with: (aRectangle topLeft y rounded) );
		nextPutAll: (' height="<1p>" width="<2p>" ' expandMacrosWith: (aRectangle height rounded) with: (aRectangle width rounded));
		nextPutAll: 'style="';
		nextPutAll: ('fill:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (fillColor red * 256) rounded with: (fillColor green * 256) rounded with: (fillColor blue * 256) rounded);
		nextPutAll: ('fill-opacity:<1p>;' expandMacrosWith: fillColor alpha).	
		aSmallInteger > 0 
			ifTrue: [
				stream 
					nextPutAll: (';stroke:rgb(<1p>,<2p>,<3p>);' expandMacrosWith: (aColor red * 256) rounded with: (aColor green * 256) rounded with: (aColor blue * 256) rounded);
					nextPutAll: ('stroke-width:<1p>" ' expandMacrosWith: aSmallInteger)
			]
			ifFalse: [stream nextPutAll: '"'].
		stream 
			nextPutAll: '/>';
			nextPutAll: String cr.
]

{ #category : #drawing }
RTSVGVisitor >> drawString: aByteString at: aPoint color: color [
	|p|
	p := aPoint.

	stream 
		nextPutAll: '<text ';
		nextPutAll: ('x="<1p>" y="<2p>" ' expandMacrosWith: p x rounded  with:  p y rounded);
		nextPutAll: ('fill="rgb(<1p>,<2p>,<3p>)">' expandMacrosWith: (color red * 256) rounded  with: (color green * 256) rounded with: (color blue * 256) rounded);
		nextPutAll: aByteString ;
		nextPutAll: '</text>';
		nextPutAll: String cr.
]

{ #category : #drawing }
RTSVGVisitor >> drawString: aByteString at: aPoint color: color angle: angle [
	|p|
	p := aPoint.

	stream 
		nextPutAll: '<text ';
		nextPutAll: ('x="<1p>" y="<2p>" ' expandMacrosWith: p x rounded  with:  p y rounded);
		nextPutAll: ('fill="rgb(<1p>,<2p>,<3p>)" ' expandMacrosWith: (color red * 256) rounded  with: (color green * 256) rounded with: (color blue * 256) rounded);
		nextPutAll: ('transform="rotate(<1p>,<2p>,<3p>)">' expandMacrosWith: angle with: p x rounded with: p y rounded);
		nextPutAll: aByteString ;
		nextPutAll: '</text>';
		nextPutAll: String cr.
]

{ #category : #utils }
RTSVGVisitor >> getPointFrom: center angle: anAngle radius: aNumber [
	|x y|
	x := (center x + (anAngle cos * aNumber)) rounded.
	y := (center y + (anAngle sin * aNumber)) rounded.
	^  x@y
]

{ #category : #utils }
RTSVGVisitor >> makePositive: anAngle [
	| result |
	anAngle < 0
		ifTrue: [ result := anAngle + 360 ]
		ifFalse: [ result := anAngle ].
	^ result
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
	self visitView: self view
]

{ #category : #visitor }
RTSVGVisitor >> visitAbstractLine: anAbstractLine [
	anAbstractLine accept: anAbstractLine
	
]

{ #category : #visitor }
RTSVGVisitor >> visitArcShape: aShape [
	|center|
	center := self alignPoint: (aShape center).
	self drawArc: center 
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
	self drawBezierLine: points width: (aBezierShape width) color: (aBezierShape strokePaint)
]

{ #category : #visitor }
RTSVGVisitor >> visitBoxShape: aBox [
	|borderColor fillColor box|
	((aBox color) isNil)
		ifTrue: [ fillColor := Color r: 0 g: 0 b: 0]
		ifFalse: [ fillColor := aBox color].
	((aBox strokePaint) isNil)
		ifTrue: [ borderColor := fillColor]
		ifFalse: [ borderColor := aBox strokePaint].
	box := self alignRectangle: (aBox encompassingRectangle).
	self drawRectangle: box
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
		ifTrue: [ borderColor := fillColor]
		ifFalse: [ borderColor := anEllipse strokePaint].
	box := self alignRectangle: (anEllipse rectangle).
	self drawOval: box
		color: fillColor 
		borderWidth: 1 
		borderColor: borderColor 
]

{ #category : #visitor }
RTSVGVisitor >> visitLabelShape: aLabel [
	| color rectangle position text |
	color := aLabel color.	
	rectangle := aLabel encompassingRectangle.
	position := self alignPoint: ((rectangle topLeft x + (rectangle width/4)) @ rectangle center y).
	text := aLabel text.
	self drawString: text at: position color: color.
]

{ #category : #visitor }
RTSVGVisitor >> visitLineShape: aLine [
	|startingPoint endingPoint|
	startingPoint := self alignPoint: (aLine from).
	endingPoint := self alignPoint: (aLine to).
	self drawLine: startingPoint to: endingPoint width: 1 color: (aLine strokePaint).
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
	self drawString: text at: position color: color angle: angle.
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
	self drawPath: aSVGPath pathString
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
