"
A GLMScrollPaneBrick is a simple scrollpane with customisable scrollbars

Instance Variables
	band:		<Object>
	lastScrollTimeStamp:		<Object>
	scrollPosition:		<Object>
	velocity:		<Object>
	verticalScrollbar:		<Object>

band
	- xxxxx

lastScrollTimeStamp
	- xxxxx

scrollPosition
	- xxxxx

velocity
	- xxxxx

verticalScrollbar
	- xxxxx

"
Class {
	#name : #GLMScrollPaneBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'band',
		'lastScrollTimeStamp',
		'scrollPosition',
		'verticalScrollbar',
		'velocity'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Scrollpane'
}

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultMaxVelocity [
	^ self defaultScrollVelocity * 4
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultScrollAcceleration [
	^ 2
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultScrollTimeReset [
	^ 350
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultScrollTurboTime [

	^ 30
]

{ #category : #'as yet unclassified' }
GLMScrollPaneBrick class >> defaultScrollVelocity [
	^ 15
]

{ #category : #examples }
GLMScrollPaneBrick class >> example [
	|foundation scrollPane|
	
	scrollPane := self new.
	
	foundation := GLMFoundationBrick new.
	foundation brickRoot: scrollPane.
	
	1 to: 20 do: [ :index |
		scrollPane addBrickBack: (GLMBrick new
			color: Color random;
			extent: 50@50).
	].
	
	foundation extent: 200@200.
	
	foundation openInWindow
]

{ #category : #examples }
GLMScrollPaneBrick class >> exampleLarge [
	|foundation scrollPane|
	
	scrollPane := self new.
	
	foundation := GLMFoundationBrick new.
	foundation brickRoot: scrollPane.
	
	1 to: 10000 do: [ :index |
		scrollPane addBrickBack: (GLMBrick new
			color: Color random;
			extent: 200@50).
	].
	
	foundation extent: 400@300.
	
	foundation openInWindow
]

{ #category : #'brick-structure-adding/removing' }
GLMScrollPaneBrick >> addBrick: aBrick before: anotherBrick [
	self band addBrick: aBrick before: anotherBrick
]

{ #category : #'brick-structure-adding/removing' }
GLMScrollPaneBrick >> addBrickBack: aBrick [
	self band addBrickBack: aBrick
]

{ #category : #'scrollpane-accessing' }
GLMScrollPaneBrick >> allowedBounds [

	^ self globalBounds
]

{ #category : #'scrollpane-brick-accessing' }
GLMScrollPaneBrick >> band [

	^ band
]

{ #category : #'scrollpane-accessing' }
GLMScrollPaneBrick >> bandTopOffset [

	^ self band brickBounds top
]

{ #category : #'scrollpane-calculations' }
GLMScrollPaneBrick >> calculateMaxVelocity [
	"max velocity must depend from the height of the band"
	^ (self band height / 15) max: self class defaultMaxVelocity
]

{ #category : #'scrollpane-calculations' }
GLMScrollPaneBrick >> calculateVelocity: event [
	|delta|
	delta := event timeStamp - lastScrollTimeStamp.
		
	self velocity: (delta > self class defaultScrollTimeReset
		ifTrue: [ self class defaultScrollVelocity ]
		ifFalse: [ (self velocity + self class defaultScrollAcceleration * (delta <= self class defaultScrollTurboTime ifTrue: [ 2 ] ifFalse: [ 1 ] )) min: self calculateMaxVelocity ]).
		
	lastScrollTimeStamp := event timeStamp.
	
	^ self velocity ceiling
]

{ #category : #'brick-layout' }
GLMScrollPaneBrick >> doLayout [
	super doLayout.
	self update.
]

{ #category : #'scrollpane-events-mouse' }
GLMScrollPaneBrick >> handleListenEvent: anEvent [
	"checking if it's keyboard event (mouse wheel is keyboard event on windows o_O (wtf?)"
	anEvent type = #keystroke ifTrue: [
		"checking if mouse is inside me"
		((self boundsInWorld containsPoint: anEvent position)) ifTrue: [
			"actuall scrolling"
			self scrollByKeyboard: anEvent ] ]
]

{ #category : #'scrollpane-events-mouse' }
GLMScrollPaneBrick >> handlesMouseWheel: evt [
	^ true
]

{ #category : #initialization }
GLMScrollPaneBrick >> initialize [
	super initialize.
	
	lastScrollTimeStamp := 0.
	
	band := self newBand.
	
	self layoutPolicy: GLMBrickVerticalFillLayout new.
	super addBrickBack: band.
	
	self verticalScrollbar: self newVerticalScrollbar.
	
	"initializes listener for mouse wheel scroll on windows vm"
	self initializeListeners
]

{ #category : #initialization }
GLMScrollPaneBrick >> initializeListeners [

	"using the most general event subscribtion for all events spawned by the hand"
	self activeHand addEventListener: self.
]

{ #category : #'scrollpane-testing' }
GLMScrollPaneBrick >> isBottomOverscrolled [

	^ self band brickBounds bottom < self height
]

{ #category : #'scrollpane-testing' }
GLMScrollPaneBrick >> isFirstVisible [

	self band hasSubbricks ifFalse: [ ^ true ].
	^ self isVisible: self band firstSubbrick
]

{ #category : #'scrollpane-testing' }
GLMScrollPaneBrick >> isFullyVisible [

	^ self isFirstVisible & self isLastVisible
]

{ #category : #'scrollpane-testing' }
GLMScrollPaneBrick >> isKeyboardScrollEvent: anEvent [

	(anEvent controlKeyPressed | anEvent commandKeyPressed) ifFalse: [^ false ].
	anEvent keyValue = 30 ifTrue: [ ^ true ].
	anEvent keyValue = 31 ifTrue: [ ^ true ].
	^ false
]

{ #category : #'scrollpane-testing' }
GLMScrollPaneBrick >> isLastVisible [

	self band hasSubbricks ifFalse: [ ^ true ].
	^ self isVisible: self band lastSubbrick
]

{ #category : #'scrollpane-testing' }
GLMScrollPaneBrick >> isPartiallyVisible: aBrick [
	|myBounds testingBounds|
	"need to normalize bounds to take only y coordinate into account"
	
	myBounds := (self allowedBounds withWidth: 1) translateBy: (self allowedBounds origin negated x@0).
	testingBounds :=  (aBrick globalBounds withWidth: 1) translateBy: (aBrick globalBounds origin negated x@0).
	
	^ myBounds intersects: testingBounds
]

{ #category : #'scrollpane-testing' }
GLMScrollPaneBrick >> isTopOverscrolled [

	^ self bandTopOffset > 0
]

{ #category : #'scrollpane-testing' }
GLMScrollPaneBrick >> isVisible: aBrick [
	|myBounds testingBounds|
	"need to normalize bounds to take only y coordinate into account"
	
	myBounds := (self allowedBounds withWidth: 0) translateBy: (self allowedBounds origin negated x@0).
	testingBounds :=  (aBrick globalBounds withWidth: 0) translateBy: (aBrick globalBounds origin negated x@0).
	
	^ myBounds containsRect: testingBounds
]

{ #category : #'scrollpane-events-mouse' }
GLMScrollPaneBrick >> mouseWheel: event [

	self scrollBy: (self calculateVelocity: event) direction: event direction.
]

{ #category : #'scrollpane-transformations' }
GLMScrollPaneBrick >> moveBandBottom [

	self band translateY: (self height - self band brickBounds bottom)
]

{ #category : #'scrollpane-transformations' }
GLMScrollPaneBrick >> moveBandTop [

	self band translateY: self bandTopOffset negated
]

{ #category : #'scrollpane-brick-creation' }
GLMScrollPaneBrick >> newBand [

	^ GLMBandBrick new
]

{ #category : #'scrollpane-brick-creation' }
GLMScrollPaneBrick >> newVerticalScrollbar [

	^ GLMScrollbarBrick new
]

{ #category : #'brick-properties-events' }
GLMScrollPaneBrick >> onThemerChanged [
	super onThemerChanged.
	
	self updateStyle
]

{ #category : #initialization }
GLMScrollPaneBrick >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	
	self unsubscribeListeners
]

{ #category : #'private-structure' }
GLMScrollPaneBrick >> privateAddBrickBack: aBrick [

	super addBrickBack: aBrick
]

{ #category : #'private-scrolling' }
GLMScrollPaneBrick >> privateScrollPosition: anInteger [

	scrollPosition := anInteger.
	self announcer announce: GLMBrickScrollPositionChanged new
]

{ #category : #'brick-structure-adding/removing' }
GLMScrollPaneBrick >> removeAllBricks [
	
	self band removeAllBricks.
	self scrollToTop
]

{ #category : #'brick-structure-adding/removing' }
GLMScrollPaneBrick >> removeBrick: aBrick [
	self band removeBrick: aBrick
]

{ #category : #'scrollpane-scrolling' }
GLMScrollPaneBrick >> scrollBy: anInteger direction: aSymbol [

	self isFullyVisible ifTrue: [ ^ self ].
	
	aSymbol = #up ifTrue: [ self scrollUp: anInteger ].
	aSymbol = #down ifTrue: [ self scrollDown: anInteger ].
	
	self update.
	self changed
]

{ #category : #'scrollpane-scrolling' }
GLMScrollPaneBrick >> scrollByKeyboard: anEvent [
	|direction|
	
	(self isKeyboardScrollEvent: anEvent) ifFalse: [^ self ].
	self velocity: (self calculateVelocity: anEvent).
	
	"keycode 30 is Event direction = #up"
	anEvent keyValue = 30 ifTrue: [ direction := #up ].
	"keycode 31 is Event direction = #down"
	anEvent keyValue = 31 ifTrue: [ direction := #down ].
	self scrollBy: velocity direction: direction
]

{ #category : #'scrollpane-scrolling' }
GLMScrollPaneBrick >> scrollDown: anInteger [
	
	self band translateY: anInteger negated.
	self isBottomOverscrolled ifTrue: [ self moveBandBottom ]
]

{ #category : #'scrollpane-scrolling' }
GLMScrollPaneBrick >> scrollPageDown [

	self
		scrollDown: self height;
		update;
		changed
]

{ #category : #'scrollpane-scrolling' }
GLMScrollPaneBrick >> scrollPageUp [

	self
		scrollUp: self height;
		update;
		changed
]

{ #category : #'scrollpane-accessing' }
GLMScrollPaneBrick >> scrollPositionBottom [

	^ self scrollPositionTop + self innerBounds height
]

{ #category : #'scrollpane-accessing' }
GLMScrollPaneBrick >> scrollPositionTop [

	^ scrollPosition ifNil: [ scrollPosition := 0 ]
]

{ #category : #'scrollpane-scrolling' }
GLMScrollPaneBrick >> scrollTo: aBrick [
	|delta|
	"if already visible no need to scroll"

	(self isVisible: aBrick) ifTrue: [ ^ self ].
	
	delta := ((self allowedBounds top - band globalBounds top) - (aBrick globalBounds top - band globalBounds top)).
	delta < 0 ifTrue: [ delta := delta + self allowedBounds height - aBrick height ].
		
	self band translateY: delta.
	self isBottomOverscrolled ifTrue: [ self moveBandBottom ].
	self isTopOverscrolled ifTrue: [ self moveBandTop ].
	
	self update.
	self changed.
	
	
]

{ #category : #'scrollpane-scrolling' }
GLMScrollPaneBrick >> scrollToBottom [

	self band hasSubbricks ifFalse: [ ^ self ].
	self scrollTo: self band lastSubbrick
]

{ #category : #'scrollpane-scrolling' }
GLMScrollPaneBrick >> scrollToTop [

	self scrollBy: self scrollPositionTop negated direction: #up
]

{ #category : #'scrollpane-scrolling' }
GLMScrollPaneBrick >> scrollUp: anInteger [

	self band translateY: anInteger.
	self isTopOverscrolled ifTrue: [ self moveBandTop ]
]

{ #category : #'brick-properties' }
GLMScrollPaneBrick >> scrollpaneBackgroundColor [

	^ self valueOfProperty: #brickScrollpaneBackgroundColor ifAbsent: [ self themer scrollpaneBackgroundColor ]
]

{ #category : #'brick-properties' }
GLMScrollPaneBrick >> scrollpaneBackgroundColor: aColor [

	self setProperty: #brickScrollpaneBackgroundColor toValue: aColor.
	self updateStyle
]

{ #category : #initialization }
GLMScrollPaneBrick >> unsubscribeListeners [

	self activeHand removeEventListener: self
]

{ #category : #'scrollpane-updating' }
GLMScrollPaneBrick >> update [

	self scrollDown: 0.
	self scrollUp: 0.
	self verticalScrollbar updatePosition.
	self privateScrollPosition: self band brickBounds top.
]

{ #category : #'scrollpane-updating' }
GLMScrollPaneBrick >> updateStyle [

	self color: self scrollpaneBackgroundColor
]

{ #category : #'scrollpane-accessing' }
GLMScrollPaneBrick >> velocity [

	^ velocity ifNil: [ velocity := self class defaultScrollVelocity ]
]

{ #category : #'scrollpane-accessing' }
GLMScrollPaneBrick >> velocity: anInteger [

	velocity := anInteger
]

{ #category : #'scrollpane-brick-accessing' }
GLMScrollPaneBrick >> verticalScrollbar [

	^ verticalScrollbar
]

{ #category : #'scrollpane-brick-accessing' }
GLMScrollPaneBrick >> verticalScrollbar: aBrick [

	verticalScrollbar := aBrick.
	verticalScrollbar scrollPane: self.
	super addBrickBack: verticalScrollbar
]
