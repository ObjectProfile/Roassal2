Class {
	#name : #RTGDEdgeB,
	#superclass : #RTGDShapedElementB,
	#instVars : [
		'usedInLayout',
		'connectTo',
		'edgesUsedForLayout',
		'attachPoint',
		'connectFrom'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDEdgeB >> bundleConnectTo: aBlock [
	self turnShapeIntoBezier.
	shape midPointInCenterOfElements: [ :edge | self view elementsFromModels: (aBlock rtValue: edge from model) ].
	self connectTo: aBlock
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> canCreateForObject: anObject [
	"Return true or false on whether I can create a Roassal element for the given argument"
	condition isClosure
		ifTrue: [ condition  argumentCount = 1 ifTrue: [ ^ super canCreateForObject: anObject ].
			
				   "The argument is an edge"
				   condition  argumentCount = 2 
						ifTrue: [ ^ condition value: anObject from model value: anObject to mode] ]
		ifFalse: [ ^ super canCreateForObject: anObject ]
		
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> chainedConnectFrom: aBlock [
	self connectFrom: [ :v | 
		self recurFrom: v using: aBlock
		 ]
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> chainedConnectTo: aBlock [
	self connectTo: [ :v | 
		self recurFrom: v using: aBlock
		 ]
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> connectFrom: aOneArgBlock [

	connectFrom := aOneArgBlock
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> connectTo: aOneArgBlock [

	connectTo := aOneArgBlock
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> createEdgesFor: object [
	"This method needs to be cleaned"
	| answer toObjects fromObjects fromElements subToObjects edges |
	answer := OrderedCollection new.

	fromObjects := connectFrom rtValue: object.
	fromObjects isCollection ifFalse: [ fromObjects := Array with: fromObjects ].
	fromElements := fromObjects 
							collect: [ :fromObject | self elementFromModel: fromObject ] 
							thenSelect: #notNil.
	
	fromElements do: [ :fromElement |
		attachPoint ifNotNil: [ shape attachPoint: attachPoint ].
		toObjects := connectTo rtValue: object.
		toObjects isCollection ifFalse: [ toObjects := Array with: toObjects ]. 
		
		subToObjects := toObjects select: [ :o | condition value: fromElement model value: o ].
		 
		edges := shape edgesFrom: fromElement toAll: (self elementsFromModels: subToObjects).
		answer addAll: edges.
		
		usedInLayout ifTrue: [ edgesUsedForLayout addAll: answer ] ].
	
	^ answer
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> directed [
	self shape: RTDirectedLine new
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> edgesUsedForLayout [
	^ edgesUsedForLayout
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> follow: aBlock [
	"Turn the shape into a bezier. Make the bezier follow the path specified as the argument"
	self turnShapeIntoBezier.
	shape follow: aBlock.

]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> horizontalAttachPoint [
	attachPoint := RTHorizontalAttachPoint new.
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> initialize [
	super initialize.
	usedInLayout := false.
	connectTo := #yourself.
	connectFrom := #yourself.
	edgesUsedForLayout := OrderedCollection new.
	self shape: RTLine new.
	condition := [ :f :t | true ]
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> recurFrom: v using: aBlock [
	| r |
	r := OrderedCollection new.
	self 
		recurFrom: v 
		using: aBlock 
		path: OrderedCollection new 
		result: r 
		allObjects: (graphBuilder view elements collect: #model).
	^ r
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> recurFrom: v using: aBlock path: path result: result allObjects: allObjects [
	| objects |
	(path includes: v) ifTrue: [ ^ self ].
	path add: v.
	
	"We compute the nexts"
	objects := aBlock rtValue: v.
	
	"If there is no leaf to v, then this is a result"
	objects isCollection ifFalse: [ objects := Array with: objects ].
	objects := objects select: [ :o | allObjects includes: o ].
	objects ifEmpty: [ result add: v. ^ self ].
	
	"If there are leaves, then we recurse"
	objects do: [ :o |
		self 
			recurFrom: o 
			using: aBlock 
			path: path 
			result: result 
			allObjects: allObjects ]
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> turnShapeIntoBezier [
	| oldColor |
	oldColor := shape color.
	shape := RTBezierLine new.
	shape color: oldColor
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> useInLayout [
	^ usedInLayout := true
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> usedInLayout [
	^ usedInLayout
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> verticalAttachPoint [
	attachPoint := RTVerticalAttachPoint new.
]
