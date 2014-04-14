Class {
	#name : #RTGraphBuilderExamples,
	#superclass : #Object,
	#category : #'Roassal2-Builder-Graph'
}

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
	
	g node 
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
	
	g node 
		shape: (RTEllipse new size: 20) + RTLabel;
		whenOverShowEdges: { 2 };
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

	b node shape: (RTEllipse new  size: 30) + RTLabel.

	b edge if: [:v | v = 1 ] bundleConnectTo: [ :v | #(2 3) ].

	b layout use: (RTCircleLayout new).
		 
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

	b edge 
		connectTo: [ :v | v + 1 ];
		if: [:f :t | t = 2 ] color: Color red.
	b layout grid.
	b addAll: #(1 2 3).

	b open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple09HighlightOutgoingEdges [
	"
	self new simple09HighlightOutgoingEdges
	"

	| b |
	b := RTGraphBuilder new.

	b edge 
		connectTo: [ :v | v + 1 ];
		if: [:f :t | t = 2 ] color: Color red.
	b layout grid.
	b addAll: #(1 2 3).

	b open
]

{ #category : #simples }
RTGraphBuilderExamples >> simple10IfColorAndCurvedEdges [
	"
	self new simple10IfColorAndCurvedEdges
	"

	| b |
	b := RTGraphBuilder new.

	b edge 
		 connectTo: [ :v | v + 2 ] follow: [ :v | v + 1 ];
		if: [:f :t | f = 1 ] color: Color red.
	b layout grid.
	b addAll: #(1 2 3).

	b open
]

{ #category : #'software visualization' }
RTGraphBuilderExamples >> vissoft01 [
	"
	self new vissoft01
	"

	| b |
	b := RTGraphBuilder new.
	b node
		if: [ :obj | obj isBehavior ] shape: (RTEllipse new size: [ :c | 5 max: c numberOfMethods ]; color: (Color blue alpha: 0.3)).

	b edge
		if: [ :obj | obj isBehavior ] connectTo: [ :c | c subclasses ].

	b layout 
		for: [ :cls | cls isBehavior ] use: (RTTreeLayout new).
		
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
	b node
		if: [ :obj | obj isBehavior ] shape: (RTEllipse new size: [ :c | 5 max: c numberOfMethods ]).

	b global
		normalizeColor: [ :cls | cls numberOfMethods ] using: (Array with: Color green with: Color red).

	b edge
		if: [ :obj | obj isBehavior ] connectTo: [ :c | c subclasses ] shape: (RTLine new color: Color gray).

	b layout 
		for: [ :cls | cls isBehavior ] use: (RTTreeLayout new).
		
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
	b node
		shape: (RTEllipse new size: #numberOfMethods).

	b edge
		if: [ :obj | obj isBehavior ] connectTo: [ :c | c subclasses ] shape: (RTLine new color: Color gray).

	b layout 
		use: (RTForceBasedLayout new).

	b global
		minSize: 10;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red).

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
	b node
		shape: (RTEllipse new size: #numberOfMethods);
		whenOverShowEdges: [ :cls | cls dependentClasses ].

	b edge
		if: [ :obj | obj isBehavior ] connectTo: [ :c | c subclasses ] shape: (RTLine new color: Color gray).

	b layout 
		use: (RTTreeLayout new).

	b global
		minSize: 10;
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
	b node
		shape: (RTEllipse new size: #numberOfMethods);
		whenOverShowEdges: [ :cls | cls dependentClasses ].

	b edge
		if: [ :obj | obj isBehavior ] connectTo: [ :c | c subclasses ] shape: (RTLine new color: Color gray).

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
	b node
		shape: (RTEllipse new size: #numberOfMethods);
		whenOverShowEdges: [ :cls | cls dependentClasses ].

	b edge
		if: [ :obj | obj isBehavior ] bundleConnectTo: [ :c | c subclasses ].

	b layout 
		use: (RTTreeLayout new ).
		"use: (RTForceBasedLayout new charge: -150)."

	b global
		minSize: 10;
		alphaColor: 0.4;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red).

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
	b node
		shape: (RTEllipse new size: #numberOfMethods);
		whenOverShowEdges: [ :cls | cls dependentClasses ];
		labelled.

	b edge
		if: [ :obj | obj isBehavior ] connectTo: [ :c | c subclasses ] shape: (RTLine new color: Color gray).

	b layout 
		use: (RTForceBasedLayout new charge: -150).

	b global
		minSize: 10;
		alphaColor: 0.4;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red).

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
	b node
		if: [ :c | 'RT*' match: c name ] color: Color red;
		if: [ :c | 'TR*' match: c name ] color: Color purple.
		
	b edge 
		connectTo: #subclasses usedInLayout: true;
		connectTo: #dependentClasses 
			scopedTo: [ :c | 'TR*' match: c name ] 
			color: (Color blue alpha: 0.4) 
			usedInLayout: false.

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
	b node
		if: [ :c | 'RT*' match: c name ] color: Color red;
		if: [ :c | 'TR*' match: c name ] color: Color purple.
		
	b edge 
		connectTo: #subclasses usedInLayout: true;
		connectTo: #dependentClasses 
			scopedTo: [ :c | 'TR*' match: c name ] 
			follow: #superclass
			color: (Color blue alpha: 0.4) 
			usedInLayout: false.

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
RTGraphBuilderExamples >> vissoft10DepAnalysisWithCurved [
	"
	self new vissoft10DepAnalysisWithCurved
	"

	| b |
	b := RTGraphBuilder new.
	b node
		if: [ :c | c inheritsFrom: RTLayout ] color: Color red;
		if: [ :c | c inheritsFrom: TREvent ] color: Color green;
		if: [ :c | c inheritsFrom: RTShape ] color: Color purple.
		
	b edge 
		connectTo: #subclasses usedInLayout: true;
		connectTo: #dependentClasses 
			scopedTo: [ :c | 'TR*' match: c name ] 
			follow: #superclass
			color: (Color blue alpha: 0.4) 
			usedInLayout: false;
		if: [ :f :t | f inheritsFrom: RTShape ] color: Color red.

	b layout cluster.

	b global
		alphaColor: 0.4;
		normalizeSize: #numberOfMethods min: 15 max: 60.

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

b node
	if: [ :c | c inheritsFrom: RTLayout ] shape: (RTEllipse new color: Color red; yourself);
	if: [ :c | c inheritsFrom: RTShape ] shape: (RTEllipse new color: Color green; yourself);
	if: [ :c | c inheritsFrom: RTBuilder ] shape: (RTEllipse new color: Color blue; yourself).

b edge
	connectTo: #dependentClasses.

b layout forceBased charge: -100.

b global 
		alphaColor: 0.4;
		normalizeSize: #numberOfMethods min: 15 max: 30.

b addAll: RTObject withAllSubclasses.

b applyLayout.
b view
]
