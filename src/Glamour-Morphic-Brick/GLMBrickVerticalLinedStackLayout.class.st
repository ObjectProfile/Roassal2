Class {
	#name : #GLMBrickVerticalLinedStackLayout,
	#superclass : #GLMBrickVerticalStackLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickVerticalLinedStackLayout class >> example [
	"self example"
	super example
]

{ #category : #testing }
GLMBrickVerticalLinedStackLayout >> isFullyVisible: aBrick [
	
	^ self allowedBounds containsRect: aBrick globalOuterBounds
]

{ #category : #testing }
GLMBrickVerticalLinedStackLayout >> isFullyVisible: aBrick in: aRectangle [
	
	^ aRectangle containsRect: aBrick globalOuterBounds
]

{ #category : #testing }
GLMBrickVerticalLinedStackLayout >> isPartiallyVisibleAbove: aBrick [

	^ (self isFullyVisible: aBrick) not & (self isAbove: aBrick)
]

{ #category : #testing }
GLMBrickVerticalLinedStackLayout >> isVisible: aBrick in: aRectangle [
	
	^ aRectangle intersects: aBrick globalOuterBounds
]

{ #category : #layouting }
GLMBrickVerticalLinedStackLayout >> layoutProportional: aCollection in: aBrick position: aSymbol [
	| fullWidth eachWidth index |
	aCollection isEmpty ifTrue: [ ^ self ].
	
	fullWidth := aBrick innerBounds width.
	index := 0.
	aCollection inject: aBrick paddingLeft into: [ :leftOffset :each |
		|layoutBounds|
		
		self sendEvent: (GLMBrickLayoutStacked new index: (index + 1); position: aSymbol; yourself) to: each.
		
		eachWidth := ((fullWidth - leftOffset) / (aCollection size - index)) ceiling.
		
		layoutBounds := GLMBrickLayoutBounds on: each brickBounds of: each.
		index = 0
			ifTrue: [ layoutBounds makeOuterBoundsFitWidth: (((self maxWidthOf: each) max: eachWidth) min: (fullWidth - leftOffset)) ]
			ifFalse: [				
				(index = (aCollection size - 1))
					ifFalse: [ layoutBounds makeOuterBoundsFitWidth: (eachWidth min: (self maxWidthOf: each)) ]
					ifTrue: [ layoutBounds makeOuterBoundsFitWidth: eachWidth ] ].
		
		layoutBounds translateBy: (leftOffset@0).
		self setNewBounds: layoutBounds to: each in: aBrick.
		index := index + 1.
		leftOffset + layoutBounds outerBounds width ]
]

{ #category : #layouting }
GLMBrickVerticalLinedStackLayout >> layoutStacked: aBrick in: newBounds [
	| origStackedBricks stackedBricks forward stackedTopBricks stackedBottomBricks stackedTopHeight stackedBottomHeight|

	self allowedBounds: newBounds.
	stackedBricks := self gatherStacked: aBrick.
	origStackedBricks := DoubleLinkedList new.
	origStackedBricks addAll: stackedBricks.
	forward := true.
	
	stackedTopHeight := 0.
	stackedBottomHeight := 0.
	stackedTopBricks := OrderedCollection new.
	stackedBottomBricks := OrderedCollection new.
	
	"going from top to bottom"
	[ stackedBricks isEmpty not & forward] whileTrue: [ |brick|
		brick := stackedBricks removeFirst value.
		(self isVisible: brick) ifFalse: [
			(self isAbove: brick) ifTrue: [ |delta|
				delta := (self deltaTop: brick) - stackedTopHeight.
				self translate: brick by: delta.
				self increaseZindex: brick.
				stackedTopBricks isEmpty ifTrue: [
					stackedTopHeight := stackedTopHeight + brick globalOuterBounds height.
					self cutAllowedBoundsTop: brick ].
				stackedTopBricks add: brick.
			] ifFalse: [ forward := false. stackedBricks addFirst: brick ]
		] ifTrue: [
			(self isPartiallyVisibleAbove: brick)
				ifTrue: [ self layoutAllowedTop: brick ]
				ifFalse: [ forward := false. self decreaseZindex: brick.	stackedBricks addFirst: brick ] ] ].

	"going from bottom to top"
	[ stackedBricks isEmpty not ] whileTrue: [ |brick|
		brick := stackedBricks removeLast value.
		(self isVisible: brick) ifFalse: [ |delta|
			delta := (self deltaBottom: brick) - stackedBottomHeight.
			self translate: brick by: delta negated.
			self increaseZindex: brick.
			stackedBottomBricks isEmpty ifTrue: [
				stackedBottomHeight := stackedBottomHeight + brick globalOuterBounds height.
				self cutAllowedBoundsBottom: brick ].
			stackedBottomBricks add: brick.
		] ifTrue: [
			(self isFullyVisible: brick )
				ifFalse: [ self layoutAllowedBottom: brick ]
				ifTrue: [ self decreaseZindex: brick ] ] ].

	self layoutProportional: stackedTopBricks reverse in: aBrick position: #top.
	self layoutProportional: stackedBottomBricks reverse in: aBrick position: #bottom.
	
	origStackedBricks do: [ :each | each doLayout ].
	
	^ allowedBounds
]
