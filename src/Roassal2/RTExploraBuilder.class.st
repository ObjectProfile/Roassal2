"
A ROExploraBuilder is xxxxxxxxx.

Instance Variables
	layout:		<Object>
	lineShape:		<Object>
	nextId:		<Object>
	nodeListeners:		<Object>
	nodeProperties:		<Object>
	nodes:		<Object>
	popUp:		<Object>
	view:		<Object>

layout
	- xxxxx

lineShape
	- xxxxx

nextId
	- xxxxx

nodeListeners
	- xxxxx

nodeProperties
	- xxxxx

nodes
	- xxxxx

popUp
	- xxxxx

view
	- xxxxx

"
Class {
	#name : #RTExploraBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'nodes',
		'layout',
		'lineShape',
		'nodeListeners',
		'popUp',
		'popupText',
		'nextId',
		'dragChildren'
	],
	#category : #'Roassal2-Builder-Explora'
}

{ #category : #action }
RTExploraBuilder >> addListenerBlock: listenerBlock [
	nodes do: listenerBlock.
	nodeListeners add: listenerBlock
]

{ #category : #adding }
RTExploraBuilder >> buildNode: object parent: parent [
	| node element |
	
	node := RTExploraNode new.
	node builder: self.
	node id: self newNodeId.
	node parentNode: parent.
	element := RTElement new model: object.
	node element: element.
	nodeListeners do: [ :block | block value: node ].
	element addShape: self shape shape.
	"element := self shape elementOn: object."
	
	dragChildren ifTrue: [ element @ RTDraggableChildren ] ifFalse: [ element @ RTDraggable ].
	popUp ifTrue: [ element @ (RTPopup new group: self explorePopUp) ].
	
	"node updateColor."
	^ node
]

{ #category : #layout }
RTExploraBuilder >> circleLayout [
	" Not working properly! needs fix somewhere. "
	^ self layout: [ :elem | RTCircleLayout "(RTCenteredCircleLayout new;
		center: elem position)" ]
]

{ #category : #layout }
RTExploraBuilder >> clusterLayout [
	^ self layout: [ RTClusterLayout new ]
]

{ #category : #view }
RTExploraBuilder >> configureView: aView [
	aView @ RTDraggableView.
]

{ #category : #layout }
RTExploraBuilder >> defaultLayout [
	^ self treeLayout
]

{ #category : #'default values' }
RTExploraBuilder >> defaultLineShape [
	^ RTLine new
]

{ #category : #'default values' }
RTExploraBuilder >> defaultNodeShape [
	self shape circle size: 20; color: (Color blue alpha: 0.5); yourself
]

{ #category : #'default values' }
RTExploraBuilder >> defaultTextColor [
	^ Color black
]

{ #category : #view }
RTExploraBuilder >> dragChildren [
	dragChildren := true
]

{ #category : #adding }
RTExploraBuilder >> explorePopUp [
	^ [ :group :elem |
			| background node |
			node := elem attributes at: #node.
			background := (RTBox new color: (Color lightGreen alpha: 0.95)) element.
			group add: (RTElement new model: elem model)
				+ (RTLabel new text: [ :e | popupText rtValue: e]).
			group addAll: (node expansionDirections collect: [
				:direction |
				(RTElement new model:
					((node expansionDirections size > 1
						ifFalse: ['']
						ifTrue: [(direction key) asString , ': ']),(
					(node explorationStatus: direction)
					))) + (RTLabel new height: 8)]).
			(RTVerticalLineLayout withGap: 0) on: group.
			
			RTNest new centerOn: background elements: group.
			group addFirst: background ]
]

{ #category : #layout }
RTExploraBuilder >> horizontalTreeLayout [
	^ self layout: RTHorizontalTreeLayout new
]

{ #category : #initialization }
RTExploraBuilder >> initialize [
	super initialize.
	nextId := 0.
	popUp := false.
	dragChildren := false.
	nodes := OrderedCollection new.
	nodeListeners := OrderedCollection new.
	lineShape := self defaultLineShape.
	self configureView: view.
	self initializeNodes.
	self defaultLayout.
]

{ #category : #initialization }
RTExploraBuilder >> initializeNodes [
	self defaultNodeShape.
]

{ #category : #accessing }
RTExploraBuilder >> layout [
	^ layout
]

{ #category : #accessing }
RTExploraBuilder >> layout: aLayout [
	layout := aLayout.
	^ aLayout
]

{ #category : #accessing }
RTExploraBuilder >> lineShape [
	^ lineShape
]

{ #category : #accessing }
RTExploraBuilder >> lineShape: aShape [
	lineShape := aShape
]

{ #category : #layout }
RTExploraBuilder >> linearLayout [
	^ self layout: RTHorizontalLineLayout new
]

{ #category : #adding }
RTExploraBuilder >> newNodeId [
	nextId := nextId + 1.
	^ nextId
]

{ #category : #adding }
RTExploraBuilder >> node: anObject [ 
	^ self node: anObject parent: nil.
]

{ #category : #adding }
RTExploraBuilder >> node: anObject parent: element [
	| node |
	node := self buildNode: anObject parent: element.
	nodes add: node.
	^ node.
]

{ #category : #accessing }
RTExploraBuilder >> nodes [
	^ nodes
]

{ #category : #action }
RTExploraBuilder >> onClickExplore: aBlock [
	self addListenerBlock: [ :el |
		el addListenerFor: TRMouseClick onDirection: #default -> #From withBlock: aBlock ].
]

{ #category : #action }
RTExploraBuilder >> onLeftClickExplore: aBlock [
	self onLeftClickExplore: aBlock edges: #From
]

{ #category : #action }
RTExploraBuilder >> onLeftClickExplore: aBlock edges: edgeDirection [
	self onLeftClickExplore: aBlock edges: edgeDirection direction: #LeftClick
]

{ #category : #action }
RTExploraBuilder >> onLeftClickExplore: aBlock edges: edgeDirection direction: directionName [
	self addListenerBlock: [ :el |
		el addListenerFor: TRMouseLeftClick onDirection: directionName -> edgeDirection withBlock: aBlock ]
]

{ #category : #action }
RTExploraBuilder >> onRightClickExplore: aBlock [ 
	self onRightClickExplore: aBlock edges: #To
]

{ #category : #action }
RTExploraBuilder >> onRightClickExplore: aBlock edges: edgeDirection [
	self onRightClickExplore: aBlock edges: edgeDirection direction: #RightClick
]

{ #category : #action }
RTExploraBuilder >> onRightClickExplore: aBlock edges: edgeDirection direction: directionName [
	self addListenerBlock: [ :el |
		el addListenerFor: TRMouseRightClick onDirection: directionName -> edgeDirection withBlock: aBlock ]
]

{ #category : #layout }
RTExploraBuilder >> radialTreeLayout [
	^ self layout: RTRadialTreeLayout new
]

{ #category : #view }
RTExploraBuilder >> renderIn: rView [
	nodes do: [ :n | rView add: n element ]
]

{ #category : #layout }
RTExploraBuilder >> treeLayout [
	^ self layout: RTTreeLayout new
]

{ #category : #view }
RTExploraBuilder >> withPopup [
	self withPopup: [ :obj | obj printString ]
]

{ #category : #view }
RTExploraBuilder >> withPopup: aStringOrBlock [
	popUp := true.
	popupText := aStringOrBlock
]
