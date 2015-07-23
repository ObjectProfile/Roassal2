"
A ROEdgeDrivenLayout is xxxxxxxxx.

Instance Variables
	edges:		<Object>
	fromPositions:		<Object>
	toPositions:		<Object>
	userDefinedEdges:		<Object>

edges
	- xxxxx

fromPositions
	- xxxxx

toPositions
	- xxxxx

userDefinedEdges
	- xxxxx

"
Class {
	#name : #RTEdgeDrivenLayout,
	#superclass : #RTLayout,
	#instVars : [
		'edges',
		'userDefinedEdges',
		'fromPositions',
		'toPositions'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #'as yet unclassified' }
RTEdgeDrivenLayout class >> isAbstract [
	^ self = RTEdgeDrivenLayout
]

{ #category : #public }
RTEdgeDrivenLayout class >> on: elements edges: edges [
	^ self new on: elements edges: edges
]

{ #category : #'instance creation' }
RTEdgeDrivenLayout class >> withEdges: aCollection [
	
	^self new initialize userDefinedEdges: aCollection
]

{ #category : #accessing }
RTEdgeDrivenLayout >> affectedNodes [
	
	^affectedNodes
]

{ #category : #accessing }
RTEdgeDrivenLayout >> affectedNodes: anObject [
	
	affectedNodes := anObject
]

{ #category : #accessing }
RTEdgeDrivenLayout >> affectedNodesOf:  aNode [ 
	^ affectedNodes ifNil: [ aNode nodes ]
]

{ #category : #'default values' }
RTEdgeDrivenLayout >> defaultFromPositions [
	^ #()
	
]

{ #category : #'default values' }
RTEdgeDrivenLayout >> defaultToPositions [
	^ #()

]

{ #category : #hook }
RTEdgeDrivenLayout >> doExecute: elements [
	
	self subclassResponsibility
]

{ #category : #hook }
RTEdgeDrivenLayout >> doIncrementallyExecute: anElementNode [
	"called by refreshLayoutEvery: ms. It is used to convey a feeling of incremental execution."
	
	self doExecute: anElementNode
]

{ #category : #private }
RTEdgeDrivenLayout >> edges [
	
	^edges
]

{ #category : #accessing }
RTEdgeDrivenLayout >> edges: aCollection [
	
	edges := aCollection
]

{ #category : #iterator }
RTEdgeDrivenLayout >> edgesDo: aBlock [
	"Iterates over all the edges of the receiver."
	
	edges ifNil: [ ^ self ].
	edges do: aBlock

]

{ #category : #hook }
RTEdgeDrivenLayout >> executeOnElements: elements [ 
	"Execute the layout, myself, on the elements"

	self userDefinedEdges isNil 
		ifTrue: [ self setEdgesFromElements: elements ]
		ifFalse: 
			[ | flat |
			flat := OrderedCollection new.
			self userDefinedEdges do: 
				[ :each | 
				each isCollection 
					ifTrue: [ flat addAll: each ]
					ifFalse: [ flat add: each ] ].
			flat := flat select: #isUsedInLayout. 
			self edges: flat ].
		
	super executeOnElements: elements
]

{ #category : #private }
RTEdgeDrivenLayout >> fromPositions [
	
	^fromPositions ifNil: [fromPositions := self defaultFromPositions]
]

{ #category : #accessing }
RTEdgeDrivenLayout >> fromPositions: anArray [
	
	fromPositions := anArray
]

{ #category : #'initialize-release' }
RTEdgeDrivenLayout >> initialize [
	"Initialization"
	super initialize.
	edges := nil
]

{ #category : #testing }
RTEdgeDrivenLayout >> isLineLayout [
	^ false
]

{ #category : #accessing }
RTEdgeDrivenLayout >> setEdgesFromElements: elements [ 
	| view |
	elements isEmpty ifTrue: [ ^ self ].
	
	view := elements anyOne view.
	view ifNil: [ ^ self ].
	self edges: (view edges select: [ :el | 
		(el isUsedInLayout and: [ elements includes: el from ]) and: [ elements includes: el to ] ]).
	
]

{ #category : #private }
RTEdgeDrivenLayout >> toPositions [
	
	^toPositions ifNil: [toPositions := self defaultToPositions]
]

{ #category : #accessing }
RTEdgeDrivenLayout >> toPositions: anArray [
	
	toPositions := anArray
]

{ #category : #private }
RTEdgeDrivenLayout >> userDefinedEdges [
	
	^userDefinedEdges
]

{ #category : #'initialize-release' }
RTEdgeDrivenLayout >> userDefinedEdges: aCollectionOfEdges [
	"useful to tell to the layout which edges have to be used for the layout"

	userDefinedEdges := aCollectionOfEdges.
	
]
