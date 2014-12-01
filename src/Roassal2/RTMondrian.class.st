Class {
	#name : #RTMondrian,
	#superclass : #RTBuilder,
	#instVars : [
		'stack',
		'edgeBuilder'
	],
	#category : #'Roassal2-Builder-NewMondrian'
}

{ #category : #'as yet unclassified' }
RTMondrian >> applyLayout [
	layoutBuilder setUpElements: self topElements
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
RTMondrian >> build [
	super build.
	self applyLayout 
]

{ #category : #'as yet unclassified' }
RTMondrian >> createInteractionBuilder [
	^ RTInteractionBuilder new popup; draggable; yourself
]

{ #category : #'as yet unclassified' }
RTMondrian >> createLayoutBuilder [
	| newLayoutBuilder |
	newLayoutBuilder := RTLayoutBuilder new.
	newLayoutBuilder horizontalLine.
	^ newLayoutBuilder
]

{ #category : #'as yet unclassified' }
RTMondrian >> createNewFrame [
	^ RTMondrianFrame new depth: self currentDepth; yourself
]

{ #category : #'as yet unclassified' }
RTMondrian >> createShapeBuilder [
	| sb |
	sb := RTBoundedShapeBuilder new.
	sb rectangle color: (Color gray: ((5 - (self currentDepth min: 5)) / 5.0) asFloat).	"sb rectangle color: Color white; borderColor: Color black."
	^ sb
]

{ #category : #'as yet unclassified' }
RTMondrian >> createView [
	^ super createView @ RTDraggableView
]

{ #category : #'as yet unclassified' }
RTMondrian >> currentDepth [
	self hasAnyFrame ifFalse: [ ^ 1 ].
	^ self topFrame depth
]

{ #category : #'as yet unclassified' }
RTMondrian >> edges [
	edgeBuilder 
		elements: self topElements; 
		view: view;
		shapeBuilder: shapeBuilder.
	^ edgeBuilder
]

{ #category : #'as yet unclassified' }
RTMondrian >> hasAnyFrame [
	^ stack notNil and: [ stack notEmpty ]
]

{ #category : #'as yet unclassified' }
RTMondrian >> initialize [
	super initialize.
	stack := OrderedCollection new.
	layoutBuilder := self createLayoutBuilder.
	edgeBuilder := RTEdgeBuilder new.
	self pushNewFrame.
]

{ #category : #'as yet unclassified' }
RTMondrian >> layout [
	^ layoutBuilder 
]

{ #category : #'as yet unclassified' }
RTMondrian >> node: anObject [
	"Add a new node to the view"
	^ (self nodes: (Array with: anObject)) first
]

{ #category : #'as yet unclassified' }
RTMondrian >> node: anObject forIt: aBlock [
	^ (self nodes: (Array with: anObject) forEach: [ :each | aBlock value ]) first
]

{ #category : #'as yet unclassified' }
RTMondrian >> nodes: objects [
	| els |
	els := self elementsOn: objects.
	self topFrame setTopElements: els.
	view addAll: els.
	^ els
]

{ #category : #'as yet unclassified' }
RTMondrian >> nodes: objects forEach: aOneArgBlock [
	| result |
	result := self nodes: objects.
	
	self topElements do: [ :element | 
		self pushNewFrame.
		self topFrame increaseDepth.
		self resetShapeBuilder.
			
		aOneArgBlock rtValue: element model.
		
		RTNest new
			layout: layoutBuilder layout;
			on: element nest: self topFrame topElements.
		self popFrame.
	].
	^ result
]

{ #category : #'as yet unclassified' }
RTMondrian >> popFrame [
	^ stack removeLast
	
]

{ #category : #'as yet unclassified' }
RTMondrian >> pushFrame: aFrame [
	stack add: aFrame
]

{ #category : #'as yet unclassified' }
RTMondrian >> pushNewFrame [
	self pushFrame: self createNewFrame
]

{ #category : #'as yet unclassified' }
RTMondrian >> resetShapeBuilder [
	shapeBuilder := self createShapeBuilder
]

{ #category : #'as yet unclassified' }
RTMondrian >> topElements [
	^ self topFrame topElements
]

{ #category : #'as yet unclassified' }
RTMondrian >> topFrame [
	^ stack last
]
