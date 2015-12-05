"
I am a experimental class to have a sankey visualization
more info in this link
http://en.wikipedia.org/wiki/Sankey_diagram
"
Class {
	#name : #RTSankeyBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'extent',
		'nodePadding',
		'nodes',
		'links',
		'iterations',
		'elements',
		'linkFrom',
		'linkTo',
		'linkValue'
	],
	#category : #'Roassal2-Experimental'
}

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> computeEdgeValues [
	elements do: [ :el | | slinks tlinks sum |
		slinks := el connectedEdges select: [:ed | ed from = el].
		tlinks := el connectedEdges select: [:ed | ed to = el].
		sum := [ :arr | arr inject: 0 into: [ :s :each| 
			(each attributes at: #value) + s ] ].
		
		el attributes 
			at: #sourceLinks put: slinks;
			at: #targetLinks put: tlinks;
			at: #value put: ((sum value: slinks) max: (sum value: tlinks)).
		 ]
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> computeElementBreadths [
	"Iterative assig the breadth (x-position) for each node"
	| remainingElements nextElements x kx |
	x := 0.
	remainingElements := elements.
	[remainingElements size isZero not] whileTrue: [ 
		nextElements := OrderedCollection new.
		remainingElements do: [ :el| 
			el attributes at: #x put: x.
			(el attributes at: #sourceLinks) do: [:ed |
				nextElements add: ed to. ] ].
		remainingElements := nextElements.
		x := x+1.
	 ].
	"move sinks right and scale"
	kx := extent x/ (x -1).
	elements do:[ :el| | temp |
		(el attributes at: #sourceLinks) size isZero ifTrue: [ 
			el attributes at: #x put: x -1 ].
		temp := el attributes at: #x.
		el attributes at: #x put: (temp * kx) asFloat.
		 ].
	
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> computeElementDepths: edges [
	| elementsByBreadth ky value alpha |
	elementsByBreadth := elements groupedBy: [ :e | e attributes at: #x ].
	elementsByBreadth := elementsByBreadth keysSortedSafely 
		collect: [:k | elementsByBreadth at: k ].
	value := [ :e | e attributes at: #value ].
	ky := elementsByBreadth inject: Float fmax into: [ :min :arr|
		min min: ((extent y - ((arr size - 1) * nodePadding ))/ 
		(arr inject: 0 into: [ :sum :e| (value value: e)+ sum])) ].
	elementsByBreadth do: [ :arr| 
		arr doWithIndex: [ :e :i| 
			e attributes 
				at: #y put: i;
				at: #dy put: (value value: e)*ky ].
		].
	edges do: [ :e | e attributes at: #value put: (value value: e)*ky ].
	self resolveCollisions: elementsByBreadth.
	alpha := 1.
	1 to: iterations do: [ :i |
		alpha := alpha *0.99. 
		self relaxRightToLeft: alpha.
		self resolveCollisions: elementsByBreadth.
		self relaxLeftToRight: alpha.
		self resolveCollisions: elementsByBreadth.].
	
	
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> computeElements: edges [
	self computeEdgeValues.
	self computeElementBreadths.
	self computeElementDepths: edges.
	self computeLinkDepths.
	
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> example [
	"| data sankey nodeAt |
data := ZnClient new 
	url: 'http://bost.ocks.org/mike/sankey/energy.json';
	contentReader: [ :entity | NeoJSONReader fromString: entity contents ];
	get.

nodeAt := [ :v | (data at: 'nodes') at: v + 1 ].
sankey := RTSankeyBuilder new.
sankey shape width: 15.
sankey extent: 960@500;
	nodePadding: 10;
	nodes: (data at: 'nodes');
	links: (data at: 'links');
	linkFrom: [:link | nodeAt value: (link at: 'source') ];
	linkTo: [ :link | nodeAt value: (link at: 'target') ];
	linkValue: [ :link | link at: 'value' ];
	iterations: 32.
sankey build.
^ sankey view."
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> extent: aPoint [
	extent := aPoint
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> initialize [
	super initialize.
	self shape rectangle width: 10.
	self extent: 400@300.
	self nodePadding: 0.
	self linkFrom: #key.
	self linkTo: #value.
	self linkValue: #yourself.
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> iterations: aNumber [
	iterations := aNumber
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> linkFrom: aBlock [
	linkFrom := aBlock
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> linkTo: aBlock [
	linkTo := aBlock
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> linkValue: aBlock [
	linkValue := aBlock
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> links: aCollection [
	links := aCollection
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> nodePadding: aNumber [
	nodePadding := aNumber
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> nodes: aCollection [
	nodes := aCollection
]

{ #category : #'as yet unclassified' }
RTSankeyBuilder >> renderIn: aView [
	| edges |
	elements := self shape elementsOn: nodes.
	self interaction setUpElements: elements.
	aView addAll: elements.
	edges := RTEdgeBuilder new
		view: aView;
		elements: elements;
		objects: links;
		connectFrom: linkFrom to: linkTo.
	edges doWithIndex: [:e :i| 
		e attributes at: #value put: (linkValue rtValue: (links at:i) ) ].
	
	self computeElements: edges.
]
