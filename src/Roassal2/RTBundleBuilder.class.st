"
You can use this builder to represent a hierarchy of an object(like Collection and all subclasses). 

This builder uses cluster layout.

This builder uses all the leaf of the tree structure, and put a string representation for each object.

Also this builder can create bezier relations between each leaf node. that you can activate with mouseEnter in one node

This builders adds some interactions, like
* an interaction with beziers
	 - #useBezierlineWith: . Send nil to disable
* a slider to change the tension for each bezier shape
	- #sliderShape: .Send nil to disable
* RTRotableView
	- view: anotherView. Send another view to disable

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
	#category : #'Roassal2-Builder-BundleEdge'
}

{ #category : #accessing }
RTBundleBuilder >> bezier [
	^ bezier
]

{ #category : #'rendering-utility' }
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

{ #category : #'rendering-utility' }
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

{ #category : #'rendering-utility' }
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
	| lin c |
	"lin := TRPlatform current linearGradientClass.
	c := lin new
				start: 0@ -8.75; stop: 0@8.75;
				colorRamp: (Array with: (0.0 -> (Color white alpha: 0.6)) with: (1.0 -> Color transparent).
	c2 := lin new
				start: 0@ 7.0; stop: 0@12.0;
				colorRamp: (Array with: (0.0-> Color transparent) with: (1.0 -> (Color white alpha: 0.6))."
	c := Color blue.
	sliderShape := RTCompositeShape new 
		add: (RTEllipse new size: 30; color: Color blue; borderWidth: 0.01; borderColor: Color black);
		add: (RTEllipse new width: 24; height: 19.5;
			color: c) translateBy: 0@ -3.9;
		add: (RTArc new innerRadius: 12.9; externalRadius: 13.8; alphaAngle: 200; betaAngle: 340;
			color: c). "Could be c2"
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

{ #category : #'rendering-utility' }
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

{ #category : #'public - configuration' }
RTBundleBuilder >> sliderShape: aShape [
	sliderShape := aShape
]

{ #category : #'rendering-utility' }
RTBundleBuilder >> useBezierlineWith: ablock [
	connectBezierBlock := ablock
	
]

{ #category : #'public - configuration' }
RTBundleBuilder >> withoutSlider [
	self sliderShape: nil
]
