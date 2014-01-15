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
	^ self name = #ROAbstractHorizontalTreeLayout
]

{ #category : #'hook-private' }
RTAbstractHorizontalTreeLayout >> computeChildrenFor: aNode [
	self subclassResponsibility
]

{ #category : #'hook-private' }
RTAbstractHorizontalTreeLayout >> defaultFromPositions [
	
	^#(#rightCenter)
	
"BTC-2012-08-05 Not sure what effect this has or if this is a valid symbol - its just pattern matching."
]

{ #category : #'hook-private' }
RTAbstractHorizontalTreeLayout >> defaultToPositions [

	^#(#leftCenter)
	
"BTC-2012-08-05 Not sure what effect this has or if this is a valid symbol - its just pattern matching."
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
		translator translate: each to: (x @ middleOfTree).
		y := y + treeSize + self verticalGap.
		self step ].
	^ y - aPoint y - self verticalGap
]

{ #category : #private }
RTAbstractHorizontalTreeLayout >> rearrangeByLayers: aGraph [
	| cursor layerDepthSize |
	cursor := self leftGap.
	nodesByLayer do: [:eachSetOfNodes |
		layerDepthSize := eachSetOfNodes inject: 0 into: [:max :eachNode | 
			translator translate: eachNode to: (cursor @ eachNode bounds top).
			max max: eachNode width ].
		cursor := cursor + layerDepthSize + self horizontalGap ]
]
