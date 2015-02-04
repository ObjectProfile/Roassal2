Class {
	#name : #GLMBrickVerticalStackLayout,
	#superclass : #GLMBrickVerticalFillLinearLayout,
	#instVars : [
		'allowedBounds'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #examples }
GLMBrickVerticalStackLayout class >> example [
	"self example"
	| rootBrick generator colors|	
	
	rootBrick := GLMStackedScrollPaneBrick new
		color: Color white.
	rootBrick band layoutPolicy: self new.
	
	generator:= [
		1 to: 10 do: [ :index | |brick|
			brick := GLMLabelBrick new.
			brick color: (Color random alpha: 0.2).
			brick height: 30.
			brick text: 'item',index asString.
			rootBrick addBrickBack: brick ] ].
	
	colors := { Color red . Color green . Color yellow . Color pink . Color orange . Color purple}.
	1 to: 6 do: [ :index | |brick|
		brick := GLMLabelBrick new
			color: (colors at: index);
			text: ('Title ',index asString);
			textPosition: #center;
			height: 30.
		brick layoutProperties
			floating: #stack;
			hShrinkWrap.
			
		rootBrick addBrickBack: brick.
		generator value.
	].

	rootBrick asBrickedMorph
		extent: 400@400;
		openInWindow
]

{ #category : #accessing }
GLMBrickVerticalStackLayout >> allowedBounds [
	^ allowedBounds
]

{ #category : #accessing }
GLMBrickVerticalStackLayout >> allowedBounds: anObject [
	allowedBounds := anObject
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> cutAllowedBoundsBottom: aBrick [

	self allowedBounds: (self shrinkBottom: self allowedBounds with: aBrick )
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> cutAllowedBoundsTop: aBrick [

	self allowedBounds: (self shrinkTop: self allowedBounds with: aBrick )
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> decreaseZindex: aBrick [

	aBrick layoutProperties zIndex: 1.
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> deltaBottom: aBrick [

	^ aBrick globalOuterBounds corner y -  self allowedBounds corner y
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> deltaTop: aBrick [

	^ self allowedBounds origin y - aBrick globalOuterBounds origin y
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> gatherStacked: aBrick [
	|list|
	
	list := DoubleLinkedList new.
	aBrick subbricks do: [ :each | each layoutProperties floating = #stack ifTrue: [ list add: each ] ].
	^ list
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> increaseZindex: aBrick [

	aBrick layoutProperties zIndex: 2.
]

{ #category : #testing }
GLMBrickVerticalStackLayout >> isAbove: aBrick [

	^ aBrick globalOuterBounds origin <= self allowedBounds origin
]

{ #category : #testing }
GLMBrickVerticalStackLayout >> isAbove: aBrick in: aRectangle [

	^ aBrick globalOuterBounds origin <= aRectangle origin
]

{ #category : #testing }
GLMBrickVerticalStackLayout >> isVisible: aBrick [
	
	^ self allowedBounds containsRect: aBrick globalOuterBounds
]

{ #category : #testing }
GLMBrickVerticalStackLayout >> isVisible: aBrick in: aRectangle [
	
	^ aRectangle containsRect: aBrick globalOuterBounds
]

{ #category : #layouting }
GLMBrickVerticalStackLayout >> layout: aBrick in: newBounds [
	
	super layout: aBrick in: newBounds.
	^ self layoutStacked: aBrick in: newBounds
]

{ #category : #layouting }
GLMBrickVerticalStackLayout >> layoutAllowedBottom: aBrick [

	self
		translate: aBrick by: (self deltaBottom: aBrick) negated;
		increaseZindex: aBrick;
		cutAllowedBoundsBottom: aBrick
]

{ #category : #layouting }
GLMBrickVerticalStackLayout >> layoutAllowedTop: aBrick [

	self
		translate: aBrick by: (self deltaTop: aBrick);
		increaseZindex: aBrick;
		cutAllowedBoundsTop: aBrick
]

{ #category : #layouting }
GLMBrickVerticalStackLayout >> layoutStacked: aBrick in: newBounds [
	| stackedBricks forward|

	self allowedBounds: newBounds.
	stackedBricks := self gatherStacked: aBrick.
	forward := true.
	
	"going from top to bottom"
	[ stackedBricks isEmpty not & forward] whileTrue: [ |brick|
		brick := stackedBricks first value.
		(self isVisible: brick) ifFalse: [
			(self isAbove: brick) ifTrue: [
				self layoutAllowedTop: brick.
				stackedBricks removeFirst.
			] ifFalse: [ forward := false ]
		] ifTrue: [ forward := false. self decreaseZindex: brick ] ].

	"going from bottom to top"
	stackedBricks reverseDo: [ :brick |
		(self isVisible: brick)
			ifFalse: [ self layoutAllowedBottom: brick ]
			ifTrue: [ self decreaseZindex: brick ] ].

	^ allowedBounds
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> shrinkBottom: aRectangle with: aBrick [

	^ aRectangle bottom: (aRectangle bottom - aBrick globalOuterBounds height)
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> shrinkTop: aRectangle with: aBrick [

	^ aRectangle top: (aRectangle top + aBrick globalOuterBounds height)
]
