Class {
	#name : #RTGraphBuilderExamples,
	#superclass : #Object,
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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
		if: [ :cls | cls numberOfMethods >= 15 ] connectedTo: [ :c | c subclasses ].

	b layout 
		for: [ :cls | cls numberOfMethods >= 15 ] use: (RTTreeLayout new);
		for: [ :cls | cls numberOfMethods < 15 ] use: (RTGridLayout new).
	b addAll: (RTShape withAllSubclasses).
	b open
]

{ #category : #'as yet unclassified' }
RTGraphBuilderExamples >> vissoft01 [
	"
	self new vissoft01
	"

	| b |
	b := RTGraphBuilder new.
	b node
		if: [ :obj | obj isBehavior ] shape: (RTEllipse new size: [ :c | 5 max: c numberOfMethods ]; color: (Color blue alpha: 0.3)).

	b edge
		if: [ :obj | obj isBehavior ] connectedTo: [ :c | c subclasses ].

	b layout 
		for: [ :cls | cls isBehavior ] use: (RTForceBasedLayout new).
		
	b addAll: (RTShape withAllSubclasses).
	b open
]
