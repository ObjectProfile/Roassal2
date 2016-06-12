"
I am a experimental builder
"
Class {
	#name : #RTBundleBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'label',
		'nodes',
		'edges',
		'rootNodes',
		'elements',
		'childrenBlock',
		'connectBezierBlock',
		'bezier',
		'sliderShape',
		'center',
		'edgeBuilderDo'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #accessing }
RTBundleBuilder >> bezier [
	^ bezier
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> createBezierIfNecessary: aView [
	| ebuilder   |
	connectBezierBlock ifNil: [ ^ self ].
	edgeBuilderDo ifNil: [^ self ].
	ebuilder := RTEdgeBuilder new
		view: aView;
		elements: elements;
		shape: bezier.
	edgeBuilderDo value: ebuilder.
]

{ #category : #private }
RTBundleBuilder >> createElements: obj using: ablock depth: depth [
	| children e |
	e := self shape elementOn: obj.
	self interaction setUpElement: e.
	self elements add: e.
	children := ablock rtValue: obj.
	e attributes at: #depth put: depth.
	children := children collect: [ :child | | e2 |
		e2 := self createElements: child using: ablock depth: depth + 1.
		e2 attributes at: #parent put: e.
		e2 ].
	e attributes at: #children put: children.
	^ e
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> createLabelFor: e view: aView [
	| lbl |
	lbl := label elementOn: e model.
	self interaction setUpElement: lbl.
	aView add: lbl.
	e addCallback: (TRTranslationCallback new block: [
		| angle |
		angle := (e position - center ) theta.
		lbl translateTo: e position+((lbl trachelShape notRotatedWidth/2) * (angle cos @ angle sin)).
		angle := angle radiansToDegrees.
		angle := angle + ((angle between: 90 and: 270)  ifTrue: [ 180 ] ifFalse: [ 0 ]).
		lbl trachelShape angleInDegree: angle ] ).
	e translateTo: e position.

]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> createSliderIfNecessary: aView [
	| bedges slider |
	sliderShape ifNil: [ ^ self ].
	bedges := aView edges select: [ :e | e shape = bezier ].
	slider := RTSlider new.
	slider shape shape: sliderShape. 
	slider move: #below; view: aView; callback: [:v| 
		bezier tension: v.
		bedges do: [ :e | e trachelShape points: (bezier getListOfPointsForTrachel: e); resetPath.].
	].

	slider build.
]

{ #category : #hooks }
RTBundleBuilder >> createView [
	^ super createView @ (RTRotableView new 
		elements: [ elements ];
		center: [ center ];
		yourself ).
]

{ #category : #default }
RTBundleBuilder >> defaultInteractions [
	self interaction popup;
		addInteraction: (RTHighlightable new 
			highlightedColor: (Color r: 0 g: 120 b: 0 range: 255);
			highlightElements: [ :el |
				edges := el view edges select: [:e | e model key = el model ].
				edges, (edges flatCollect: [:ed |
					el view elements select: [ :elem | elem model = ed to model ] ] ).
			 ]);
		addInteraction: (RTHighlightable new
			highlightedColor: Color red;
			highlightElements: [:el | 
				edges := el view edges select: [:e | e model value = el model].
				edges, (edges flatCollect: [:ed |
					el view elements select: [ :elem | elem model = ed from model ] ] ).
				]);
		addInteraction: RTHighlightable allSibblings.
	
]

{ #category : #default }
RTBundleBuilder >> defaultSliderShape [
	| lin |
	lin := TRPlatform current linearGradientClass.
	sliderShape := RTCompositeShape new 
		add: (RTEllipse new size: 30; color: Color blue; borderWidth: 0.01; borderColor: Color black);
		add: (RTEllipse new width: 24; height: 19.5;
			color: (lin new
				start: 0@ -8.75; stop: 0@8.75;
				colorRamp: (Array with: (0.0 -> (Color white alpha: 0.6)) with: (1.0 -> Color transparent)))) translateBy: 0@ -3.9;
		add: (RTArc new innerRadius: 12.9; externalRadius: 13.8; alphaAngle: 200; betaAngle: 340;
			color: (lin new
				start: 0@ 7.0; stop: 0@12.0;
				colorRamp: (Array with: (0.0-> Color transparent) with: (1.0 -> (Color white alpha: 0.6))))).
]

{ #category : #accessing }
RTBundleBuilder >> edgeBuilderDo: aBlock [
	"aBlock recibes one argument, the EdgeBulder
	this is used in createBezierIfnecessary:"
	edgeBuilderDo := aBlock
]

{ #category : #accessing }
RTBundleBuilder >> edges [
	^ edges
]

{ #category : #accessing }
RTBundleBuilder >> elements [
	^ elements.
]

{ #category : #building }
RTBundleBuilder >> explore: atree using: ablock [
	^ (self from: (Array with: atree) using: ablock) first
]

{ #category : #building }
RTBundleBuilder >> from: aCollection using: ablock [
	childrenBlock := ablock.
	^ rootNodes := aCollection collect: [ :obj | self createElements: obj using: ablock depth: 1 ].
]

{ #category : #initialization }
RTBundleBuilder >> initialize [
	super initialize.
	self shape circle.
	self defaultInteractions.
	self defaultSliderShape.
	elements := RTGroup new.
	label := RTRotatedLabel new.
	edges := RTEdgeBuilder new.
	layoutBuilder := RTLayoutBuilder new.
	layoutBuilder cluster.
	bezier := RTBezierLine new.
	connectBezierBlock := nil.
	bezier
		follow:  [ :m | self parentOf: m view: view ];
		tension: 0.5.
	self edgeBuilderDo: [:ebuilder| 
		ebuilder connectToAll: connectBezierBlock. ].
]

{ #category : #accessing }
RTBundleBuilder >> labelShape [
	^ label
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> parentOf: model view: aView [
	| element |
	element := view elementFromModel: model.
	element ifNil: [ ^ nil ].
	^ (element attributes at: #parent ifAbsent: [ nil ]) ifNotNil: [:parent | parent model ].
]

{ #category : #hooks }
RTBundleBuilder >> renderIn: aView [
	view := aView.
	aView addAll: elements.
	edges
		view: aView;
		elements: elements;
		connectToAll: childrenBlock.
	layoutBuilder setUpElements: elements.
	self createBezierIfNecessary: aView.
	
	center := elements encompassingRectangle center.
	(elements select: [ :e | (childrenBlock rtValue: e model) isEmpty ]) 
		do: [ :e | self createLabelFor: e view: aView ].
	
	self createSliderIfNecessary: aView.

]

{ #category : #accessing }
RTBundleBuilder >> sliderShape [
	^ sliderShape
]

{ #category : #accessing }
RTBundleBuilder >> sliderShape: aShape [
	sliderShape := aShape
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> useBezierlineWith: ablock [
	connectBezierBlock := ablock
	
]
