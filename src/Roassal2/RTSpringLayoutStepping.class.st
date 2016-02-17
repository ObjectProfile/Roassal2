"
Allow 

[ [ [ 
| v elements s |
v := RTView new.
v @ RTDraggableView.
elements := (RTEllipse new size: 20; color: (Color blue alpha: 0.3)) elementsOn: (1 to: 100).
v addAll: elements.
elements @ RTDraggable.

s := RTSpringLayoutStepping new view: v.
v addAnimation: s.
v
 ] ] ]

Another example using edges:
[ [ [ 
	| v classes edges |
	v := RTView new.
	classes := (RTEllipse new
		color: (Color purple alpha: 0.3);
		size: 10) elementsOn: Collection withAllSubclasses.
	(classes elementFromModel: Collection) trachelShape color: Color red.
	classes @ RTDraggable.
	v addAll: classes.
	edges := RTEdgeBuilder new
		view: v;
		objects: Collection withAllSubclasses;
		shape: (RTLine new color: (Color purple alpha: 0.2));
		connectFrom: #superclass to: #yourself.
	edges do: [ :e | e trachelShape pushBack ].

	""RTForceBasedLayout on: v elements edges: v edges.""
	v addAnimation: (RTSpringLayoutStepping new view: v).
	v @ RTDraggableView.
	v
 ] ] ]
"
Class {
	#name : #RTSpringLayoutStepping,
	#superclass : #RTAnimation,
	#instVars : [
		'view',
		'layout',
		'afterBlock'
	],
	#category : #'Roassal2-Animation'
}

{ #category : #updating }
RTSpringLayoutStepping >> addEdge: anEdge [
	layout addEdge: anEdge
]

{ #category : #updating }
RTSpringLayoutStepping >> addEdges: someEdges [
	layout addEdges: someEdges

]

{ #category : #updating }
RTSpringLayoutStepping >> addNode: anElement [
	"Designate the collection of elements that have to be layouted"
	layout 
		addNodes: (Array with: anElement)
]

{ #category : #updating }
RTSpringLayoutStepping >> addNodes: someElements [
	"Designate the collection of elements that have to be layouted"
	layout 
		addNodes: someElements
]

{ #category : #'public-configuration' }
RTSpringLayoutStepping >> addStartStopButton [

	view canvas addMenu: 'Toggle Animation' callback: [
		(view canvas hasAnimation: self)
			ifTrue: [ view canvas removeAnimation: self ]
			ifFalse: [ view canvas addAnimation: self ] ]
]

{ #category : #accessing }
RTSpringLayoutStepping >> afterBlock: aBlock [
	"Set a block to be evaluated at each refresh"
	"Block could be [ view canvas camera focusOnCenter ]"
	afterBlock := aBlock
]

{ #category : #testing }
RTSpringLayoutStepping >> hasCompleted [
	^ false
]

{ #category : #initialization }
RTSpringLayoutStepping >> initialize [
	super initialize.
	layout := RTForceBasedLayout new.
	afterBlock := [ ]
]

{ #category : #accessing }
RTSpringLayoutStepping >> layout [
	^ layout
]

{ #category : #accessing }
RTSpringLayoutStepping >> layout: aForceBasedLayout [
	"Set an instance of the class RTForceBasedLayout. 
	This is useful in case the layout is initialized from outside"
	layout := aForceBasedLayout.
	view ifNotNil: 
		[ self prepareLayoutFor: view ]
]

{ #category : #accessing }
RTSpringLayoutStepping >> nodes [
	^ layout nodes
]

{ #category : #accessing }
RTSpringLayoutStepping >> nodes: elements [
	"Designate the collection of elements that have to be layouted"
	layout 
		prepareNodes: elements;
		nodes: elements
]

{ #category : #accessing }
RTSpringLayoutStepping >> prepareLayoutFor: aView [
	layout
		nodes: aView elements;
		edges: aView edges;
		start: aView elements
]

{ #category : #refreshing }
RTSpringLayoutStepping >> refresh [
	layout step.
	view ifNotNil: [ view canvas signalUpdate ].
	afterBlock value
]

{ #category : #updating }
RTSpringLayoutStepping >> removeAllEdges [
	layout removeAllEdges
]

{ #category : #actions }
RTSpringLayoutStepping >> start [
	view canvas signalUpdate
]

{ #category : #accessing }
RTSpringLayoutStepping >> view: aView [
	view := aView.
	self prepareLayoutFor: aView
]
