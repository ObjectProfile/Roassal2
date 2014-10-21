"
NOT WORKING YET, PLEASE REFRAIN FROM USING.
"
Class {
	#name : #RTHTMLExploraBuilder,
	#superclass : #RTHTMLBuilder,
	#instVars : [
		'layout',
		'lineShape',
		'nodes',
		'popUp',
		'popupText',
		'nextId',
		'leftClick',
		'rightClick'
	],
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #hooks }
RTHTMLExploraBuilder >> addCustomizations [
	| root direction block |
	exporter
		title: 'Explora';
		fileName: 'explora'.
	root := view elements at: 1.
	direction := leftClick first.
	block := leftClick second.
	self makeChildren: root direction: direction function: block.
	"direction := rightClick first.
	block := rightClick second.
	self makeChildren: root direction: direction function: block."
	self layout on: self view elements
]

{ #category : #adding }
RTHTMLExploraBuilder >> buildNode: object parent: parent [
	| element |
	element := RTElement new model: object.
	element addShape: self shape shape. 
	^ element
]

{ #category : #layout }
RTHTMLExploraBuilder >> circleLayout [
	^ self layout: [ :elem | (RTCenteredCircleLayout new center: elem position) ]
]

{ #category : #layout }
RTHTMLExploraBuilder >> clusterLayout [
	^ self layout: [ RTClusterLayout new ]
]

{ #category : #layout }
RTHTMLExploraBuilder >> defaultLayout [
	^ self treeLayout
]

{ #category : #'default values' }
RTHTMLExploraBuilder >> defaultLineShape [
	^ RTLine new
]

{ #category : #'default values' }
RTHTMLExploraBuilder >> defaultNodeShape [
	self shape circle size: 20; color: (Color blue alpha: 0.5); yourself
]

{ #category : #'default values' }
RTHTMLExploraBuilder >> defaultTextColor [
	^ Color black
]

{ #category : #view }
RTHTMLExploraBuilder >> dragChildren [
	"do nothing"
]

{ #category : #layout }
RTHTMLExploraBuilder >> horizontalTreeLayout [
	^ self layout: RTHorizontalTreeLayout new
]

{ #category : #initialization }
RTHTMLExploraBuilder >> initialize [
	super initialize.
	nextId := 0.
	popUp := false.
	nodes := Dictionary new.
	lineShape := self defaultLineShape.
	self initializeNodes.
	self defaultLayout.
]

{ #category : #initialization }
RTHTMLExploraBuilder >> initializeNodes [
	self defaultNodeShape.
]

{ #category : #accessing }
RTHTMLExploraBuilder >> layout [
	^ layout
]

{ #category : #accessing }
RTHTMLExploraBuilder >> layout: anObject [
	layout := anObject
]

{ #category : #accessing }
RTHTMLExploraBuilder >> lineShape [
	^ lineShape
]

{ #category : #accessing }
RTHTMLExploraBuilder >> lineShape: anObject [
	lineShape := anObject
]

{ #category : #layout }
RTHTMLExploraBuilder >> linearLayout [
	^ self layout: RTHorizontalLineLayout new
]

{ #category : #hooks }
RTHTMLExploraBuilder >> makeChildren: root direction: direction function: block [
	| children |
	children := block rtValue: root model.
	children isCollection ifFalse:[ children := Array with: children ].
	children  := children collect: [ :c | self node: c direction: direction parent: root ].
	children isEmpty
		ifFalse: [ children do: [ :c | self makeChildren: c direction: direction function: block] ]. 
]

{ #category : #adding }
RTHTMLExploraBuilder >> node: anObject [ 
	^ self node: anObject direction: #From parent: nil.
]

{ #category : #adding }
RTHTMLExploraBuilder >> node: anObject direction: direction parent: element [
	| node edge |
	node := self buildNode: anObject parent: element.
	self view add: node.
	element = nil
		ifFalse: [  
			direction = #To
				ifTrue: [ edge := RTLine edgeFrom: node to: element.  ].
			direction = #From
				ifTrue: [ edge := RTLine edgeFrom: element to: node.  ].		
			self view add: edge.	
			self nodes at: element ifAbsent: [ self nodes at: element put: OrderedCollection new ].
			(self nodes at: element) add: (Array with: direction with: node)
			].
	^ node.
]

{ #category : #accessing }
RTHTMLExploraBuilder >> nodes [
	^nodes
]

{ #category : #action }
RTHTMLExploraBuilder >> onClickExplore: aBlock [
	self onLeftClickExplore: aBlock.
	self onRightClickExplore: aBlock.
]

{ #category : #action }
RTHTMLExploraBuilder >> onLeftClickExplore: aBlock [
	self onLeftClickExplore: aBlock edges: #From
]

{ #category : #action }
RTHTMLExploraBuilder >> onLeftClickExplore: aBlock edges: edgeDirection [
	leftClick := Array with: edgeDirection with: aBlock 
]

{ #category : #action }
RTHTMLExploraBuilder >> onRightClickExplore: aBlock [ 
	self onRightClickExplore: aBlock edges: #To
]

{ #category : #action }
RTHTMLExploraBuilder >> onRightClickExplore: aBlock edges: edgeDirection [
	rightClick := Array with: edgeDirection with: aBlock 
]

{ #category : #layout }
RTHTMLExploraBuilder >> radialTreeLayout [
	^ self layout: RTRadialTreeLayout new
]

{ #category : #layout }
RTHTMLExploraBuilder >> treeLayout [
	^ self layout: RTTreeLayout new
]

{ #category : #view }
RTHTMLExploraBuilder >> withPopup [
	self withPopup: [ :obj | obj printString ]
]

{ #category : #view }
RTHTMLExploraBuilder >> withPopup: aStringOrBlock [
	popUp := true.
	popupText := aStringOrBlock
]
