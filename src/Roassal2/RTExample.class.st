Class {
	#name : #RTExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Core'
}

{ #category : #animations }
RTExample >> animationTest [
	"
	self new animationTest
	"
	| view circle |
	view := RTView new.
	circle := (RTEllipse new size: 40; color: (Color purple alpha: 0.2)) element.
	view add: circle.
	view addAnimation: (RTLinearMove to: 100 @ 100 during: 2 on: circle). 

	view open.
	^ view
]

{ #category : #shapes }
RTExample >> basic [
	"
	self new basic
	"
	
	| view |
	view := RTView new.
	view add: (RTBox element translateTo: 20 @ 20; yourself).
	view open
]

{ #category : #beziers }
RTExample >> beziers01 [

	| v shape  edge els |
	v := RTView new.
	shape := RTEllipse new size: 10; color: (Color purple alpha: 0.3).
	els := (shape elementsOn: (1 to: 6)) @ RTDraggable.
	v addAll: els .
	RTHorizontalLineLayout on: v elements.

	edge := (RTBezierLine new controllingElements: v elements) edgeFrom: els first to: els last.
	v add: edge.

	v open
]

{ #category : #beziers }
RTExample >> beziers02 [
	"
	self new beziers02
	"

| v classes hierarchicalLinks depLinks dep |
v := RTView new.
classes := (RTEllipse new color: Color purple; size: 10) elementsOn: Collection withAllSubclasses.
classes @ RTDraggable @ RTPopup.
classes on: TRMouseEnter do: [ :evt | RTBlink outgoingEdgesOf: evt element ].
v addAll: classes.
hierarchicalLinks := RTEdge 
	buildEdgesFromObjects: Collection withAllSubclasses 
	from: #superclass to: #yourself 
	using: (RTLine new color: (Color white alpha: 0.2)) inView: v.

"A nice layout"
RTClusterLayout on: v elements edges: v edges.

"Computing dependencies"
dep := OrderedCollection new.
Collection withAllSubclasses do: [ :cls |
	cls methods do: [ :cm | 
		((cm literals select: [ :l | l class  == Association and: [ l value notNil ] ]) collect: #value) do: [ :depClass | (cls ~~ depClass) ifTrue: [ dep add: cls -> depClass ] ] ]
].

"Add dependency edges"
depLinks := RTEdge 
	buildEdgesFromObjects: dep
	from: #key 
	to: #value 
	using: (RTBezierLine new 
					color: (Color blue alpha: 0.2);
					follow: #superclass) inView: v.


"Move the edges at the back"
depLinks do: [ :e | e trachelShape pushBack ].
hierarchicalLinks do: [ :e | e trachelShape pushBack ].

"Open the view"
v openWithMenu
]

{ #category : #animations }
RTExample >> blinking [
	"
	self new blinking
	"
	| view el |
	view := RTView new.
	el := (RTBox new size: 100) element.
	view add: el.
	el on: TRMouseClick do: [ :evt | RTBlink on: el in: view ].
	view open.
	
]

{ #category : #layout }
RTExample >> cellLayout [
	"
	self new cellLayout
	"
	| view substrings |
	view := RTView new.
	substrings := (RTCellLayout >> #doExecute:) getSource substrings.
	view addAll: (RTLabel elementsOn: substrings).
	
	RTCellLayout on: view elements.
	view @ RTDraggableView.
	view open
]

{ #category : #layout }
RTExample >> cellLayout2 [
	"
	self new cellLayout2
	"
	| view substrings |
	view := RTView new.
	substrings := #('doExecute:' 'elements' '|').
	view addAll: (RTLabel elementsOn: substrings).
	
	RTCellLayout new lineItemsCount: 3; on: view elements.
	view @ RTDraggableView.
	view open
]

{ #category : #layout }
RTExample >> cellLayout3 [
	"
	self new cellLayout3
	"
	| view els |
	view := RTView new.
	els := RTEllipse new size: #yourself; elementsOn: ((1 to: 20) collect: [ :v | 50 atRandom ]).
	view addAll: els.
	
	RTCellLayout new lineItemsCount: 5; on: view elements.
	view @ RTDraggableView.
	view open
]

{ #category : #shapes }
RTExample >> circles [
	"
	self new circles
	"

	| view shape el |
	view := RTView new.
	shape := RTEllipse new color: (Color purple alpha: 0.2); size: 80.
	100 timesRepeat: [ 
		el := shape element translateTo: 500 atRandom @ 500 atRandom.
		el @ RTDraggable.
		view add: el. 
		view addAnimation: (RTLinearMove to: 500 atRandom @ 500 atRandom during: 2 on: el).
	].	
	view open
]

{ #category : #layout }
RTExample >> classHierarchy [
	"
	self new classHierarchy
	"
	| view |
	view := RTView new.	
	view addAll: (RTBox elementsOn: Collection withAllSubclasses).
	RTEdge 
		buildEdgesFromObjects: Collection 
		withAllSubclasses from: #superclass to: #yourself inView: view.
	RTTreeLayout on: view elements edges: view edges.
	view @ RTDraggableView.
	view open
]

{ #category : #layout }
RTExample >> clusterLayout [
	"
	self new clusterLayout
	"
	
	| v |
	v := RTView new.
	v addAll: ((RTEllipse new color: Color purple; size: 10) elementsOn: Collection withAllSubclasses) @ RTDraggable.
	RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself inView: v.
	RTClusterLayout on: v elements edges: v edges.
	v edges do: [ :e | e trachelShape pushBack ].
	v open
]

{ #category : #shapes }
RTExample >> edges [
	"
	self new edges
	"

	| view elements |
	view := RTView new.
	elements := (RTBox new color: (Color purple alpha: 0.2)) elementsOn: (Collection withAllSubclasses).
	view addAll: elements.
	
	RTEdge 
		buildEdgesFromObjects: Collection withAllSubclasses 
		from: #yourself 
		to: #superclass 
		using: (RTLine new color: (Color blue alpha: 0.2))
		inView: view.
	
	RTGridLayout on: view elements.
	view open
]

{ #category : #shapes }
RTExample >> edges2 [
	"
	self new edges2
	"
	
	| view elements |
	view := RTView new.
	elements := (RTBox new color: (Color purple alpha: 0.2); size: 40) elementsOn: #(1 2).
	elements @ RTDraggable.
	view addAll: elements.
	
	RTEdge buildEdgesFromAssociations: (Array with: 1 -> 2) inView: view.
	RTHorizontalLineLayout on: elements.
	view open
]

{ #category : #interaction }
RTExample >> edition [

	"
	self new edition
	"
	
	| view selected statusBar |
	view := RTView new.
	selected := nil.
	statusBar := nil.
	
	view on: TRMouseClick do: [ :evt |
		selected == #line ifTrue: [ 
			| ex1 ex2 line |
			ex1 := (RTBox new size: 10; color: (Color purple alpha: 0.2)) element. 
			ex2 := (RTBox new size: 10; color: (Color purple alpha: 0.2)) element.
			ex1 translateTo: evt position.
			ex2 translateTo: evt position + (100 @ 60).
			ex1 @ RTHighlightable.
			ex2 @ RTHighlightable.
			ex1 @ RTDraggable. 
			ex2 @ RTDraggable.
			line := (RTLine new "width: 3;" color: (Color blue alpha: 0.2)) edgeFrom: ex1 to: ex2.
			view addAll: { ex1 . ex2 . line }.
			line trachelShape pushBack.
		].

		selected == #circle ifTrue: [ 
			| ellipse |
			ellipse := (RTEllipse new size: 40; color: (Color yellow alpha: 0.2)) element. 
			ellipse translateTo: evt position.		
			ellipse @ RTDraggable. 
			view add: ellipse.		
		].

		
		selected == #rectangle ifTrue: [ 
			| box |
			box := (RTBox new width: 40; height: 30; color: (Color blue alpha: 0.2)) element. 
			box translateTo: evt position.		
			box @ RTDraggable. 
			view add: box.		
		].
		view canvas signalUpdate.
	].



	view @ RTDraggableView.

	view addMenu: '+ line' callback: [ selected := #line. statusBar text: 'line' ].
	view addMenu: '+ circle' callback: [ selected := #circle. statusBar text: 'circle' ].
	view addMenu: '+ rectangle' callback: [ selected := #rectangle. statusBar text: 'rectangle' ].
	view addMenu: 'Info' callback: [ :evt | UIManager default inform: 'Vectorial editing is hyper cool' ].

	statusBar := TRLabelShape new.
	statusBar text: 'Please, select an option'.
	view canvas addShape: statusBar.
	statusBar setAsFixed.
	TRConstraint stickAtTheBottomOfTheWindow: statusBar.
	
"	stack zoomInButton; zoomOutButton.
	stack title: 'Vectorial edition'.

	"

	view canvas color: Color white.
	view open
]

{ #category : #groups }
RTExample >> group1 [
	"self new group1"

	| view group1 group2 host1 host2 edgesGroup1 edgesGroup2 |
	view := RTView new.
	group1 := (RTBox new color: (Color blue alpha: 0.3)) elementsOn: (1 to: 10).
	group2 := (RTBox new color: (Color blue alpha: 0.3)) elementsOn: (1 to: 10).
	
	host1 := (RTBox new color: (Color green alpha: 0.3)) element.
	host2 := (RTBox new color: (Color green alpha: 0.3)) element.
	
	view addAll: group1; addAll: group2; add: host1; add: host2.
	
	edgesGroup1 := RTEdge 
		buildEdgesFromObjects: (1 to: 10) 
		from: [ :v | v //2 ] to: #yourself inView: view scope: group1.
	edgesGroup2 := RTEdge 
		buildEdgesFromObjects: (1 to: 10) 
		from: [ :v | v //2 ] to: #yourself inView: view scope: group2.

	
	RTTreeLayout on: group1 edges: edgesGroup1.
	RTTreeLayout on: group2 edges: edgesGroup2.
	
	RTNest new on: host1 nest: group1.
	RTNest new on: host2 nest: group2.
	
	RTHorizontalLineLayout on: (Array with: host1 with: host2).
	
	host1 @ RTDraggable.
	host2 @ RTDraggable.
	
	view canvas addMenu: 'In' callback: [ RTZoomInMove on: view ].
	view canvas addMenu: 'Out' callback: [ RTZoomOutMove on: view ].

	view @ RTDraggableView.
	
	view open
]

{ #category : #animations }
RTExample >> growingSquare [
	" 
	self new growingSquare
	"

	| view el |
	view := RTView new.
	el := RTBox new size: 20; color: (Color purple alpha: 0.2); element.
	el @ RTDraggable.
	el translateTo: 100 @ 130.
	
	el on: TRMouseClick do: [ :evt |
		| t |
		t := evt element trachelShape width + 5.
		evt element trachelShape extent: t @ t. evt signalUpdate ].

	view add: el.
	view open
]

{ #category : #shapes }
RTExample >> growingSquares [
	"
	self new growingSquares
	"
	
	| view shape |
	view := RTView new.

	shape := RTBox new size: [ :e | e model yourself ].
	1 to: 100 do: [ :i |
		view add: ((shape elementOn: i) translateTo: 20 @ 20; yourself).
	].
	RTGridLayout on: view elements.
	
	view open
]

{ #category : #shapes }
RTExample >> highlightSquare [
	"
	self new highlightSquare
	"
	
	| view shape el |
	view := RTView new.

	shape := RTBox new size: [ :e | e model yourself ].
	1 to: 100 do: [ :i |
		el := shape elementOn: i.
		el translateTo: 20 @ 20.
		el on: TRMouseEnter do: [ :e | e shape color: Color red. e signalUpdate ].
		el on: TRMouseLeave do: [ :e | e shape color: Color gray. e signalUpdate ].
		el on: TRMouseDragging do: [ :e | e shape translateBy: e step. e signalUpdate ].
		view add: el.
	].
	RTGridLayout on: view elements.
	
	view open
]

{ #category : #labels }
RTExample >> label [
	"
	self new label
	"
	| v label els |
	v := RTView new.
	label := RTLabel new height: [ :e | e model ].
	els := label elementsOn: (1 to: 30).
	v addAll: els.
	RTHorizontalLineLayout on: els.
	v open
]

{ #category : #shapes }
RTExample >> label2 [
	"
	self new label2
	"
	| view |
	view := RTView new.
	1 to: 20 do: [ :i |
		view add: (RTLabel elementOn: 'hello world').
	].
"	RTVerticalLineLayout on: view elements."
	RTGridLayout on: view elements.
"	RTHorizontalLineLayout on: view elements."
	view open
]

{ #category : #shapes }
RTExample >> label3 [
	"
	self new label3
	"
	| view |
	view := RTView new.
	1 to: 20 do: [ :i |
		view add: (RTLabel elementOn: i asString).
	].
"	RTVerticalLineLayout on: view elements."
	RTGridLayout on: view elements.
"	RTHorizontalLineLayout on: view elements."
	view open
]

{ #category : #shapes }
RTExample >> linkedSquares [
	"
	self new linkedSquares
	"
	| view shape  fromEl toEl edge |
	view := RTView new.

	shape := RTBox new size: 90; color: (Color blue alpha: 0.1).
	fromEl := shape element.
	fromEl translateTo: 20 @ 30.
	fromEl @ RTDraggable.

	toEl := shape element.
	toEl translateTo: 200 @ 80.
	toEl @ RTDraggable.
	
	edge := RTLine edgeFrom: fromEl to: toEl.  	
	view add: fromEl; add: toEl; add: edge.

	view open.
]

{ #category : #shapes }
RTExample >> manySquares [
	"
	self new manySquares
	"
	
	| view shape el |
	view := RTView new.

	shape := RTBox new.
	1 to: 7000 do: [ :i |
		el := shape elementOn: i.
		el translateTo: 20 @ 20.
		el @ RTHighlightable.
		el @ RTDraggable.
		view add: el.
	].
	RTGridLayout new gapSize: 1; on: view elements.
	
	view open
]

{ #category : #nesting }
RTExample >> multipleNesting [
	" 
	self new multipleNesting
	"
	| view inner host edges outter trachelCanvas |
	outter := OrderedCollection new.
	view := RTView new.
	
	1 to: 200 by: 10 do: [ :i |
		inner := (RTBox new color: (Color purple alpha: 0.2)) elementsOn: (1 to: i).
		host := (RTBox new color: (Color yellow alpha: 0.1)) element.
		outter add: host.

		view add: host.
		view addAll: inner.
		edges := 
			RTEdge 
				buildEdgesFromObjects: (1 to: 100) 
				from: [ :v | v // 2 ] 
				to: #yourself 
				inView: view
				scope: inner.

		"RTTreeLayout new on: inner edges: edges."
		RTGridLayout new on: inner.
		RTNest new		
			on: host nest: inner.
	].
	"RTHorizontalLineLayout on: outter."
	RTGridLayout on: outter.
	
	trachelCanvas := view setUpCanvas.
	TRFocusCenter on: trachelCanvas.
	trachelCanvas open  
]

{ #category : #nesting }
RTExample >> nestedHierarchy [
	" 
	self new nestedHierarchy
	"
	| view inner host |
	view := RTView new.
	
	inner := (RTBox new color: (Color purple alpha: 0.2)) elementsOn: (1 to: 100).
	host := (RTBox new color: (Color yellow alpha: 0.1)) element.

	inner do: [ :i | i on: TRMouseClick do: [:event | event model inspect ]  ].

	view add: host.
	view addAll: inner.
	RTEdge buildEdgesFromObjects: (1 to: 100) from: [ :v | v // 2 ] to: #yourself inView: view.

	RTTreeLayout new on: inner edges: view edges.
	RTNest new		
		on: host nest: inner.
		
	view openWithMenu
]

{ #category : #nesting }
RTExample >> nesting [
	"
	self new nesting
	"
	| view el shape inner |
	view := RTView new.
	el := (RTBox new width: 80; height: 40; color: (Color purple alpha: 0.3)) element.
	
	shape := RTBox new color: (Color purple alpha: 0.3).
	inner := shape elementsOn: (1 to: 20).

	view add: el.
	view addAll: inner.

	el @ RTDraggable.
	
	RTNest
		new 
		layout: RTGridLayout new;
		on: el nest: inner.
		
	el translateTo: 100 @ 50.
	view open.
	
	
]

{ #category : #nesting }
RTExample >> nesting2 [
	"
	self new nesting2
	"

	| view el shape  innerElements |
	view := RTView new.
	el := (RTBox new width: 80; height: 40; color: (Color purple alpha: 0.3)) element.
	el translateTo: 200 @ 150.
	shape := RTBox new color: (Color red alpha: 0.3); size: #yourself.
	
	innerElements := (1 to: 30) collect: [ :i | shape elementOn: i ].
	view addAll: innerElements.
	
	
	RTNest
		new 
		layout: RTGridLayout new;
		on: el nest: innerElements.
		
	view add: el.
	
	view open.
	
	
]

{ #category : #nesting }
RTExample >> nesting3 [
	"
	self new nesting3
	"
	| view el shape inner |
	view := RTView new.
	el := (RTBox new width: 80; height: 40; color: (Color purple alpha: 0.3)) element.
	
	shape := RTBox new color: (Color purple alpha: 0.3).
	inner := (shape elementOn: #inner).

	view add: el.
	view add: inner.

	RTNest
		new 
		layout: RTGridLayout new;
		on: el nest: (Array with: inner).
		
	el translateTo: 100 @ 50.
	view open.
	
	
]

{ #category : #animations }
RTExample >> newYear2014 [

	"
	self new newYear2014
	"
	| view txt x y el shape size offset |
	txt := 
	'
	xxxxx  xxxxx     xxx      x
	x   x  x   x    x  x     x
	   x   x   x   x   x    x x 
	  x    x   x       x    xxxxx
	 x     x   x       x      x
	xxxxx  xxxxx       x      x
	'.
	view := RTView new.
	x := 0.
	y := 0.
	size := 20.
	offset := 100 @ 100.
	txt linesDo: [ :line |
		y := y + 1.
		line do: [ :c |
			x := x + 1.
			c = $x ifTrue: [ 
				shape := (RTEllipse new size: size; color: (Color purple alpha: 0.2)).
				el := shape element.
				el translateTo: (800 atRandom @ 450 atRandom).
				"el on: ROMouseEnter do: [ :evt | ROColorAlphaFading new for: evt element nbCycles: 100 ]."
				view add: el.
				view addAnimation: (RTLinearMove new to: ((x * size) @ (y * size) + offset) during: 0.5 on: el).
			]
		].
	   x := 0.
	].
	view openInWindowSized: 800 @ 450
]

{ #category : #layout }
RTExample >> numbers [

	| view elements |
	view := RTView new.	
	elements := RTBox elementsOn: (1 to: 100).
	elements @ RTDraggable.
	view addAll: elements.
	RTEdge 
		buildEdgesFromObjects: (1 to: 100)
		from: [ :v | v // 2 ] to: #yourself 
		using: (RTLine new color: Color purple) inView: view.
	RTTreeLayout on: view elements edges: view edges.
	
	view edges do: [ :e | e trachelShape pushBack ].
	
	view @ RTDraggableView.
	view openWithMenu
]

{ #category : #popup }
RTExample >> popup1 [
	"
	self new popup1
	"
	| v els |
	v := RTView new.
	v @ RTDraggableView.
	els := (RTBox new size: 20) elementsOn: (1 to: 100).
	els @ (RTPopup new textElement: [ :e | e model printString ]).
	els @ RTDraggable.
	els on: TRMouseClick do: [ :evt | evt element inspect ].
	v addAll: els.
	RTGridLayout on: els.
	v open.

]

{ #category : #popup }
RTExample >> popupView1 [
	"
	self new popupView1
	"
	| v els |
	v := RTView new.
	v @ RTDraggableView.
	els := (RTBox new size: 20) elementsOn: (1 to: 100).
	els + RTLabel.
	
	els @ (RTPopup new group: [ :group :el |
		el model timesRepeat: [
			group add: (RTBox new size: 10; color: (Color purple alpha: 0.5)) element ].
		RTGridLayout on: group. ]).
	
	els @ RTDraggable.
	
	v addAll: els.
	RTGridLayout on: els.
	v open.

]

{ #category : #popup }
RTExample >> popupView2 [
	"
	self new popupView2
	"
	| v els background |
	v := RTView new.
	v @ RTDraggableView.
	els := (RTBox new size: 20) elementsOn: (1 to: 100).
	els + RTLabel.
	
	els @ (RTPopup new group: [ :group :el |
		el model timesRepeat: [
			group add: (RTBox new size: 10; color: (Color purple alpha: 0.5)) element ].
		RTGridLayout on: group.		
		background := (RTBox new color: (Color white alpha: 0.5)) element.
	
		RTNest new centerOn: background elements: group.
		group add: background.	
		 ]).
	
	els @ RTDraggable.
	
	v addAll: els.
	RTGridLayout on: els.
	v open.

]

{ #category : #layout }
RTExample >> smoothLayout [

	"
	self new smoothLayout
	"
	
	| v translator |
	translator := RTSmoothLayoutTranslator new.
	v := RTView new.
	v canvas addMenu: 'grid' callback: [ RTGridLayout new translator: translator; on: v elements. v canvas signalUpdate ].

	v canvas addMenu: 'hori' callback: [ RTHorizontalLineLayout new translator: translator; on: v elements. v canvas signalUpdate ].

	v canvas addMenu: 'treeV' callback: [ RTTreeLayout new translator: translator; on: v elements edges: v edges. v canvas signalUpdate ].

	v canvas addMenu: 'treeH' callback: [ RTHorizontalTreeLayout new translator: translator; on: v elements edges: v edges. v canvas signalUpdate ].

	v canvas addMenu: 'cluster' callback: [ RTClusterLayout new translator: translator; on: v elements edges: v edges. v canvas signalUpdate ].
	
	v canvas addMenu: 'circle' callback: [ RTCircleLayout new translator: translator; scaleBy: 0.8; on: v elements. v canvas signalUpdate ].
	
	v canvas addMenu: 'radial' callback: [ RTRadialTreeLayout new translator: translator; on: v elements. v canvas signalUpdate ].
	
	
	v addAll: (RTBox new elementsOn: (1 to: 100)).
	RTEdge buildEdgesFromObjects: (1 to: 100) from: [ :value | value // 2  ] to: #yourself inView: v.

	"RTGridLayout on: v elements."
	RTTreeLayout new  on: v elements edges: v edges.
	v open
]

{ #category : #animations }
RTExample >> zooming [

	| v |
	v := RTView new.
	v add: (RTBox new size: 40) element.

	v canvas addMenu: 'In' callback: [ RTZoomInMove on: v ].
	v canvas addMenu: 'Out' callback: [ RTZoomOutMove on: v ].
	v @ RTDraggableView.
	v open.

]
