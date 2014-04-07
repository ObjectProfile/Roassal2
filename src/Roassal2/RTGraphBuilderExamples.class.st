Class {
	#name : #RTGraphBuilderExamples,
	#superclass : #Object,
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #examples }
RTGraphBuilderExamples >> simple01 [
	"
	self new simple01
	"

	| b |
	b := RTGraphBuilder new.
	b node
		if: [ :obj | obj < 15 ] shape: (RTEllipse new size: 20; color: Color blue);
		if: [ :obj | obj >= 15 ] shape: (RTEllipse new size: 10; color: Color red).
	b layout 
		for: [ :obj | obj < 15 ] use: (RTCircleLayout new);
		for: [ :obj | obj >= 15 ] use: (RTGridLayout new).
	b addAll: (1 to: 20).
	b open
]

{ #category : #examples }
RTGraphBuilderExamples >> simple02 [
	"
	self new simple02
	"

	| b |
	b := RTGraphBuilder new.
	b node
		if: [ :cls | cls numberOfMethods < 15 ] shape: (RTEllipse new size: 20; color: Color blue);
		if: [ :cls | cls numberOfMethods >= 15 ] shape: (RTEllipse new size: 40; color: Color red).

	b edge
		if: [ :cls | cls numberOfMethods >= 15 ] connectTo: [ :c | c subclasses ].

	b layout 
		for: [ :cls | cls numberOfMethods >= 15 ] use: (RTTreeLayout new);
		for: [ :cls | cls numberOfMethods < 15 ] use: (RTGridLayout new).
	b addAll: (RTShape withAllSubclasses).
	b open
]

{ #category : #examples }
RTGraphBuilderExamples >> simple03 [
	"
	self new simple03
	"

	| b |
	b := RTGraphBuilder new.
	b node
		if: true shape: (RTEllipse new size: 30).

	b global
		for: true normalizeColor: #yourself using: (Array with: Color green with: Color red).

	b layout use: RTGridLayout new.
	b addAll: (1 to: 20).
	b open
]

{ #category : #examples }
RTGraphBuilderExamples >> simple04 [
	"
	self new simple04
	"

	| b |
	b := RTGraphBuilder new.

	b node shape: RTEllipse new.

	b layout use: (RTFlowLayout new maxWidth: 500).

	b global 
		normalizeSize: #numberOfMethods min: 5 max: 90.
		 

	b addAll: (Collection withAllSubclasses).

	b open
]

{ #category : #examples }
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

{ #category : #examples }
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

{ #category : #examples }
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

{ #category : #examples }
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

{ #category : #examples }
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

{ #category : #examples }
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

{ #category : #examples }
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
		use: (RTForceBasedLayout new).

	b global
		minSize: 10;
		normalizeColor: [ :cls | cls methods size ] using: (Array with: Color green with: Color red).

	b addAll: (RTObject withAllSubclasses).
	b open
]
