"
A ROAbstractHorizontalTreeLayout is xxxxxxxxx.

"
Class {
	#name : #RTAbstractHorizontalTreeLayout,
	#superclass : #RTAbstractRegularTreeLayout,
	#category : #'Roassal2-Layouts'
}

{ #category : #testing }
RTAbstractHorizontalTreeLayout class >> isAbstract [
	^ self = RTAbstractHorizontalTreeLayout
]

{ #category : #'hook-private' }
RTAbstractHorizontalTreeLayout >> computeChildrenFor: aNode [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RTAbstractHorizontalTreeLayout >> defaultAttachPoint [
	^ RTHorizontalAttachPoint instance
]

{ #category : #'initialize-release' }
RTAbstractHorizontalTreeLayout >> initialize [
	super initialize.
	verticalGap := 3.
	horizontalGap := 20
]

{ #category : #'hook-private' }
RTAbstractHorizontalTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: aNumber [
	| treeSize childrenPosition x y middleOfTree |
	aNodeCollection isEmpty ifTrue: [ ^ 0 ].
	x := aPoint x.
	y := aPoint y.
	alreadyLayoutedNodes addAll: aNodeCollection.
	self atLayer: aNumber add: aNodeCollection.
	aNodeCollection do: [ :each | 
		childrenPosition := x + each width + self horizontalGap.
		treeSize := each height
			max: (self layout: (self computeChildrenFor: each) atPoint: childrenPosition @ y atLayer: aNumber + 1).
		middleOfTree := y + (treeSize / 2.0) - (each height / 2.0).
		translator translateTopLeftOf: each to: (x @ middleOfTree).
		y := y + treeSize + self verticalGap.
		self step ].
	^ y - aPoint y - self verticalGap
]

{ #category : #private }
RTAbstractHorizontalTreeLayout >> rearrangeByLayers: aGraph [
	| cursor layerDepthSize |
	cursor := self leftGap.
	nodesByLayer do: [ :eachSetOfNodes |
		layerDepthSize := eachSetOfNodes inject: 0 into: [ :max :eachNode | 
			translator translateTopLeftOf: eachNode to: (cursor @ eachNode encompassingRectangle top).
			max max: eachNode width ].
		cursor := cursor + layerDepthSize + self horizontalGap ]
]
