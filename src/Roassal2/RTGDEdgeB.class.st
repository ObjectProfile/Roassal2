Class {
	#name : #RTGDEdgeB,
	#superclass : #RTGDShapedElementB,
	#instVars : [
		'usedInLayout',
		'connectTo',
		'edgesUsedForLayout',
		'attachPoint'
	],
	#category : #'Roassal2-Builder-Graph'
}

{ #category : #'as yet unclassified' }
RTGDEdgeB >> bundleConnectTo: aBlock [
	| oldColor |
	oldColor := shape color.
	shape := RTBezierLine new.
	shape color: oldColor.
	shape midPointInCenterOfElements: [ :edge | self view elementsFromModels: (aBlock rtValue: edge from model) ].
	self connectTo: aBlock.

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
RTGDEdgeB >> connectTo: aOneArgBlock [

	connectTo := aOneArgBlock
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> createEdgesFor: object [
	| answer el toObjects |
	answer := OrderedCollection new.
	el := self elementFromModel: object.

	attachPoint ifNotNil: [ shape attachPoint: attachPoint ].

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
RTGDEdgeB >> horizontalAttachPoint [
	attachPoint := RTHorizontalAttachPoint new.
]

{ #category : #'as yet unclassified' }
RTGDEdgeB >> initialize [
	super initialize.
	usedInLayout := false.
	connectTo := #yourself.
	edgesUsedForLayout := OrderedCollection new.
	self shape: RTLine new
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
