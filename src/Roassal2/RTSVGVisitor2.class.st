"
I am a class to visit all the nodes of one RTView
"
Class {
	#name : #RTSVGVisitor2,
	#superclass : #RTVisitor,
	#instVars : [
		'view',
		'stream',
		'names',
		'validInteractions',
		'exportFixedShapes'
	],
	#category : #'Roassal2-Exporter-HTML5'
}

{ #category : #'as yet unclassified' }
RTSVGVisitor2 >> addBorderColor: c [
	c ifNil: [ ^ self].
	
	stream nextPutAll: ('bordercolor: {r: <1p>, g: <2p>, b:<3p>' expandMacrosWith: (c red*255) rounded with: (c green*255) rounded with:  (c blue*255) rounded ).
	c alpha = 1.0 ifTrue: [ stream nextPutAll: '}, ' ]
	ifFalse: [ stream nextPutAll: (', a: <1p>}, ' expandMacrosWith: c alpha) ]
	
]

{ #category : #'as yet unclassified' }
RTSVGVisitor2 >> addBorderWidth: aShape [
	(aShape strokePaint isNil or: [ aShape strokeWidth <= 0 ]) ifTrue: [ ^ self ].
	stream nextPutAll: 'sw: ', aShape strokeWidth asString, ','.
	
]

{ #category : #'as yet unclassified' }
RTSVGVisitor2 >> addColor: c [
	stream nextPutAll: ('color: {r: <1p>, g: <2p>, b:<3p>' expandMacrosWith: (c red*255) rounded with: (c green*255) rounded with:  (c blue*255) rounded ).
	c alpha = 1.0 ifTrue: [ stream nextPutAll: '}, ' ]
	ifFalse: [ stream nextPutAll: (', a: <1p>}, ' expandMacrosWith: c alpha) ]
]

{ #category : #'as yet unclassified' }
RTSVGVisitor2 >> addInteractions: aShape. [
	aShape isNil ifTrue: [ ^ self ].
	(aShape isKindOf: RTAnnounceableObject) ifFalse: [ ^ self ].
	stream nextPutAll: 'ints: '.
	self visitInteractions: aShape.
	stream nextPutAll: ', '
]

{ #category : #'as yet unclassified' }
RTSVGVisitor2 >> addMatrix: m [
	
	stream nextPutAll: 'matrix:{shx: ', m shx asString, 
		', shy: ',  m shy asString, 
		', sx: ', m sx asString, 
		', sy: ', m sy asString, 
		', x: ', m x asString, ', y: ', m y asString, '}}, '.
	
]

{ #category : #'as yet unclassified' }
RTSVGVisitor2 >> addStringWithFont: aLabel [
	| converter fn |
	converter := RTSVGStringConverter new.
	fn := aLabel fontName.
	fn = 'Source Sans Pro' ifTrue: [ fn := 'Verdana, Geneva, sans-serif' ].
	stream nextPutAll: ' text: "';
		nextPutAll: (converter convertString: aLabel text);
		nextPutAll: '", font: {n: "';
		nextPutAll: fn;
		nextPutAll: '", s: ', aLabel fontSize asString;
		nextPutAll: '},'
]

{ #category : #accessing }
RTSVGVisitor2 >> exportFixedShapes [
	^ exportFixedShapes
]

{ #category : #accessing }
RTSVGVisitor2 >> exportFixedShapes: aBool [
	exportFixedShapes := aBool
]

{ #category : #initialization }
RTSVGVisitor2 >> initialize [
	
	names := Dictionary new.
	validInteractions := #(#RTDraggableView #RTDraggable #RTPopup 
	#RTHighlightable #RTLabelled #RTShowEdge #RTShowLabel #RTZoomableView
	#RTFocusElement).
	exportFixedShapes := true.

]

{ #category : #utils }
RTSVGVisitor2 >> nameFor: anElement [

	(names includesKey: anElement) ifTrue: [ 
		^ names at: anElement ] ifFalse: [ 
		| n |
		n := names size printStringHex.
		names at: anElement put: n.
		^ n.
	 ]
]

{ #category : #accessing }
RTSVGVisitor2 >> stream [

	^stream
]

{ #category : #accessing }
RTSVGVisitor2 >> stream: aStream [

	stream := aStream.
]

{ #category : #accessing }
RTSVGVisitor2 >> view [

	^view
]

{ #category : #accessing }
RTSVGVisitor2 >> view: aView [

	view := aView.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitAbstractLine: anAbstractLine [
	"anAbstractLine accept: anAbstractLine
	"
	"TODO"
]

{ #category : #visitor }
RTSVGVisitor2 >> visitArcShape: aShape [
	aShape topLeft ifNil: [ aShape computeRectangle ].
	stream nextPutAll: '
		{type: "arc", id: "';
		nextPutAll: (self nameFor: aShape);
		nextPutAll: ('", ir: <1p>, er: <2p>,' expandMacrosWith: aShape innerRadius 
			with: aShape externalRadius );
		nextPutAll: (' aAngle: <1p>, bAngle: <2p>,' expandMacrosWith: aShape alphaAngle
			with: aShape betaAngle );
		nextPutAll: (' o: {x: <1p>, y: <2p>},' expandMacrosWith: aShape topLeft x
			 with: aShape topLeft y);
		nextPutAll: (' c: {x: <1p>, y: <2p>},' expandMacrosWith: aShape bottomRight x
			 with: aShape bottomRight y).
	self addColor: aShape color.
	self addInteractions: aShape element.
	self addMatrix: aShape matrix.

]

{ #category : #visitor }
RTSVGVisitor2 >> visitArrowHeadShape: arrowShape [

	
	| e ap |
	e := arrowShape element.
	stream nextPutAll: '
		{type: "headarrow", id: "';
		nextPutAll: (self nameFor: arrowShape);
		nextPutAll: ('", fromid: <1p>, toid: <2p>,' 
		expandMacrosWith:  (self nameFor: e from trachelShape) with: (self nameFor: e to trachelShape) ).
	self addColor: arrowShape color.
	self addBorderColor: arrowShape strokePaint.
	ap := e shape class = RTCompositeShape 
		ifTrue: [ e shape allShapes first ] 
		ifFalse: [ e shape ].
	stream nextPutAll: ' width: ', arrowShape width asString;
		nextPutAll: ', size: ', arrowShape mySize asString, ', ap: ';
		nextPutAll: ap attachPoint class name;
		nextPutAll: ', base: ', arrowShape baseSize asString;
		nextPutAll: '},'.
	
	
	"| aid color bColor w s svgE|
	aid := self getDecorationId: arrowHeadShape.
	color := arrowHeadShape color.
	bColor := arrowHeadShape strokePaint.
	w := arrowHeadShape width.
	s := arrowHeadShape mySize.
	(markers contains: aid)
		ifFalse: [  
			svgE := RTSVGArrowHeadMarker new id: aid fillColor: color borderColor: bColor width: w size: s.
			svgE addOn: stream using: self. 
			markers add: aid. 
			]"
		"TODO"
	
]

{ #category : #visitor }
RTSVGVisitor2 >> visitArrowShape: arrowShape [
	
	| e ap |
	e := arrowShape element.
	stream nextPutAll: '
		{type: "simplearrow", id: "';
		nextPutAll: (self nameFor: arrowShape);
		nextPutAll: ('", fromid: <1p>, toid: <2p>,' 
		expandMacrosWith:  (self nameFor: e from trachelShape) with: (self nameFor: e to trachelShape) ).
	self addColor: arrowShape strokePaint.
	ap := e shape class = RTCompositeShape 
		ifTrue: [ e shape allShapes first ] 
		ifFalse: [ e shape ].
	stream nextPutAll: ' width: ', arrowShape width asString;
		nextPutAll: ', size: ', arrowShape mySize asString, ', ap: ';
		nextPutAll: ap attachPoint class name;
		nextPutAll: ', base: ', arrowShape baseSize asString;
		nextPutAll: '},'.
	
]

{ #category : #visitor }
RTSVGVisitor2 >> visitBezierShape: aBezierShape [
	| e shape |
	e := aBezierShape element.
	shape := (e shape class = RTCompositeShape) ifTrue: [ shape := e shape allShapes first ] ifFalse: [ e shape ].
	stream nextPutAll: '
		{type: "bezier", id: "';
		nextPutAll: (self nameFor: aBezierShape);
		nextPutAll: ('", fromid: <1p>, toid: <2p>,' 
		expandMacrosWith:  (self nameFor: e from trachelShape) with: (self nameFor: e to trachelShape) ).
	self addColor: aBezierShape strokePaint.
	
	shape class = RTBezierLine ifTrue: [ 
		stream nextPutAll:  'ides: ['.
		(shape controllingElements rtValue:e) do: [ :el | 
			stream nextPutAll: '"', (self nameFor: el trachelShape), '", '] ].
	
	stream nextPutAll: '], width: ', aBezierShape width asString, ', ap: ';
		nextPutAll: shape attachPoint class name;
		nextPutAll: '},'.
	
]

{ #category : #visitor }
RTSVGVisitor2 >> visitBitMapShape: aBitmapShape [
	| s icon64 |
	s := WriteStream on: ByteArray new.
	
	PNGReadWriter putForm: (aBitmapShape form) onStream: s.
	
	icon64 := (Base64MimeConverter mimeEncode: s contents readStream multiLine: false).
	stream nextPutAll: '
		{type: "bitmap", id: "';
		nextPutAll: (self nameFor: aBitmapShape);
		nextPutAll: '", base64: "';
		nextPutAll: icon64;
		nextPutAll: '", w: ';
		nextPutAll: aBitmapShape width asString;
		nextPutAll: ', h: ';
		nextPutAll: aBitmapShape height asString;
		nextPutAll: ', '.
	self addInteractions: aBitmapShape element.
	self addMatrix: aBitmapShape matrix.
	s close.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitBoxShape: aBox [
	
	| box |
	box := aBox basicEncompassingRectangle.
	stream nextPutAll: '
		{type: "box", id: "';
		nextPutAll: (self nameFor: aBox);
		nextPutAll: ('", w: <1p>, h: <2p>, ' expandMacrosWith:  box width with: box height ).
	self addBorderColor: aBox strokePaint.
	self addBorderWidth: aBox.
	self addColor: aBox color.
	self addInteractions: aBox element.
	self addMatrix: aBox matrix.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitCanvas: aCanvas [
	self exportFixedShapes ifFalse: [ ^ self ].
	aCanvas fixedShapes ifEmpty: [ ^ self ].
	stream nextPutAll:'	shapes = ['.
	aCanvas fixedShapes do: [ :s | s accept: self ].
	stream nextPutAll: '
	];
	mamani.addFixedShapes(shapes);
'
	
	

]

{ #category : #visitor }
RTSVGVisitor2 >> visitCompositeShape: aCompositeShape [
	aCompositeShape shape1 accept: self.
	aCompositeShape shape2 accept: self.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitDiamondShape: diamondShape [
	| aid color bColor w s svgE|
	aid := self getDecorationId: diamondShape.
	color := diamondShape color.
	bColor := diamondShape strokePaint.
	w := diamondShape width.
	s := diamondShape mySize.
	(markers contains: aid)
		ifFalse: [  
			svgE := RTSVGDiamondMarker new id: aid fillColor: color borderColor: bColor width: w size: s.
			svgE addOn: stream using: self. 
			markers add: aid. 
			]
		
	
]

{ #category : #'visitor-interactions' }
RTSVGVisitor2 >> visitDraggableInteraction: anInteraction with: anObject [
	| list |
	list := OrderedCollection new.
	(anObject attributes includesKey: #RTLabelledLabel) ifTrue: [  
		list add: (anObject attributes at: #RTLabelledLabel).
	].
	(anObject attributes includesKey: #nestedElements) ifTrue: [ 
		(anObject attributes at: #nestedElements) do: [ :e |
			e isCollection ifTrue: [ list addAll: (e collect: [:x | x trachelShape ]) ]
			ifFalse: [ list add: e trachelShape ] ].
	].
	list isEmpty ifTrue: [ self visitInteraction: anInteraction with: anObject ]
	ifFalse: [
		stream nextPutAll: 'new RTDraggable(['.
		list do: [ :e | 
			stream nextPutAll: '"';
				nextPutAll: (self nameFor:e);
				nextPutAll: '", ' ].
			stream nextPutAll: '])'.
	]
	
]

{ #category : #visitor }
RTSVGVisitor2 >> visitEdge: edge [
	edge trachelShape accept: self.
	
]

{ #category : #visitor }
RTSVGVisitor2 >> visitElement: e [
	e trachelShape accept: self
]

{ #category : #visitor }
RTSVGVisitor2 >> visitEllipseShape: anEllipse [	
	| box |
	box := anEllipse basicEncompassingRectangle.
	stream nextPutAll: '
		{type: "ellipse", id: "';
		nextPutAll: (self nameFor: anEllipse);
		nextPutAll: ('", rx: <1p>, ry: <2p>,' expandMacrosWith:  (box width / 2) rounded with: (box height/2) rounded ).
	self addBorderColor: anEllipse strokePaint.
	self addBorderWidth: anEllipse.
	self addColor: anEllipse color.
	self addInteractions: anEllipse element.
	self addMatrix: anEllipse matrix.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitGroup: aRTGroup [
	aRTGroup accept: self.
]

{ #category : #'visitor-interactions' }
RTSVGVisitor2 >> visitHightlightableInteraction: anInt with: el [
	stream nextPutAll: 'new RTHighlightable({'.
	self addColor: anInt highlightedColor.
	stream nextPutAll: 'ides: ['.
		((anInt instVarNamed: #highlightElements) rtValue: el) 
		do: [ :e |
			stream nextPutAll: '"', (self nameFor: e trachelShape), '",' ].
		stream nextPutAll: ']})'.
]

{ #category : #'visitor-interactions' }
RTSVGVisitor2 >> visitInteraction: interaction with: anObject [
	stream nextPutAll: interaction class name.
	
]

{ #category : #'visitor-interactions' }
RTSVGVisitor2 >> visitInteractions: anObject [
	| first list temp |
	
	first := true.
	list := OrderedCollection new.
	temp := OrderedCollection new.
	(anObject announcer subscriptions trSubscriptions do: [ :sub | 
		((validInteractions includes: sub subscriber class name) 
		and: [ (temp includes: sub subscriber class) not ]) ifTrue: [ 
			temp add: sub subscriber class.
			list add: sub ] ] ).
	stream nextPutAll: '['.
	list do: [ :sub | 
		first ifTrue: [ first := false.
			sub subscriber accept: self with: anObject ]
		ifFalse: [ 
			stream nextPutAll: ', '.
			sub subscriber accept: self with: anObject ]
		 ].
	stream nextPutAll: ']'.
	self flag: 'review'.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitLabelShape: aLabel [
	| box |
	box := aLabel basicEncompassingRectangle.
	stream nextPutAll: '
		{type: "label", id: "';
		nextPutAll: (self nameFor: aLabel);
		nextPutAll: ('",o: {x: <1p>, y: <2p>},' expandMacrosWith: box origin x with: box origin y);
		nextPutAll: ('c: {x: <1p>, y: <2p>},' expandMacrosWith: box corner x with: box corner y).
	self addColor: aLabel color.
	self addStringWithFont: aLabel.
	self addInteractions: aLabel element.
	self addMatrix: aLabel matrix.

]

{ #category : #'visitor-interactions' }
RTSVGVisitor2 >> visitLabelledInteraction: anInt with: el [
	stream nextPutAll: 'new RTLabelled({'.
		self addColor: anInt color.
		stream nextPutAll: 'low'.
		self addColor: anInt lowColor.
		stream nextPutAll: 'lbl: '.
		stream nextPutAll: '"',(self nameFor: anInt lbl),'"'.
		stream nextPutAll: '})'.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitLineShape: aLine [
	
	| e ap |
	e := aLine element.
	
	e = nil ifTrue: [ ^ self ].
	e shape = nil ifTrue: [ ^ self ].
	
	stream nextPutAll: '
		{type: "line", id: "';
		nextPutAll: (self nameFor: aLine);
		nextPutAll: ('", fromid: <1p>, toid: <2p>,' 
		expandMacrosWith:  (self nameFor: e from trachelShape) with: (self nameFor: e to trachelShape) ).
	ap := e shape class = RTCompositeShape 
		ifTrue: [ e shape allShapes first ] 
		ifFalse: [ e shape ].
	self addColor: aLine color.
	stream nextPutAll: ' width: ', aLine width asString, ', ap: '.
	stream nextPutAll: ap attachPoint class name.
	stream nextPutAll: '},'.
	
]

{ #category : #visitor }
RTSVGVisitor2 >> visitMultiCompositeShape: aShape [
	stream nextPutAll: '
		{id: "';
		nextPutAll: (self nameFor: aShape);
		nextPutAll: '", type:"multi", shapes:['.
	aShape shapes do: [ :s| s accept: self].
	stream nextPutAll: '], offsets: ['.
	aShape offsets do: [ :o | 
		stream nextPutAll: ('{x: <1p>, y: <2p>},' 
			expandMacrosWith: o x with: o y) ].
	
	stream nextPutAll: ']'.

	(aShape element isNil not and: [aShape element shape isKindOf: RTMultiColoredLine]) ifTrue: [ 
		stream nextPutAll: ', ap: ', aShape element shape attachPoint class name ].
	stream nextPutAll: '},'.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitNoShape: aNoShape [
	"Do nothing"
]

{ #category : #visitor }
RTSVGVisitor2 >> visitPolygonShape: aPolygon [
	| r c |
	r := aPolygon encompassingRectangle.
	c := aPolygon color.
	c ifNil: [ c:= Color transparent ].
	
	stream nextPutAll: '
		{type: "polygon", id: "';
		nextPutAll: (self nameFor: aPolygon);
		nextPutAll: ('", o: {x: <1p>, y: <2p>}' expandMacrosWith: r origin x with: r origin y);
		nextPutAll: (', c: {x: <1p>, y: <2p>}, p: "' expandMacrosWith: r corner x with: r corner y).
	
	aPolygon vertices do: [ :p |
		stream nextPutAll: ('<1p>,<2p> ' expandMacrosWith: p x with: p y).
		 ].
	stream nextPutAll: '",'.
	self addBorderColor: aPolygon strokePaint.
	self addBorderWidth: aPolygon.
	self addColor: c.
	self addInteractions: aPolygon element.
	self addMatrix: aPolygon matrix.
]

{ #category : #'visitor-interactions' }
RTSVGVisitor2 >> visitPopupInteraction: anInt with: el [
	| elements |
	[elements := anInt createPopupFor: el] 
		on: Error do: [ ^ self ].
		
	stream nextPutAll: 'new RTPopup(['.
	elements do: [ :e | 
		e trachelShape element: e.
		e trachelShape accept: self ].
	stream nextPutAll: ']) '.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitRotatedLabelShape: aRotatedLabel [
	self visitLabelShape: aRotatedLabel
]

{ #category : #visitor }
RTSVGVisitor2 >> visitSVGPath: aSVGPath [
	| r c |
	r := aSVGPath basicEncompassingRectangle.
	c := aSVGPath color.
	c ifNil: [ c:= Color transparent ].
	stream nextPutAll: '
		{type: "path", id: "';
		nextPutAll: (self nameFor: aSVGPath);
		nextPutAll: '", d:"';
		nextPutAll: aSVGPath pathString;
		nextPutAll: ('", o: {x: <1p>, y: <2p>}' expandMacrosWith: r origin x with: r origin y);
		nextPutAll: (', c: {x: <1p>, y: <2p>},' expandMacrosWith: r corner x with: r corner y).
	
	self addBorderColor: aSVGPath strokePaint.
	self addBorderWidth: aSVGPath.
	
	self addColor: c.
	self addInteractions: aSVGPath element.
	self addMatrix: aSVGPath matrix.
]

{ #category : #visitor }
RTSVGVisitor2 >> visitShape: aShape [
	aShape accept: self 
]

{ #category : #'visitor-interactions' }
RTSVGVisitor2 >> visitShowEdgeInteraction: anInt with: el [
	|edges t |
	t := (anInt connectToElements rtValue: el).
	t := t copyWithout: nil.
	edges := (anInt shape rtValue: el) edgesFrom: el toAll: t.
	stream nextPutAll: 'new RTShowEdge(['.
	edges do: [ :e |
		e trachelShape element: e.
		e trachelShape accept: self ].
	stream nextPutAll: ']) '.
]

{ #category : #'visitor-interactions' }
RTSVGVisitor2 >> visitShowLabelInteraction: anInt with: el [
	
	stream nextPutAll: 'new RTShowLabel(['.
	((anInt instVarNamed: #highlightElements) rtValue: el) do: [:ele |
		(anInt labelledInteraction initializeElement: ele) accept: self.
	].
	stream nextPutAll: ']) '.
	anInt doUnhighlightElement: el
]

{ #category : #visitor }
RTSVGVisitor2 >> visitView: aView [
	| elements |
	stream nextPutAll: ('mamani.color(<1p>);
	mamani.camera.setScale(<2p>);' 
	expandMacrosWith: aView canvas color printHtmlString with: aView canvas camera scale).

	aView announcer subscriptions trSubscriptions isEmpty ifFalse: [
		stream nextPutAll: 'mamani.addInteractions('.
		self visitInteractions: aView.
		stream nextPutAll: ');
	'].
	elements := (aView canvas shapes collect: [ :s | 
		s element isNil ifTrue: [ s ] ifFalse: [ s element ] ]) asOrderedCollection removeDuplicates.
	
	stream nextPutAll:'
	var shapes = ['.
	elements do: [ :e | e accept: self ].
	stream nextPutAll:'
	];
	mamani.addShapes(shapes);
'.
	aView canvas accept: self
]
