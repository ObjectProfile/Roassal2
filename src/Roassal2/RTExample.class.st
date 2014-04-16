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

{ #category : #edges }
RTExample >> arrowedEdges01 [
	"
	self new arrowedEdges01
	"

	| v e1 e2 l |
	v := RTView new.
	e1 := (RTEllipse new size: 10) element.
	e2 := (RTEllipse new size: 10) element.
	e2 translateBy: 100@0.

	v add: e1.
	v add: e2.
	l := RTEdge from: e1 to: e2.
	l + (RTLine new color: Color red) + (RTArrow new color: Color red).
	v add: l.

	v open
]

{ #category : #attachpoints }
RTExample >> attachPoint01 [

| v e1 e2 l |
v := RTView new.
e1 := (RTEllipse new size: 30; color: (Color blue alpha: 0.3)) element.

e2 := (RTEllipse new size: 30; color: (Color yellow alpha: 0.3)) element.

l := (RTLine new attachPoint: RTShorterDistanceAttachPoint new) edgeFrom: e1 to: e2.
 
e1 @ RTDraggable.
e2 @ RTDraggable.

v addAll: (Array with: l with: e2 with: e1).

v open
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
classes when: TRMouseEnter do: [ :evt | RTBlink outgoingEdgesOf: evt element ].
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

{ #category : #beziers }
RTExample >> beziersWithArrow [

	"self new beziersWithArrow"
	| v shape  edge els |
	v := RTView new.
	shape := RTEllipse new size: 10; color: (Color purple alpha: 0.3).
	els := (shape elementsOn: (1 to: 6)) @ RTDraggable.
	v addAll: els .
	RTHorizontalLineLayout on: v elements.
	edge := (RTEdge from: els first to: els last) + ((RTBezierLine new controllingElements: v elements)  + (RTArrowHead new) ).
	v add: edge.

	v open
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
	el when: TRMouseClick do: [ :evt | RTBlink on: el in: view ].
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

{ #category : #layout }
RTExample >> circleLayout [
	"
	self new circleLayout
	"
	| v els |
	v := RTView new.
	els := RTBox new size: 10; elementsOn: (1 to: 100).
	v addAll: els.
	els @ RTDraggable.
	RTEdge buildEdgesFromObjects: (1 to: 100) from: [ :value | value // 2 ] to: #yourself using: (RTLine new color: (Color blue alpha: 0.4); withVerticallAttachPoint; yourself) inView: v.
	RTCircleLayout new initialRadius: 260; on: v elements.
	v @ RTDraggableView.
	v open
]

{ #category : #shapes }
RTExample >> circleWaves [
	"
	self new circleWaves
	"
	"Inspired from http://haptic-data.com/toxiclibsjs/examples/ColorWaves_raphael.html"
	
	| nbOfCircles  v shape mousePos |
	nbOfCircles := 25.
	
	mousePos := 50 @ 50.
	v := RTView new.
	shape := RTEllipse new sizeElement: [ :el | ((el position - mousePos) r abs / 3) min: 50 ]; color: (Color blue alpha: 0.4).
	v addAll: (shape elementsOn: (1 to: nbOfCircles)).
	RTGridLayout on: v elements.
	
	v on: TRMouseMove do: [ :evt |  Transcript show: evt positionFromCamera printString; cr . mousePos := evt positionFromCamera. v elements do: #updateShape. v canvas signalUpdate ].
	
	v open
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
	view addAll: (RTBox elementsOn: Collection withAllSubclasses) @ RTDraggable.
	RTEdge 
		buildEdgesFromObjects: Collection 
		withAllSubclasses from: #superclass to: #yourself inView: view.
	RTTreeLayout on: view elements edges: view edges.
	view @ RTDraggableView.
	view edges do: [ :e | e trachelShape pushBack ].
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
RTExample >> colorWaves [
	"
	self new colorWaves
	"
	"Inspired from http://haptic-data.com/toxiclibsjs/examples/ColorWaves_raphael.html"
	
	| nbOfCircles normalizer v shape mousePos |
	nbOfCircles := 25.
	
	mousePos := 50 @ 50.
	normalizer := RTMultiLinearColor new. 
	v := RTView new.
	shape := RTEllipse new 
					sizeElement: [ :el | ((el position - mousePos) r abs / 3) min: 50 ]; 
					colorElement: [ :el | 
						| va|
						va := ((((el position - mousePos) r abs / 3) min: 50) / 50).
						(normalizer level: va) alpha: 0.4 ].
	v addAll: (shape elementsOn: (1 to: nbOfCircles)).
	RTGridLayout on: v elements.
	
	v on: TRMouseMove do: [ :evt | mousePos := evt positionFromCamera. v elements do: #updateShape. v canvas signalUpdate ].
	
	v open
]

{ #category : #edges }
RTExample >> directedEdges01 [
	"
	self new directedEdges01
	"

| v classesRoassal classesTrachel shape1 shape2 |
v := RTView new.
v @ RTDraggableView.

shape1 := RTEllipse new size: #numberOfMethods; color: (Color gray alpha: 0.3).
shape2 := RTEllipse new size: #numberOfMethods; color: (Color pink alpha: 0.3).
classesRoassal := shape1 elementsOn: (RTObject withAllSubclasses).
classesTrachel := shape2 elementsOn: (TRObject withAllSubclasses).

classesRoassal@ RTPopup.

classesTrachel @ RTPopup.

v addAll: classesRoassal.
v addAll: classesTrachel.

"RTEdge 
	buildEdgesFromObjects: RTObject withAllSubclasses 
	from: #yourself 
	toAll: [ :c | c dependentClasses copyWithoutAll: RTObject withAllSubclasses ] 
	using: (RTDirectedLine new color: (Color blue alpha: 0.5)) inView: v.
"
RTEdge 
	buildEdgesFromObjects: RTObject withAllSubclasses 
	from: #yourself 
	toAll: [ :c | c dependentClasses copyWithoutAll: RTObject withAllSubclasses ] 
	using: (RTDirectedLine new color: (Color blue alpha: 0.5)) inView: v.

"RTGridLayout on: classesRoassal.
RTGridLayout on: classesTrachel."

"RTCircleLayout new initialRadius: 250; on: classesRoassal.
RTCircleLayout new initialRadius: 150; on: classesTrachel.
"

RTHorizontalLineLayout new gapSize: 1;on: classesRoassal, classesTrachel.

"TRConstraint move: classesRoassal onTheRightOf: classesTrachel."
"TRConstraint move: classesRoassal onTheCenterOf: classesTrachel."

v open
]

{ #category : #edges }
RTExample >> directedEdges02 [
	"
	self new directedEdges02
	"

| v elements1 elements2 objects1 objects2 shape1 shape2 assocs |

objects1 := 1 to: 5.
objects2 := 6 to: 10.
assocs := { 1 -> 5 . 2 -> 6 . 6 -> 10  . 10 -> 2}.


v := RTView new.
v @ RTDraggableView.

shape1 := RTEllipse new size: 10; color: (Color gray alpha: 0.3).
shape2 := RTEllipse new size: 10; color: (Color pink alpha: 0.3).
elements1 := shape1 elementsOn: objects1.
elements2 := shape2 elementsOn: objects2.

elements1 @ RTPopup.
elements2 @ RTPopup.

v addAll: elements1.
v addAll: elements2.

RTEdge 
	buildEdgesFromObjects: assocs
	from: #key
	to:  #value 
	using: (RTDirectedLine new color: (Color blue alpha: 0.5)) inView: v.


RTHorizontalLineLayout new gapSize: 1;on: elements1, elements2.

v open
]

{ #category : #edges }
RTExample >> dynamicEdges01 [
	"
	self new dynamicEdges01
	"

| v es |
v := RTView new.
es := ((RTEllipse new size: 30) + RTLabel) elementsOn: (1 to: 20).
v addAll: es.
RTCircleLayout new initialRadius: 150; on: es.

es @ (RTShowEdge new connectTo: [ :value | value - 5 to: value + 5]; shape: (RTLine new color: (Color blue alpha: 0.4))).

v open
]

{ #category : #edges }
RTExample >> dynamicEdges02 [
	"
	self new dynamicEdges02
	"
| v es |
v := RTView new.
es := ((RTEllipse new size: 30) + RTLabel) elementsOn: (1 to: 20).
v addAll: es.
RTCircleLayout new initialRadius: 150; on: es.

es @ (RTShowEdge new 
			connectTo: [ :value | value - 5 to: value + 5]; 
			shape: [ :el | RTBezierLine new 
								centerOfObjects: (el model - 5 to: el model + 5) inView: v; 
								color: (Color blue alpha: 0.4) ] ).

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
	
	view when: TRMouseClick do: [ :evt |
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

{ #category : #nesting }
RTExample >> elementWithFontsZooming [
	"
	self new elementWithFontsZooming
	"
	| view firstGroup secondGroup bothGroups mainElement originalExtent mainWithNested |
	view := RTView new.
	"element creation"
	mainElement := RTBox new color: (Color blue alpha: 0.3); elementOn: nil.
	firstGroup := (RTLabel new) elementsOn: { 'Smalltalk'. 'World'}.
	secondGroup := (RTBox new size: #yourself) elementsOn: #(30 40).
	bothGroups := RTGroup with: firstGroup with: secondGroup.
	"layouting"
	RTHorizontalLineLayout new gapSize: 1; alignLeft; on: firstGroup; on: secondGroup.
	RTVerticalLineLayout new gapSize: 1; alignLeft; on: bothGroups.
	RTNest new padding: 1; on: mainElement nest: firstGroup, secondGroup.
	mainWithNested := RTGroup with: mainElement with: bothGroups.
	mainWithNested @ RTDraggable.
	view add: mainWithNested.
	"define menu and their actions"
	originalExtent := mainElement extent.
	view addMenu: 'Smaller' 
		callback: [ view addAnimation: (RTResizeMove new 
													toExtent: mainElement extent * 0.6 
													during: 0.3 on: mainElement) ].
	view addMenu: 'Bigger' 
		callback: [ view addAnimation: (RTResizeMove new 
													toExtent: mainElement extent * (1 / 0.6) 
													during: 0.3 on: mainElement) ].
	view addMenu: 'Original' callback: [ mainElement extent: originalExtent. view signalUpdate ].
	view addMenu: 'Half' callback: [ mainElement extent: originalExtent / 2. view signalUpdate ].
	^ view open
]

{ #category : #nesting }
RTExample >> elementZooming [
	"
	self new elementZooming
	"
	| view firstGroup secondGroup bothGroups mainElement originalExtent mainWithNested |
	view := RTView new.
	"element creation"
	mainElement := RTBox new color: (Color blue alpha: 0.3); elementOn: nil.
	firstGroup := (RTBox new size: #yourself) elementsOn: #(20 50).
	secondGroup := (RTBox new size: #yourself) elementsOn: #(30 40).
	bothGroups := RTGroup with: firstGroup with: secondGroup.
	"layouting"
	RTHorizontalLineLayout new gapSize: 1; alignLeft; on: firstGroup; on: secondGroup.
	RTVerticalLineLayout new gapSize: 1; alignLeft; on: bothGroups.
	RTNest new padding: 1; on: mainElement nest: firstGroup, secondGroup.
	mainWithNested := RTGroup with: mainElement with: bothGroups.
	mainWithNested @ RTDraggable.
	view add: mainWithNested.
	"define menu and their actions"
	originalExtent := mainElement extent.
	view addMenu: 'Smaller' 
		callback: [ view addAnimation: (RTResizeMove new 
													toExtent: mainElement extent * 0.6 
													during: 0.3 on: mainElement) ].
	view addMenu: 'Bigger' 
		callback: [ view addAnimation: (RTResizeMove new 
													toExtent: mainElement extent * (1 / 0.6) 
													during: 0.3 on: mainElement) ].
	view addMenu: 'Original' callback: [ mainElement extent: originalExtent. view signalUpdate ].
	view addMenu: 'Half' callback: [ mainElement extent: originalExtent / 2. view signalUpdate ].
	^ view open
]

{ #category : #animations }
RTExample >> escapingCircle [

	| v e |
	v := RTView new.
	e := (RTEllipse new size: 50; color: (Color blue alpha: 0.4)) element.
	v add: e.

	e when: TRMouseEnter do: [ :evt | 
		| newPos |
		newPos := ((300 atRandom - 150) @ (300 atRandom - 150)) + evt element position. 
		v addAnimation: (RTAccelerationMove to: newPos  during: 2 on: evt element) ].
	v open.


]

{ #category : #animations }
RTExample >> expandingArc [
	"
	self new expandingArc
	"

	| v e angle externalRadius |
	v := RTView new.
	angle := VIAnimatedValue new
					evaluator: [ :t | 0 interpolateTo: 360 at: t ];
					timer: (VITimer new cycleLength: 4);
					yourself.
	externalRadius := VIAnimatedValue new
					evaluator: [ :t | 50 interpolateTo: 150 at: t ];
					timer: (VITimer new cycleLength: 4);
					yourself.
					
	e := (RTArc new 
			innerRadius: 50;
			externalRadius: externalRadius;
			outerAngle: angle innerAngle: 30) element.
	v add: e.
	v addAnimation: (TRResetAllShapes new trCanvas: v canvas).
	angle start.
	externalRadius start.
	v open
]

{ #category : #layout }
RTExample >> forceBasedLayout [
	"
	self new forceBasedLayout
	"

	| v classes edges | 
	v := RTView new.
	classes := (RTEllipse new color: (Color purple alpha: 0.3); size: 10) elementsOn: Collection withAllSubclasses.
	(classes elementFromModel: Collection) trachelShape color: Color red.
	classes @ RTDraggable.
	v addAll: classes.

	edges := RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself using: (RTLine new color: (Color purple alpha: 0.2)) inView: v.

	edges do: [ :e | e trachelShape pushBack ].

	"RTForceBasedLayout on: v elements edges: v edges."
	v addAnimation: (RTSpringLayoutStepping new view: v).
	v @ RTDraggableView.
	v open.
	v


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
	
	el when: TRMouseClick do: [ :evt |
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

{ #category : #interaction }
RTExample >> highlight [
	" self new highlight "
		
	| v es |
	v := RTView new.
	es := ((RTBox new size: 30)" + RTLabel") elementsOn: (1 to: 16).

	es @ (RTHighlightable highlight: [ :vv | { vv - 1 . vv . vv + 1 . vv - 4 . vv + 4 } ]).

	RTGridLayout on: es.
	v addAll: es.
	v open
]

{ #category : #shapes }
RTExample >> highlightSquare [
	"
	self new highlightSquare
	"
	
	| view shape el |
	view := RTView new.

	shape := RTBox new size: #yourself.
	1 to: 100 do: [ :i |
		el := shape elementOn: i.
		el translateTo: 20 @ 20.
		el when: TRMouseEnter do: [ :e | e shape color: Color red. e signalUpdate ].
		el when: TRMouseLeave do: [ :e | e shape color: Color gray. e signalUpdate ].
		el when: TRMouseDragging do: [ :e | e shape translateBy: e step. e signalUpdate ].
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

{ #category : #camera }
RTExample >> movingCamera [
	"
	self new movingCamera
	"
		
	| v menu |
	v := RTView new.
	v add: (RTEllipse new size: 50) element.

	menu := RTMenuBuilder new view: v.
	menu menu: '<-' callback: [ v canvas camera translateBy: -10 @ 0. v signalUpdate ].
	menu menu: '->' callback: [ v canvas camera translateBy: 10 @ 0. v signalUpdate ].
	menu menu: 'V' callback: [ v canvas camera translateBy: 0 @ 10. v signalUpdate ].
	menu menu: '^' callback: [ v canvas camera translateBy: 0 @ -10. v signalUpdate ].
	 
	v open
]

{ #category : #nesting }
RTExample >> multipleNesting [
	" 
	self new multipleNesting
	"
	| view inner host edges outter trachelCanvas resizable |
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
	
	"Zoom a specific element"
	resizable := outter at: (Random new nextInt: outter size).
	view addMenu: 'Smaller' 
		callback: [ view addAnimation: (RTResizeMove new 
													toExtent: resizable extent * 0.6 
													during: 0.3 on: resizable) ].
	view addMenu: 'Bigger' 
		callback: [ view addAnimation: (RTResizeMove new 
													toExtent: resizable extent * (1 / 0.6) 
													during: 0.3 on: resizable) ].
	
	view openWithMenu
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

	inner do: [ :i | i when: TRMouseClick do: [:event | event model inspect ]  ].

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

{ #category : #normalizers }
RTExample >> normalizer01 [
	"
	self new normalizer01
	"
	| v es n |
	v := RTView new.
	n := RTGrayLinearColor new 
				command: #asInteger; 
				scope: ($a to: $z).
				
	es := RTBox new
				size: 15;
				color: n;
				elementsOn: ($a to: $z).
				
	v addAll: es.
	es @ RTPopup.
	RTGridLayout on: es.

	v open
]

{ #category : #layout }
RTExample >> numbers [
	"self new numbers"
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
	els when: TRMouseClick do: [ :evt | evt element inspect ].
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

{ #category : #popup }
RTExample >> popupView3WithBackground [
	"
	self new popupView3WithBackground
	"
| view |
view := RTMondrianViewBuilder new.
view interaction noInteractions.

view interaction popup group: [ :group :el |
	| background elements | 
	elements := OrderedCollection new.
	background := (RTBox new color: (Color green alpha: 0.5)) element.
	el model timesRepeat: [ 
			elements add: (RTBox new size: 10; color: (Color purple alpha: 0.5)) element.
			].
	RTGridLayout on: elements.
	RTNest new centerOn: background elements: elements.
	group add: background .
	group addAll: elements ].

view shape rectangle size: #yourself.
view nodes: (1 to:50).
view gridLayout.
view open

]

{ #category : #popup }
RTExample >> popupWithLegend [
	"
	self new popupWithLegend
	"

| view |

view := RTMondrianViewBuilder new.
view interaction noInteractions.

view interaction popup group: [ :group :el |
	
	| background elements cls legend1 legend2 | 
	elements := RTGroup new.
	background := (RTBox new color: (Color green alpha: 0.8)) element.
	
	el model timesRepeat: [ 
			cls := RTEllipse.
			50 atRandom > 25
				ifTrue: [ cls := RTBox ].
			elements add: (cls new size: 10; color: (Color purple alpha: 0.5)) element
			].
	RTGridLayout on: elements.
	
	
	"Legend Good"
	legend1 := RTGroup new.
	legend1 add: (RTBox new size: 10; color: (Color purple alpha: 0.5)) element.
	legend1 add: (RTLabel elementOn: '= Good').
	RTHorizontalLineLayout on: legend1.
	
	"Legend Bad"
	legend2 := RTGroup new.
	legend2 add: (RTEllipse new size: 10; color: (Color purple alpha: 0.5)) element.
	legend2 add: (RTLabel elementOn: '= Bad').
	RTHorizontalLineLayout on: legend2.
	
	RTVerticalLineLayout new gapSize: 0; on: (Array with: legend1 with: legend2 with: elements). 
	
		RTNest new centerOn: background elements: (Array with: legend1 with: legend2 with: elements).

	
	group add: background.
	group addAll: legend1.
	group addAll: legend2.
	group addAll: elements ].


view shape rectangle size: #yourself.
view nodes: (1 to:50).
view gridLayout.
view open
]

{ #category : #labels }
RTExample >> rotatingLabels [
	"
	self new rotatingLabels
	"

	| v shape |
	v := RTView new.
	shape := RTRotatedLabel new.
	shape angleInDegree: [ :cls | cls numberOfMethods negated / 1.5 ].
	shape text: [ :cls | '                                                                                ', cls name ].
	shape color: (Color black alpha: 0.2).
	v addAll: (shape elementsOn: Collection withAllSubclasses).

	v canvas color: Color white.
	v open
]

{ #category : #labels }
RTExample >> rotatingLabelsAnimated [
	"
	self new rotatingLabelsAnimated
	"

	| v shape timer |
	v := RTView new.
	timer := VITimer new cycleLength: 2.
	
	
	shape := RTRotatedLabel new.
	"shape angleInDegree: [ :cls | cls numberOfMethods negated / 1.5 ]."
	shape angleInDegree: [ :cls | 
		| valueEnd |
		valueEnd := cls numberOfMethods negated / 1.5.
		VIAnimatedValue new
					evaluator: [ :t | 0 interpolateTo: valueEnd at: t ];
					timer: timer;
					yourself. ].

	shape text: [ :cls | '                                                                                ', cls name ].
	shape color: (Color black alpha: 0.2).
	v addAll: (shape elementsOn: Collection withAllSubclasses).

	v canvas color: Color white.
	v addAnimation: TRResetAllShapes new.
	timer start.
	v open
]

{ #category : #animations }
RTExample >> shrinking [
	"
	self new shrinking
	"
| e v |
v := RTView new.
e := (RTBox new color: Color green; width: 150; height: 120) element.
v add: e.

e when: TRMouseClick do: [ :evt |
	| anim |
	anim := RTResizeMove new toExtent: (50 @ 30) on: e.
	anim after: [ 
		| el |
		el := RTLabel elementOn: 'hello'.
		v add: el.
		RTNest new on: e nest: (Array with: el). e trachelShape signalUpdate ].
	v addAnimation: anim.
].
e @ RTDraggable.
v open
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
	
"	v canvas addMenu: 'spring' callback: [ RTForceBasedLayout new translator: translator; on: v elements. v canvas signalUpdate ]."
	
	
	v addAll: (RTBox new elementsOn: (1 to: 100)).
	RTEdge buildEdgesFromObjects: (1 to: 100) from: [ :value | value // 2  ] to: #yourself inView: v.

	"RTGridLayout on: v elements."
	RTTreeLayout new  on: v elements edges: v edges.
	v open
]

{ #category : #beziers }
RTExample >> softviz01 [
	"
	self new softviz01
	Circle = classes, size = number of methods; gray links = inheritance; blue links = dependencies; layout = force based layout on the inheritance links
	"
| v inheritanceEdges shape |
v := RTView new.
shape := RTEllipse new color: (Color red alpha: 0.4); size: [ :e | e numberOfMethods / 5 max: 5].
v addAll: (shape elementsOn: Collection withAllSubclasses).

"Defining edges from inheritance"
inheritanceEdges := 
	RTEdge buildEdgesFromObjects: Collection withAllSubclasses from: #superclass to: #yourself inView: v.

"Layout the whole thing"
RTForceBasedLayout new 
	userDefinedEdges: inheritanceEdges;
	on: v elements.

"Defining edges from dependencies"
Collection withAllSubclasses do: [ :cls |
cls methods do: [ :cm | 
			((cm literals select: [ :l | l class  == Association and: [ l value notNil ] ]) collect: #value) do: [ :depClass | (cls ~~ depClass and: [ Collection withAllSubclasses includes: depClass ]) ifTrue: [ 
			
		RTEdge buildEdgesFromAssociations: { cls -> depClass } using: (RTBezierLine new follow: #superclass; color: (Color blue alpha: 0.1)) inView: v ] ] ]
].
	
"Open the view"
v open

]

{ #category : #'software visualization' }
RTExample >> systemComplexity [
	"
	self new systemComplexity
	"

	| v els edges |
	v := RTView new.
	els := RTBox new 
				height: [ :c | c numberOfMethods max: 5 ];
				borderColor: Color black;
				width: [ :c | c numberOfVariables * 5 max: 5 ];
				color: (RTGrayLinearColor new command: #numberOfLinesOfCode; scope: Collection withAllSubclasses);
				elementsOn: Collection withAllSubclasses.
	v addAll: els.
	els @ RTDraggable @ RTPopup.

	edges := RTEdge 
			buildEdgesFromObjects: Collection withAllSubclasses 
			from: #superclass 
			to: #yourself 
			using: (RTLine new withVerticallAttachPoint; yourself) 
			inView: v.
	edges do: #moveBehindItsExtremities.

	RTTreeLayout on: v elements.

	v @ RTDraggableView.
	v open
]

{ #category : #fun }
RTExample >> worm [
	"
	self new worm
	"

| v s e last lineLength callback nbOfElements head |
v := RTView new.
s := RTEllipse new 
				size: [ :m | m * 10 ]; 
				color: (Color blue alpha: 0.4).
nbOfElements := 10.
last := nil.
1 to: nbOfElements do: [ :i | 
	e := (s elementOn: i).
	v add: e.		
	last ifNotNil: [ v add: (RTLine new edgeFrom: e to: last) ].
	last := e.		
].

lineLength := 40.

callback := TRTranslationCallback 
	block: [ :shape :step | 
			| diff alpha dist |
			(shape element outgoingEdges collect: #to) do: [ :el | 
				diff := shape position - el position.
				alpha := diff theta.
				dist := ((diff x * diff x) + (diff y * diff y)) sqrt. 
				el translateBy: (alpha cos * (dist - lineLength)) @ (alpha sin * (dist - lineLength)) ] ].
 
v elements do: [ :el | el trachelShape addCallback: callback ].

head := v elements last.
v when: TRMouseMove do: [ :evt | 
	head translateBy: (evt positionFromCamera - head position) / 10.
	v canvas signalUpdate ].
v open
]

{ #category : #animations }
RTExample >> zooming [

	| v |
	v := RTView new.
	v add: (RTBox new size: 40) element @ RTHighlightable @ RTDraggable.

	v canvas addMenu: 'In' callback: [ RTZoomInMove on: v ].
	v canvas addMenu: 'Out' callback: [ RTZoomOutMove on: v ].
	v @ RTDraggableView.
	v open.

]
