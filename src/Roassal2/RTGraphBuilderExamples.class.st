Class {
	#name : #RTGraphBuilderExamples,
	#superclass : #Object,
	#category : 'Roassal2-Builder-Graph'
}

{ #category : #'to do' }
RTGraphBuilderExamples >> exampleToWorkOn [


| b |
b := RTGraphBuilder new.
b nodes
	if: [ :c | c inheritsFrom: RTShape ];
	color: Color green.
	
b nodes
	if: [ :c | c inheritsFrom: RTLayout ];
	color: Color yellow.
	
b nodes
	if: [ :c | 'TR*' match: c name ];
	color: Color purple.
	
b nodes color: Color red.

b edges 
	connectTo: #dependentClasses;
	useInLayout.

"b edges
	chainedConnectTo: #dependentClasses;
	color: Color red."

b layout 
	if: [ :c | 'TR*' match: c name ];
	forceCharge: -100.	
b layout 
	if: [ :c | c inheritsFrom: RTLayout ];
	forceCharge: -100.	
b layout 
	if: [ :c | c inheritsFrom: RTShape ];
	forceCharge: -100.	

b layout 
	if: [ :c | c inheritsFrom: RTLayout ];
	translateBy: 150 @ 50.	
b layout 
	if: [ :c | c inheritsFrom: RTShape ];
	translateBy: -150 @ -50.	
	
b global
	minSize: 15;
	alphaColor: 0.4.
b addAll: RTObject withAllSubclasses, TRObject withAllSubclasses.

b open.
b view canvas
]

{ #category : #simples }
RTGraphBuilderExamples >> simple01 [
	"
	self new simple01
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		if: [ :obj | obj < 15 ]; shape: (RTEllipse new size: 20; color: Color blue).
	b nodes
		if: [ :obj | obj >= 15 ]; shape: (RTEllipse new size: 10; color: Color red).
		
	b layout 
		if: [ :obj | obj < 15 ]; use: (RTCircleLayout new).
	b layout
		if: [ :obj | obj >= 15 ]; use: (RTGridLayout new).
	b addAll: (1 to: 20).
	b open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple02 [
	"
	self new simple02
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		if: [ :cls | cls numberOfMethods < 15 ]; shape: (RTEllipse new size: 20; color: Color blue).
	b nodes
		if: [ :cls | cls numberOfMethods >= 15 ]; shape: (RTEllipse new size: 40; color: Color red).

	b edges
		if: [ :cls | cls numberOfMethods >= 15 ];
		connectTo: [ :c | c subclasses ].

	b layout 
		if: [ :cls | cls numberOfMethods >= 15 ]; use: (RTTreeLayout new).
	b layout
		if: [ :cls | cls numberOfMethods < 15 ]; use: (RTGridLayout new).
	b addAll: (RTShape withAllSubclasses).
	b open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple03 [
	"
	self new simple03
	"

	| b |
	b := RTGraphBuilder new.
	b nodes shape: (RTEllipse new size: 30).

	b global
		normalizeColor: #yourself using: (Array with: Color green with: Color red).

	b layout use: RTGridLayout new.
	b addAll: (1 to: 20).
	b open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple04 [
	"
	self new simple04
	"

	| b |
	b := RTGraphBuilder new.

	b nodes shape: RTEllipse new.

	b layout use: (RTFlowLayout new maxWidth: 500).

	b global 
		normalizeSize: #numberOfMethods min: 5 max: 90.
	b global
		normalizeColor: #numberOfMethods using: (Array with: Color green with: Color red).

	b addAll: (Collection withAllSubclasses).

	b open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple05WithInteraction [

	"
	self new simple05WithInteraction
	"
	
	| g |
	g := RTGraphBuilder new.
	
	g nodes
		shape: (RTEllipse new size: 20) + RTLabel;
		noPopup;
		whenOverHighlight: [ :v | { v - 1 . v . v + 1 } ].
	g layout use: RTFlowLayout new.
	g addAll: (1 to: 50).
	g open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple06AddingEdge [

	"
	self new simple06AddingEdge
	"
	
	| g |
	g := RTGraphBuilder new.
	
	g nodes
		shape: (RTEllipse new size: 20) + RTLabel;
		whenOverShowEdges: [ :v | Array with: v - 1 with: v + 1 ];
		noPopup.
	g layout use: RTFlowLayout new.
	g addAll: (1 to: 50).
	g open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple07HierarchicalBundleEdge [
	"
	self new simple07HierarchicalBundleEdge
	"

	| b |
	b := RTGraphBuilder new.
	b nodes shape: (RTEllipse new  size: 30) + RTLabel.
	b edges if: [:v | v = 1 ]; bundleConnectTo: [ :v | #(2 3) ].
	b layout circle.
	b addAll: (1 to: 3).
	b open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple08ColoredEdge [
	"
	self new simple08ColoredEdge
	"

	| b |
	b := RTGraphBuilder new.
	b nodes color: Color blue.
	b edges
		connectFrom: [ :v | v // 6 ];
		if: [ :v | v ~~ 50 ];
		color: Color gray.
		
	b edges
		connectFrom: [ :v | v // 6 ];
		if: [ :v | v = 50 ];
		color: Color red.

	b layout circle radius: 220.
	b addAll: (1 to: 100).

	b open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple10IfColorAndCurvedEdges [
	"
	self new simple10IfColorAndCurvedEdges
	"

	| b |
	b := RTGraphBuilder new.
	b nodes color: Color gray.
	b edges
		connectTo: [ :v | v + 2 ];
		follow: [ :v | v + 1 ];
		if: [:v | v = 1 ];
		color: Color red.
	b layout grid.
	b addAll: #(1 2 3).

	b open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple11 [
	"
	self new simple11
	"

	| b |
	b := RTGraphBuilder new.

	b nodes shape: (RTEllipse new size: 13; color: (Color blue alpha: 0.3)).

	b edges
		connectTo: #subclasses.

	b edges
		connectTo: #dependentClasses;
		shape: (RTLine new color: Color lightBlue).


	b layout use: (RTCircleLayout new initialRadius: 230).
	b addAll: (Collection withAllSubclasses).

	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft01 [
	"
	self new vissoft01
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		shape: (RTEllipse new size: [ :c | 5 max: c numberOfMethods ]; color: (Color blue alpha: 0.3)).

	b edges connectTo: [ :c | c subclasses ]; useInLayout.

	b layout  tree.
		
	b addAll: (RTShape withAllSubclasses).
	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft02 [
	"
	self new vissoft02
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		if: [ :obj | obj isBehavior ];
		shape: (RTEllipse new size: [ :c | 5 max: c numberOfMethods ]).

	b global
		normalizeColor: [ :cls | cls numberOfMethods ] using: (Array with: Color green with: Color red).

	b edges
		if: [ :obj | obj isBehavior ];
		connectTo: [ :c | c subclasses ];
		useInLayout;
		shape: (RTLine new color: Color gray).

	b layout tree.
		
	b addAll: (RTShape withAllSubclasses).
	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft03 [
	"
	self new vissoft03
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		shape: (RTEllipse new size: #numberOfMethods).

	b edges
		connectTo: [ :c | c subclasses ];
		shape: (RTLine new color: Color gray).

	b layout 
		use: (RTForceBasedLayout new).

	b global
		minSize: 10;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red);
		alphaColor: 0.4.

	b addAll: (RTObject withAllSubclasses).
	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft04 [
	"
	self new vissoft04
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		shape: (RTEllipse new size: #numberOfMethods);
		whenOverShowEdges: [ :cls | cls dependentClasses ].

	b edges
		if: [ :obj | obj isBehavior ];
		connectTo: [ :c | c subclasses ];
		useInLayout;
		shape: (RTLine new color: Color gray).

	b layout tree.
	
	b global
		minSize: 5;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red).

	b addAll: (RTObject withAllSubclasses).
	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft05 [
	"
	self new vissoft05
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		shape: (RTEllipse new size: #numberOfMethods);
		whenOverShowEdges: [ :cls | cls dependentClasses ].

	b edges
		connectTo: [ :c | c subclasses ];
		shape: (RTLine new color: Color gray).

	b layout 
		use: (RTForceBasedLayout new charge: -180).

	b global
		minSize: 10;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red).

	b addAll: (RTObject withAllSubclasses).
	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft06HierarchicalBundleEdges [
	"
	self new vissoft06HierarchicalBundleEdges
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		shape: (RTEllipse new size: #numberOfMethods);
		whenOverShowEdges: [ :cls | cls dependentClasses ].

	b edges
		bundleConnectTo: #subclasses;
		useInLayout.

	b layout 
		use: (RTTreeLayout new ).
		"use: (RTForceBasedLayout new charge: -150)."

	b global
		minSize: 10;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red);
		alphaColor: 0.4.

	b addAll: (RTObject withAllSubclasses).
	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft07WithLabel [
	"
	self new vissoft07WithLabel
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		shape: (RTEllipse new size: #numberOfMethods);
		whenOverShowEdges: [ :cls | cls dependentClasses ];
		labelled.

	b edges
		if: [ :obj | obj isBehavior ];
		connectTo: [ :c | c subclasses ];
		shape: (RTLine new color: Color gray).

	b layout force charge: -150.

	b global
		minSize: 10;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red);
		alphaColor: 0.4.

	b addAll: (RTObject withAllSubclasses).
	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft08DepAnalysis [
	"
	self new vissoft08DepAnalysis
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		if: [ :c | 'RT*' match: c name ];
		color: Color red.
	b nodes
		if: [ :c | 'TR*' match: c name ];
		color: Color purple.
		
	b edges
		connectTo: #subclasses;
		useInLayout.
	b edges
		connectTo: #dependentClasses;
		if: [ :f :t | ('TR*' match: t name )and: [ 'RT*' match: f name ] ];
"			scopedTo: [ :c | 'TR*' match: c name ] "
		color: (Color blue alpha: 0.4).

	b layout cluster.

	b global
		alphaColor: 0.4;
		normalizeSize: #numberOfMethods min: 5 max: 60.

	b addAll: RTObject withAllSubclasses.
	b addAll: TRObject withAllSubclasses.
	b addAll: TREvent withAllSubclasses.

	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft09DepAnalysisWithCurved [
	"
	self new vissoft09DepAnalysisWithCurved
	"

	| b |
	b := RTGraphBuilder new.
	b nodes
		if: [ :c | c inheritsFrom: RTShape ];
		color: Color green.
	b nodes
		if: [ :c | c inheritsFrom: RTLayout ];
		color: Color yellow.

	b nodes
		if: [ :c | 'TR*' match: c name ];
		color: Color purple.

	b nodes
		color: Color red.
		
		
	b edges
		connectTo: #subclasses;
		useInLayout.
	b edges
		connectTo: #dependentClasses;
		follow: #superclass;
		if: [ :f :t | ('TR*' match: t name )and: [ 'RT*' match: f name ] ];
		color: (Color blue alpha: 0.4).

	b layout cluster.

	b global
		alphaColor: 0.4;
		normalizeSize: #numberOfMethods min: 5 max: 60.

	b addAll: RTObject withAllSubclasses.
	b addAll: TRObject withAllSubclasses.
	b addAll: TREvent withAllSubclasses.

	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft11DependencyGraph [
	"
	self new vissoft11DependencyGraph
	"

|b |

b := RTGraphBuilder new.

b nodes
	if: [ :c | c inheritsFrom: RTLayout ];
	color: Color red;
	whenOverHighlight: #dependentClasses.

b nodes
	if: [ :c | c inheritsFrom: RTShape ];
	color: Color green;
	whenOverHighlight: #dependentClasses.
	
b nodes
	if: [ :c | c inheritsFrom: RTBuilder ];
	color: Color blue;
	whenOverHighlight: #dependentClasses.

b edges
	shape: RTDirectedLine new;
	connectTo: #dependentClasses.

b layout force charge: -100.

b global 
		alphaColor: 0.4;
		normalizeSize: #numberOfMethods min: 15 max: 30.

b addAll: RTObject withAllSubclasses.

b open
]
