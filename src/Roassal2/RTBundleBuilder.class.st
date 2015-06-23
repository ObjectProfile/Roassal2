"
I am a experimental builder
"
Class {
	#name : #RTBundleBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'label',
		'nodes',
		'layout',
		'edges',
		'rootNodes',
		'elements',
		'childrenBlock',
		'connectBezierBlock',
		'bezier',
		'sliderShape'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTBundleBuilder >> bezier [
	^ bezier
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> createBezierIfNecessary: aView [
	| ebuilder slider bedges |
	connectBezierBlock ifNil: [ ^ self ].
	
	bezier
		follow: [ :m | self parentOf: m view: aView ];
		tension: 0.5.
	ebuilder := 	RTEdgeBuilder new
		view: aView;
		elements: elements.
	ebuilder shape shape: bezier.
	bedges := ebuilder connectToAll: connectBezierBlock.
	
	slider := RTSlider new.
	slider shape shape: sliderShape. 
	slider moveBelow; view: aView; callback: [:v| 
		bezier tension: v.
		bedges do: [ :e | e trachelShape points: (bezier getListOfPointsForTrachel: e); resetPath.].
	].

	slider build.

]

{ #category : #'as yet unclassified' }
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
RTBundleBuilder >> defaultSliderShape [
	sliderShape := RTCompositeShape new 
		add: (RTEllipse new size: 30; color: Color blue; borderWidth: 0.01; borderColor: Color black);
		add: (RTEllipse new width: 24; height: 19.5;
			color: (LinearGradientPaint new
				start: 0@ -0.5; stop: 0@0.4;
				colorRamp: { 0.0 -> (Color white alpha: 0.6). 1.0 -> Color transparent } )) translateBy: 0@ -3.9;
		add: (RTArc new innerRadius: 12.9; externalRadius: 13.8; alphaAngle: 200; betaAngle: 340;
			color: (LinearGradientPaint new
				start: 0@ 7.0; stop: 0@12.0;
				colorRamp: { 0.0-> Color transparent. 1.0 -> (Color white alpha: 0.6) } )).
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> edges [
	^ edges
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> elements [
	^ elements.
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> explore: atree using: ablock [
	^ (self from: (Array with: atree) using: ablock) first
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> from: aCollection using: ablock [
	childrenBlock := ablock.
	^ rootNodes := aCollection collect: [ :obj | self createElements: obj using: ablock depth: 1 ].
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> initialize [
	super initialize.
	self shape circle.
	self interaction popup.
	self defaultSliderShape.
	elements := RTGroup new.
	label := RTShapeBuilder new.
	edges := RTEdgeBuilder new.
	layout := RTLayoutBuilder new.
	layout cluster.
	bezier := RTBezierLine new.
	connectBezierBlock := nil.
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> parentOf: model view: aView [
	| element |
	element := view elementFromModel: model.
	element ifNil: [ ^ nil ].
	^ (element attributes at: #parent ifAbsent: [ nil ]) ifNotNil: [:parent | parent model ].
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> renderIn: aView [
	
	aView addAll: elements.
	edges
		view: aView;
		elements: elements;
		connectToAll: childrenBlock.
	layout setUpElements: elements.
	self createBezierIfNecessary: aView.
	

]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> sliderShape [
	^ sliderShape
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> sliderShape: aShape [
	sliderShape := aShape
]

{ #category : #'as yet unclassified' }
RTBundleBuilder >> useBezierlineWith: ablock [
	connectBezierBlock := ablock
	
]
