"
A GLMBrickLayout is low level layout class providing api for positioning bricks with specific order

"
Class {
	#name : #GLMBrickLayout,
	#superclass : #LayoutPolicy,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'examples-utils' }
GLMBrickLayout class >> example [
	"this example must be called on my subclasses"
	| rootBrick brick1 brick2 brick3|
	
	rootBrick := GLMBrick new
		layoutPolicy: self new;
		color: Color blue.
	
	rootBrick layoutProperties
		paddingLeft: 10;
		paddingTop: 15;
		paddingRight: 20;
		paddingBottom: 5.
	
	" ---- Creating first brick ---- "
	brick1 := GLMBrick new
		extent: 50@70;
		color: Color red.
		
	brick1 layoutProperties
		marginLeft: 10;	
		marginTop: 15;
		marginRight: 20;	
		marginBottom: 5;
		horizontalPercent: 30;
		verticalPercent: 30.
		
	" ---- Creating second brick ---- "
	brick2 := GLMBrick new
		color: Color green;
		extent: 70@60.
	
	brick2 layoutProperties
		marginLeft: 10;
		marginTop: 15;	
		marginRight: 20;
		marginBottom: 5;
		horizontalPercent: 50;
		verticalPercent: 50.
		
	" ---- Creating third brick ---- "
	brick3 := GLMBrick new
		color: Color yellow;
		extent: 100@50.
		
	brick3 layoutProperties
		marginLeft: 10;
		marginTop: 15;
		marginRight: 20;	
		marginBottom: 5;
		horizontalPercent: 20;
		verticalPercent: 20.
		
	" ---- Add them to the root brick ---- "
	rootBrick
		addBrickBack: brick1;
		addBrickBack: brick2;
		addBrickBack: brick3.
	
	rootBrick asBrickedMorph
		extent: 600@400;
		openInWindowLabeled: self name
]

{ #category : #bounds }
GLMBrickLayout >> boundsOf: aBrick in: owner withArguments: aHashTable [
	
	^ (owner paddingLeft@owner paddingTop) extent: (self extentOf: aBrick in: owner withArguments: aHashTable)
]

{ #category : #layouting }
GLMBrickLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	
	^ (self originalWidthOf: aBrick)@(self originalHeightOf: aBrick)
]

{ #category : #reflection }
GLMBrickLayout >> floatingMethodFor: aSymbol [

	^ ('layoutFloating', (aSymbol capitalized), ':in:withArguments:') asSymbol.
]

{ #category : #testing }
GLMBrickLayout >> isHorizontal [

	self subclassResponsibility
]

{ #category : #testing }
GLMBrickLayout >> isVertical [

	self subclassResponsibility
]

{ #category : #layouting }
GLMBrickLayout >> layout: aBrick in: newBounds [
	self subclassResponsibility
]

{ #category : #layouting }
GLMBrickLayout >> layoutFloating: aBrick in: newBounds withArguments: arguments [
	"must return an integer that will be added to the offset, if necessary"
	
	|float symbol|
	float := aBrick layoutProperties floating.
	symbol := self floatingMethodFor: float.
	
	^ (self respondsTo: symbol)
		ifTrue: [ self perform: symbol with: aBrick with: newBounds with: arguments ]
		ifFalse: [ 0 ]
]

{ #category : #layouting }
GLMBrickLayout >> layoutFloatingRight: aBrick in: newBounds withArguments: arguments [

	| left top right bottom |
	
	left := aBrick owner width - aBrick width - aBrick marginRight.
	top := aBrick  marginTop.
	right := aBrick owner width - aBrick marginRight.
	bottom := aBrick owner height - aBrick marginBottom.
	
	self setNewBounds: (GLMBrickLayoutBounds on: ((left@top) corner: right@bottom) of: aBrick) to: aBrick in: aBrick owner.
	
	^ 0
]

{ #category : #layouting }
GLMBrickLayout >> layoutInjection: aBrick withArguments: aDictionary [

	^ 0
]

{ #category : #'extent functions' }
GLMBrickLayout >> maxHeightOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties maxHeightBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger maxVal ]
]

{ #category : #'extent functions' }
GLMBrickLayout >> maxWidthOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties maxWidthBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger maxVal ]
]

{ #category : #'extent functions' }
GLMBrickLayout >> minHeightOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties minHeightBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger minVal ]
]

{ #category : #'extent functions' }
GLMBrickLayout >> minWidthOf: aBrick [
	|blockValue|
	
	blockValue := aBrick layoutProperties minWidthBlock cull: aBrick.
	
	^ (blockValue >= 0)
		ifTrue:[ blockValue ]
		ifFalse: [ SmallInteger minVal ]
]

{ #category : #'extent functions' }
GLMBrickLayout >> originalHeightOf: aBrick [

	^ ((aBrick height) max: (self minHeightOf: aBrick)) min: (self maxHeightOf: aBrick).
]

{ #category : #'extent functions' }
GLMBrickLayout >> originalWidthOf: aBrick [

	^ ((aBrick width) max: (self minWidthOf: aBrick)) min: (self maxWidthOf: aBrick).
]

{ #category : #'set up' }
GLMBrickLayout >> prepareArgumentsFor: aBrick [

	^ nil
]

{ #category : #'set up' }
GLMBrickLayout >> prepareLayout: aBrick [

	aBrick onPrepareLayout
]

{ #category : #events }
GLMBrickLayout >> sendEvent: aLayoutEvent to: aBrick [

	aBrick onLayoutEvent: aLayoutEvent
]

{ #category : #scripting }
GLMBrickLayout >> setHShrinking: aBrick [
	"configurates Brick to allow horizontal shrinking to its subbricks"
	self subclassResponsibility
]

{ #category : #bounds }
GLMBrickLayout >> setNewBounds: aLayoutBounds to: aMorph in: aBrick [

	aMorph brickBounds: aLayoutBounds bounds compressed
]

{ #category : #scripting }
GLMBrickLayout >> setVShrinking: aBrick [
	"configurates Brick to allow vertical shrinking to its subbricks"
	self subclassResponsibility
]

{ #category : #reflection }
GLMBrickLayout >> supportsFloating: aSymbol [
	
	aSymbol = #none ifTrue: [ ^ false ].
	
	^ self respondsTo: (self floatingMethodFor: aSymbol)
]

{ #category : #bounds }
GLMBrickLayout >> translate: aBrick by: anInteger [

	self subclassResponsibility
]
