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
	view inspect.
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
	view inspect.
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
	
	trachelCanvas := view createAndFillCanvas.
	TRFocusCenter on: trachelCanvas.
	trachelCanvas open  
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
	
	trachelCanvas := view createAndFillCanvas.
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
		
	view open
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
		
	view open
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
	shape := RTBox new color: (Color red alpha: 0.3); size: [ :e | e model ].
	
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
RTExample >> nesting2 [
	"
	self new nesting2
	"

	| view el shape  innerElements |
	view := RTView new.
	el := (RTBox new width: 80; height: 40; color: (Color purple alpha: 0.3)) element.
	el translateTo: 200 @ 150.
	shape := RTBox new color: (Color red alpha: 0.3); size: [ :e | e model ].
	
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
