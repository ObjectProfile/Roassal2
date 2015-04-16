"
A RTMondrian describes Mondrian, a domain-specific language that is adapted to represent polymetric views. More info about polymetric views in ""Michele Lanza and Stéphane Ducasse. Polymetric Views—A Lightweight Visual Approach to Reverse Engineering. In Transactions on Software Engineering (TSE) 29(9) p. 782—795, September 2003.""

RTMondrian maintains a stack of frame, instances of RTMondrianFrame

Instance Variables
	currentFrame:		<RTMondrianFrame>
	edgeBuilder:		<RTEdgeBuilder>
	metricNormalizer:		<RTMetricNormalizer>
	rootFrame:		<RTMondrianFrame>

currentFrame
	- xxxxx

edgeBuilder
	- xxxxx

metricNormalizer
	- xxxxx

rootFrame
	- xxxxx

"
Class {
	#name : #RTMondrian,
	#superclass : #RTBuilder,
	#instVars : [
		'currentFrame',
		'edgeBuilder',
		'rootFrame'
	],
	#category : #'Roassal2-Builder-Mondrian'
}

{ #category : #public }
RTMondrian >> applyLayout [
	layoutBuilder setUpElements: self topElements
]

{ #category : #benchmarking }
RTMondrian >> benchmark [

"

[ 100 timesRepeat: [| b | b := RTMondrianViewBuilder new.
b shape rectangle
	width: [ :c | c numberOfVariables * 4];
	height: #numberOfMethods;
	linearFillColor: #numberOfLinesOfCode within: RTShape withAllSubclasses.
b nodes: RTShape withAllSubclasses.
b edgesFrom: #superclass.
b treeLayout.
b build] ] timeToRun

 0:00:00:00.393"

"
[ 100 timesRepeat: [|b| b := RTMondrian new.
b shape rectangle
	width: [ :c | c numberOfVariables * 4];
	height: #numberOfMethods;
	linearFillColor: #numberOfLinesOfCode within: RTShape withAllSubclasses.
b nodes: RTShape withAllSubclasses.
b edges connectFrom: #superclass.
b layout tree.
b build ] ] timeToRun
 0:00:00:00.393"
]

{ #category : #benchmarking }
RTMondrian >> benchmark02 [

"

[ 100 timesRepeat: [| b | b := RTMondrianViewBuilder new.
b nodes: RTShape withAllSubclasses forEach: [ :c | b nodes: c methods ].
b edgesFrom: #superclass.
b treeLayout.
b build] ] timeToRun

 0:00:00:02.804"

"
[ 100 timesRepeat: [|b| b := RTMondrian new.
b nodes: RTShape withAllSubclasses forEach: [ :c | b nodes: c methods ].
b edges connectFrom: #superclass.
b layout tree.
b build ] ] timeToRun
 0:00:00:01.414"
]

{ #category : #public }
RTMondrian >> build [
	super build.
	self applyLayout 
]

{ #category : #'deprecated - compatibility layer' }
RTMondrian >> circleLayout [
	^ self layout circle
]

{ #category : #hooks }
RTMondrian >> createInteractionBuilder [
	^ RTInteractionBuilder new popup; draggable; yourself
]

{ #category : #factories }
RTMondrian >> createLayoutBuilder [
	| newLayoutBuilder |
	newLayoutBuilder := RTLayoutBuilder new.
	newLayoutBuilder horizontalLine.
	^ newLayoutBuilder
]

{ #category : #factories }
RTMondrian >> createNewFrame [
	^ RTMondrianFrame new
]

{ #category : #hooks }
RTMondrian >> createShapeBuilder [
	| sb |
	sb := RTBoundedShapeBuilder new.
	sb shapeInitializer: [ :aShape | sb color: (Color gray: (5 - ((self currentDepth + 1 min: 5)) / 5.0) asFloat) ].

"	sb rectangle color: (Color gray: (5 - ((self currentDepth + 1 min: 5)) / 5.0) asFloat)."
	"sb rectangle color: Color white; borderColor: Color black."
	^ sb
	
]

{ #category : #hooks }
RTMondrian >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #accessing }
RTMondrian >> currentDepth [
	^ self currentFrame depth
]

{ #category : #accessing }
RTMondrian >> currentElements [
	^ self currentFrame elements
]

{ #category : #accessing }
RTMondrian >> currentFrame [
	^ currentFrame
]

{ #category : #accessing }
RTMondrian >> edges [
	edgeBuilder 
		elements: self currentElements; 
		view: view;
		shapeBuilder: shapeBuilder.
	^ edgeBuilder
]

{ #category : #'deprecated - compatibility layer' }
RTMondrian >> edges: objects from: fromBlock to: toBlock [
	^ self edges
			objects: objects from: fromBlock to: toBlock
		
]

{ #category : #'deprecated - compatibility layer' }
RTMondrian >> edgesFrom: aBlock [
	^ self edges connectFrom: aBlock
]

{ #category : #initialization }
RTMondrian >> initialize [
	rootFrame := self createNewFrame.
	currentFrame := rootFrame.
	super initialize.
	self resetLayoutBuilder.
	edgeBuilder := RTEdgeBuilder new
]

{ #category : #accessing }
RTMondrian >> layout [
	^ layoutBuilder 
]

{ #category : #'public - nodes' }
RTMondrian >> node: anObject [
	"Add a new node to the view"
	^ (self nodes: (Array with: anObject)) first
]

{ #category : #'public - nodes' }
RTMondrian >> node: anObject forIt: aBlock [
	^ (self nodes: (Array with: anObject) forEach: [ :each | aBlock value ]) first
]

{ #category : #'public - nodes' }
RTMondrian >> nodes: objects [
	| els |
	els := self elementsOn: objects.
	self currentFrame addElements: els.
	view addAll: els.
	self resetShapeBuilder.
	self resetLayoutBuilder.
	^ els
]

{ #category : #'public - nodes' }
RTMondrian >> nodes: objects forEach: aOneArgBlock [
	| result |
	result := self nodes: objects.
	
	result do: [ :element | 
		self pushNewFrame.
		self resetShapeBuilder.
		self resetLayoutBuilder.
			
		aOneArgBlock rtValue: element model.
		RTNest new
			layout: layoutBuilder layout;
			on: element nest: self currentFrame elements.
		self popFrame.
	].
	self resetShapeBuilder.
	self resetLayoutBuilder.
	^ result
]

{ #category : #stack }
RTMondrian >> numberOfAllFrames [
	"Return the number of all the frame accessible within the builder"
	^ rootFrame numberOfAllFrames
]

{ #category : #stack }
RTMondrian >> popFrame [
	currentFrame := currentFrame parentFrame
]

{ #category : #stack }
RTMondrian >> pushFrame: aFrame [
	currentFrame pushFrame: aFrame.
	currentFrame := aFrame.
	^ aFrame
]

{ #category : #stack }
RTMondrian >> pushNewFrame [
	^ self pushFrame: self createNewFrame
]

{ #category : #initialization }
RTMondrian >> resetLayoutBuilder [
	layoutBuilder := self createLayoutBuilder
]

{ #category : #initialization }
RTMondrian >> resetShapeBuilder [
	shapeBuilder := self createShapeBuilder
]

{ #category : #accessing }
RTMondrian >> rootFrame [
	^ rootFrame
]

{ #category : #stack }
RTMondrian >> topElements [
	^ rootFrame elements
]

{ #category : #'deprecated - compatibility layer' }
RTMondrian >> treeLayout [
	^ self layout tree
]
