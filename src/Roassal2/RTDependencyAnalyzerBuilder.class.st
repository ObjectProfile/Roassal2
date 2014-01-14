Class {
	#name : #RTDependencyAnalyzerBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'classesToAnalyze'
	],
	#category : #'Roassal2-Builder-DependencyAnalyzer'
}

{ #category : #'as yet unclassified' }
RTDependencyAnalyzerBuilder >> addClasses: classes [
	classesToAnalyze addAll: classes
]

{ #category : #'as yet unclassified' }
RTDependencyAnalyzerBuilder >> initialize [
	super initialize.
	classesToAnalyze := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
RTDependencyAnalyzerBuilder >> renderIn: v [
	"v is a Roassal view"

| classes hierarchicalLinks depLinks dep |
"classes := (RTEllipse new color: Color purple; size: 10) elementsOn: classesToAnalyze."
classes := self elementsOn: classesToAnalyze.

classes @ RTDraggable @ RTPopup.
classes on: TRMouseEnter do: [ :evt | RTBlink outgoingEdgesOf: evt element ].

v addAll: classes.
hierarchicalLinks := RTEdge 
	buildEdgesFromObjects: classesToAnalyze 
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

]
