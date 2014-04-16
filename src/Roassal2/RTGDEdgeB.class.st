Class {
	#name : #RTGDEdgeB,
	#superclass : #RTGDShapedElementB,
	#instVars : [
		'usedInLayout',
		'connectTo',
		'edgesUsedForLayout'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDEdgeB >> bundleConnectTo: aBlock [

]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> connectTo: aOneArgBlock [

	connectTo := aOneArgBlock
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> createEdgesFor: object [
	| answer el toObjects |
	answer := OrderedCollection new.
	el := self elementFromModel: object.

	toObjects := connectTo rtValue: object.
	toObjects isCollection ifFalse: [ toObjects := Array with: toObjects ]. 
	answer addAll: (shape edgesFrom: el toAll: (self elementsFromModels: toObjects)).
	
	usedInLayout ifTrue: [ edgesUsedForLayout addAll: answer ].
	^ answer
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> edgesUsedForLayout [
	^ edgesUsedForLayout
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> initialize [
	super initialize.
	usedInLayout := false.
	connectTo := #yourself.
	edgesUsedForLayout := OrderedCollection new.
	self shape: RTLine
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> useInLayout [
	^ usedInLayout := true
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> usedInLayout [
	^ usedInLayout
]
