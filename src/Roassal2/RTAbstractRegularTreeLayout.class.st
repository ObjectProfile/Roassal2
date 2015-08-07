"
A ROAbstractRegularTreeLayout is xxxxxxxxx.

Instance Variables
	alreadyLayoutedNodes:		<Object>
	isLayered:		<Object>
	leftGap:		<Object>
	nodesByLayer:		<Object>
	topGap:		<Object>

alreadyLayoutedNodes
	- xxxxx

isLayered
	- xxxxx

leftGap
	- xxxxx

nodesByLayer
	- xxxxx

topGap
	- xxxxx

"
Class {
	#name : #RTAbstractRegularTreeLayout,
	#superclass : #RTAbstractGraphLayout,
	#instVars : [
		'alreadyLayoutedNodes',
		'topGap',
		'leftGap',
		'nodesByLayer',
		'isLayered'
	],
	#category : #'Roassal2-Layouts'
}

{ #category : #testing }
RTAbstractRegularTreeLayout class >> isAbstract [
	^ self = RTAbstractRegularTreeLayout
]

{ #category : #private }
RTAbstractRegularTreeLayout >> atLayer: aNumber add: aNodeCollection [
	| collection |
	collection := nodesByLayer at: aNumber ifAbsentPut: [OrderedCollection new].
	collection addAll: aNodeCollection
]

{ #category : #hook }
RTAbstractRegularTreeLayout >> doExecute: elements [
	| rootNodes |
	alreadyLayoutedNodes := OrderedCollection new.
	rootNodes := self rootNodesFor: elements.
	nodesByLayer := OrderedCollection new.
	self
		layout: rootNodes
		atPoint: self leftGap @ self topGap
		atLayer: 1.
	self isLayered ifTrue: [
		self rearrangeByLayers: elements ]
]

{ #category : #'initialize-release' }
RTAbstractRegularTreeLayout >> initialize [
	super initialize.
	topGap := 5.
	leftGap := 5.
	isLayered := false.
	self doAttachPoint
]

{ #category : #accessing }
RTAbstractRegularTreeLayout >> isLayered [
	"Is the layout layered"
	
	^ isLayered
]

{ #category : #accessing }
RTAbstractRegularTreeLayout >> isLayered: boolean [
	"Is the layout layered"
	
	isLayered := boolean
]

{ #category : #accessing }
RTAbstractRegularTreeLayout >> layered [
	self isLayered: true
]

{ #category : #'hook-private' }
RTAbstractRegularTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: anObject [
	self subclassResponsibility
]

{ #category : #accessing }
RTAbstractRegularTreeLayout >> leftGap [
	^ leftGap
]

{ #category : #accessing }
RTAbstractRegularTreeLayout >> leftGap: anInteger [
	leftGap := anInteger
]

{ #category : #private }
RTAbstractRegularTreeLayout >> rearrangeByLayers: aGraph [
	self subclassResponsibility
]

{ #category : #accessing }
RTAbstractRegularTreeLayout >> topGap [
	^ topGap
]

{ #category : #accessing }
RTAbstractRegularTreeLayout >> topGap: anInteger [
	topGap := anInteger
]
