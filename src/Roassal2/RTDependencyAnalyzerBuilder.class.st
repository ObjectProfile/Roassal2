Class {
	#name : #RTDependencyAnalyzerBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'classesToAnalyze',
		'dependencies'
	],
	#category : #'Roassal2-Builder-DependencyAnalyzer'
}

{ #category : #public }
RTDependencyAnalyzerBuilder >> addClasses: classes [
	classesToAnalyze addAll: classes
]

{ #category : #public }
RTDependencyAnalyzerBuilder >> dependencyFromAllClassesMatching: blockFrom toAllClassesMatching: blockTo [

	| fromClasses toClasses |
	fromClasses := classesToAnalyze select: blockFrom.
	toClasses := classesToAnalyze select: blockTo.

	fromClasses do: [ :cls |
		cls methods do: [ :cm | 
			((cm literals select: [ :l | l class  == Association and: [ l value notNil ] ]) collect: #value) do: [ :depClass | (cls ~~ depClass) ifTrue: [ 
					(toClasses includes: depClass) ifTrue: [ dependencies add: cls -> depClass ] ] ] ]
	].
]

{ #category : #initialization }
RTDependencyAnalyzerBuilder >> initialize [
	super initialize.
	classesToAnalyze := OrderedCollection new.
	dependencies := OrderedCollection new.
]

{ #category : #hooks }
RTDependencyAnalyzerBuilder >> renderIn: v [
	"v is a Roassal view"

	| classes hierarchicalLinks depLinks |
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

	"Add dependency edges"
	depLinks := RTEdge 
		buildEdgesFromObjects: dependencies
		from: #key 
		to: #value 
		using: (RTBezierLine new 
						color: (Color blue alpha: 0.2);
						follow: #superclass) inView: v.


	"Move the edges at the back"
	depLinks do: [ :e | e trachelShape pushBack ].
	hierarchicalLinks do: [ :e | e trachelShape pushBack ].

]
