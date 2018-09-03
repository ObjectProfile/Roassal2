Class {
	#name : #GTAActivityBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'events',
		'elements',
		'eventAnalyzer',
		'eventFilter',
		'analyze',
		'edges',
		'edgeShapeBuilder',
		'withEdges'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity'
}

{ #category : #api }
GTAActivityBuilder class >> viewOn: objects [
	| instance |
	instance := self new.
	instance
		events: objects;
		withEdges.
	instance interaction
		popupText: #asEventAnalysisString;
		draggable.
	^ instance
		build;
		view
]

{ #category : #adding }
GTAActivityBuilder >> addEdges [
	self edges ifNotEmpty: [ ^ self ].
	self buildEdges.
]

{ #category : #configuration }
GTAActivityBuilder >> analyze [
	analyze := true
]

{ #category : #private }
GTAActivityBuilder >> analyzeEvents [
	self eventAnalyzer analyze: self events
]

{ #category : #private }
GTAActivityBuilder >> analyzeEventsIfRequested [
	analyze ifTrue: [ self analyzeEvents ]
]

{ #category : #private }
GTAActivityBuilder >> buildEdges [
	| size |
	size := self elements size.
	size < 2
		ifTrue: [ ^ #() ].
	self elements
		withIndexDo: [ :element :index | 
			index < size
				ifTrue: [ self edgeFrom: element to: (self elements at: index + 1) ] ].
	^ self edges
]

{ #category : #private }
GTAActivityBuilder >> buildEdgesIfRequested [
	withEdges
		ifFalse: [ ^ #() ].
	^ self buildEdges
]

{ #category : #private }
GTAActivityBuilder >> buildElements [
	| visibleEvents |
	visibleEvents := self visibleEvents.
	elements := self elementsWithInteractionOn: visibleEvents.

]

{ #category : #accessing }
GTAActivityBuilder >> configuration: aGTADefaultTimelineConfiguration [ 
	aGTADefaultTimelineConfiguration configure: self
]

{ #category : #hooks }
GTAActivityBuilder >> createShapeBuilder [
	^ super createShapeBuilder event; yourself
]

{ #category : #hooks }
GTAActivityBuilder >> createView [
	^ super createView @ RTDraggableView @ RTZoomableView.
]

{ #category : #public }
GTAActivityBuilder >> edgeFrom: source to: target [ 
	"source and target are elements"
	| newEdge |
	newEdge := self edgeShapeBuilder edgeFrom: source to: target.
	view add: newEdge.
	edges add: newEdge.
	^ newEdge
]

{ #category : #accessing }
GTAActivityBuilder >> edgeShapeBuilder [
	^ edgeShapeBuilder ifNil: [ edgeShapeBuilder := self newEdgeShapeBuilder ]
]

{ #category : #accessing }
GTAActivityBuilder >> edges [
	^ edges
]

{ #category : #accessing }
GTAActivityBuilder >> elements [
	elements ifNil: [ self buildElements ].
	^ elements
]

{ #category : #accessing }
GTAActivityBuilder >> eventAnalyzer [
	^ eventAnalyzer ifNil: [ eventAnalyzer := self newEventAnalyzer ]
]

{ #category : #accessing }
GTAActivityBuilder >> eventFilter [
	^ eventFilter ifNil: [ eventFilter := self newEventFilter ]
]

{ #category : #accessing }
GTAActivityBuilder >> events [
	^ events
]

{ #category : #accessing }
GTAActivityBuilder >> events: aCollection [ 
	events := aCollection
]

{ #category : #initialization }
GTAActivityBuilder >> initialize [
	super initialize.
	edges := OrderedCollection new.
	analyze := false.
	withEdges := false.
]

{ #category : #testing }
GTAActivityBuilder >> isWithEdges [
	^ withEdges 
]

{ #category : #accessing }
GTAActivityBuilder >> layout [
	^ layoutBuilder ifNil: [ layoutBuilder := self newLayoutBuilder ]
]

{ #category : #accessing }
GTAActivityBuilder >> layout: aLayout [
	^ layoutBuilder := aLayout
]

{ #category : #private }
GTAActivityBuilder >> layoutElements [
	self layoutElements: self elements
]

{ #category : #private }
GTAActivityBuilder >> layoutElements: aCollection [ 
	self layout on: aCollection 
]

{ #category : #configuration }
GTAActivityBuilder >> logicalLayout [
	^ self layout: GTAHorizontalDivingLineLayout new
]

{ #category : #'instance creation' }
GTAActivityBuilder >> newEdgeShapeBuilder [
	^ self createShapeBuilder
		line;
		horizontalAttachPoint; 
		width: 1;
		yourself
]

{ #category : #'instance creation' }
GTAActivityBuilder >> newEventAnalyzer [
	^ GTASessionAnalysis new
]

{ #category : #'instance creation' }
GTAActivityBuilder >> newEventFilter [
	^ [ :session | session select: #isForTimelineView ]
]

{ #category : #'instance creation' }
GTAActivityBuilder >> newLayoutBuilder [
	^ GTAHorizontalDivingLineLayout new center; gapSize: 0; yourself
]

{ #category : #configuration }
GTAActivityBuilder >> realLayout [
	^ self layout: GTAHorizontalRealTimelineLayout new
]

{ #category : #removing }
GTAActivityBuilder >> removeAllElementsAndEdges [
	self
		removeEdges;
		removeElements
]

{ #category : #removing }
GTAActivityBuilder >> removeEdges [
	self edges ifEmpty: [ ^ self ].
	"view removeEdges: self edges."
	self edges do: #remove.
	edges := OrderedCollection new.
]

{ #category : #removing }
GTAActivityBuilder >> removeElements [
	elements ifNil: [ ^ self ].
	self elements ifEmpty: [ ^ self ].
	self elements do: #remove.
	elements := nil
]

{ #category : #hooks }
GTAActivityBuilder >> renderIn: aView [
	self removeAllElementsAndEdges.
	self analyzeEventsIfRequested.
	aView addAll: self elements.
	self buildEdgesIfRequested.
	self layoutElements.
]

{ #category : #signalling }
GTAActivityBuilder >> signalUpdate [
	view signalUpdate 
]

{ #category : #layout }
GTAActivityBuilder >> smoothLayoutTranslator [
	self layout translator: (RTSmoothLayoutTranslator new nbCycles: 1).
]

{ #category : #enumerating }
GTAActivityBuilder >> visibleEvents [
	^ self eventFilter cull: self events cull: self
]

{ #category : #configuration }
GTAActivityBuilder >> withEdges [
	withEdges := true
]

{ #category : #accessing }
GTAActivityBuilder >> withEdges: aBoolean [ 
	withEdges := aBoolean
]

{ #category : #configuration }
GTAActivityBuilder >> withoutEdges [
	withEdges := false
]
