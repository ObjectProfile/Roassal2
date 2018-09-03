Class {
	#name : #GLMScrollListBrick,
	#superclass : #GLMScrollPaneBrick,
	#instVars : [
		'adaptor',
		'visibleIndex'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Scrollpane'
}

{ #category : #examples }
GLMScrollListBrick class >> example [
	|adaptor|
	adaptor := nil.
	adaptor := GLMBrickListAdaptor new
		sizeLogic: [ 2000 ];
		morphAtLogic: [ :index :morph | 
			(morph ifNil: [ GLMLabelBrick new ])
				color: Color random muchLighter;
				text: index asString, ' of ', adaptor count asString;
				textPosition: #center;
				yourself ].

	GLMFoundationBrick new
		brickRoot: (self new adaptor: adaptor);
		extent: 300@400;
		openInWindow
]

{ #category : #examples }
GLMScrollListBrick class >> exampleCollection [

	GLMFoundationBrick new
		brickRoot: (self new adaptor: (GLMBrickListAdaptor new on: Smalltalk allClasses));
		extent: 300@400;
		openInWindow
]

{ #category : #examples }
GLMScrollListBrick class >> exampleDifferentHeights [
	|adaptor|
	adaptor := nil.
	adaptor := GLMBrickListAdaptor new
		sizeLogic: [ 50 ];
		morphAtLogic: [ :index :morph |
			(morph ifNil: [ GLMLabelBrick new ])
				color: Color random muchLighter;
				text: index asString, ' of ', adaptor count asString;
				textPosition: #center;
				enable;
				height: [ :b | (((index % 10)*10 + 30) +  (10000 * (2 / b width))) asInteger ];
				yourself ].

	GLMFoundationBrick new
		brickRoot: (self new adaptor: adaptor);
		extent: 800@400;
		openInWindow
]

{ #category : #examples }
GLMScrollListBrick class >> exampleInfinity [
	|adaptor|
	adaptor := nil.
	adaptor := GLMBrickListAdaptor new
		sizeLogic: [ Float infinity ];
		morphAtLogic: [ :index :morph | 
			(morph ifNil: [ GLMLabelBrick new ])
				color: Color random muchLighter;
				text: index asString, ' of ', adaptor count asString;
				textPosition: #center;
				yourself ].

	GLMFoundationBrick new
		brickRoot: (self new adaptor: adaptor);
		extent: 300@400;
		openInWindow
]

{ #category : #accessing }
GLMScrollListBrick >> adaptor [

	^ adaptor
]

{ #category : #accessing }
GLMScrollListBrick >> adaptor: anAdaptor [

	adaptor := anAdaptor
]

{ #category : #adding }
GLMScrollListBrick >> addItemMorph: aMorph after: anotherMorph [

	self addBrickBack: aMorph.
	self setBoundsOf: aMorph after: anotherMorph.
	(self isPartiallyVisible: aMorph) ifFalse: [ self removeBrick: aMorph. ^ nil ].
	^ aMorph
]

{ #category : #adding }
GLMScrollListBrick >> addItemMorph: aMorph before: anotherMorph [

	self setBoundsOf: aMorph before: anotherMorph.
	self addBrick: aMorph before: anotherMorph.
	(self isPartiallyVisible: aMorph) ifFalse: [ self removeBrick: aMorph. ^ nil ].
	
	aMorph brickBounds top < 0
		ifTrue: [ self moveAllSubbricksBy: aMorph brickBounds top negated ]
		ifFalse: [ (self getIndex: aMorph) = 1 ifTrue: [
				self moveAllSubbricksBy: aMorph brickBounds top negated ] ].
	
	^ aMorph
]

{ #category : #scrolling }
GLMScrollListBrick >> calculateMaxVelocity [
	"max velocity must depend from the height of the band"
	^ (self height * 0.9) asInteger
]

{ #category : #layouting }
GLMScrollListBrick >> doLayout [
	
	self band hasSubbricks ifFalse: [ self updateVisible ].
	
	self layoutPolicy layout: self in: self brickBounds.
	self flag: 'Fix bug in Layouts'.
	self band doLayout.
	self band doLayout.
	self update.
]

{ #category : #accessing }
GLMScrollListBrick >> gatherInvisibleItems [
			
	^ self band subbricks select: [ :each | (self isPartiallyVisible: each) not ]
]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> getAndRemoveInvisibleMorph: aCollection [
	|brick|
	brick := self retrieveLast: aCollection.
	^ brick ifNotNil: [ self removeBrick: brick. brick morph ]
]

{ #category : #accessing }
GLMScrollListBrick >> getIndex: aBrick [ 

	^ aBrick valueOfProperty: #brickScrollListIndex ifAbsent: [ ]
]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> getMorphAt: anInteger recycled: aMorph [
	|newMorph|
	
	newMorph := (self adaptor morphAt: anInteger convert: aMorph) asBrick.
	self setIndex: anInteger in: newMorph.
	^ newMorph
]

{ #category : #initialization }
GLMScrollListBrick >> initialize [
	super initialize.
	
	self band layoutPolicy: GLMBrickVerticalScrollListLayout new
]

{ #category : #scrolling }
GLMScrollListBrick >> invalidate [

	self scrollTo: self visibleIndex
]

{ #category : #testing }
GLMScrollListBrick >> isFirstAdded [

	^ (self getIndex: self band firstSubbrick) = 1
]

{ #category : #testing }
GLMScrollListBrick >> isFullyVisible [
	self band hasSubbricks ifFalse: [ ^ true ].
	^ self isLastAdded & self isFirstAdded & super isFullyVisible
]

{ #category : #testing }
GLMScrollListBrick >> isLastAdded [

	^ (self getIndex: self band lastSubbrick) = self adaptor count
]

{ #category : #layouting }
GLMScrollListBrick >> moveAllSubbricksBy: anInteger [

	self band subbricks do: [ :each | each translateY: anInteger ].
	self band translateY: anInteger negated
]

{ #category : #'instance creation' }
GLMScrollListBrick >> newBand [
	^ super newBand height: [ :bandBrick |
		bandBrick subbricks isEmpty
			ifTrue: [ 0 ]
			ifFalse: [ bandBrick lastSubbrick brickBounds bottom ] ].
]

{ #category : #'instance creation' }
GLMScrollListBrick >> newVerticalScrollbar [

	^ GLMApproximateScrollbarBrick new
]

{ #category : #scrolling }
GLMScrollListBrick >> preventOverscrolling [

	self band hasSubbricks ifFalse: [ ^ self ].

	self isFirstAdded & self isFirstVisible ifTrue: [
			(self topOffset > 0) ifTrue: [
				self moveAllSubbricksBy: self topOffset negated.
				self moveBandTop.
				^ self update ] ].
	
	self isTopOverscrolled
		ifTrue: [ self moveBandTop. ^ self update ].
	self isBottomOverscrolled & (self isFullyVisible not)
		ifTrue: [ self moveBandBottom. ^ self update ]
]

{ #category : #accessing }
GLMScrollListBrick >> retrieveLast: aCollection [

	^ aCollection isEmpty
		ifTrue: [ nil ]
		ifFalse: [ aCollection removeLast ]
]

{ #category : #scrolling }
GLMScrollListBrick >> scrollDown: anInteger [
	
	self band translateY: (
		self isLastAdded
			ifTrue: [ anInteger min: (self band brickBounds bottom - self height) ]
			ifFalse: [ anInteger ]) negated
]

{ #category : #scrolling }
GLMScrollListBrick >> scrollPageDown [
	
	self
		scrollDown: self calculateMaxVelocity;
		update;
		changed
]

{ #category : #scrolling }
GLMScrollListBrick >> scrollPageUp [
	
	self
		scrollUp: self calculateMaxVelocity;
		update;
		changed
]

{ #category : #scrolling }
GLMScrollListBrick >> scrollTo: anInteger [
	|brick index|
	self band removeAllBricks.
	self moveBandTop.
	visibleIndex := nil.
	
	self adaptor count > 0 ifTrue: [
		index := (anInteger max: 1) min: self adaptor count.
		brick := self getMorphAt: index recycled: nil.
		brick 	withWidth: self band width.
		brick 	doLayout.
	
		brick brickBounds: ((0@(0 max: ((self height - brick height) / 2))) extent: brick extent).
		self band addBrickBack: brick ].
	
	self update.
	self changed
	
	
	
	
]

{ #category : #scrolling }
GLMScrollListBrick >> scrollToBottom [

	self scrollTo: self adaptor count
]

{ #category : #scrolling }
GLMScrollListBrick >> scrollToTop [

	self scrollTo: 1
]

{ #category : #scrolling }
GLMScrollListBrick >> scrollUp: anInteger [
	
	self band translateY: (
		self isFirstAdded
			ifTrue: [ anInteger min: (self topOffset - self bandTopOffset) ]
			ifFalse: [ anInteger ])
]

{ #category : #layouting }
GLMScrollListBrick >> setBoundsOf: aMorph after: afterMorph [
	
	aMorph
		withWidth: self band width;
		doLayout;
		brickBounds: (afterMorph brickBounds bottomLeft extent: aMorph extent)
]

{ #category : #layouting }
GLMScrollListBrick >> setBoundsOf: aMorph before: beforeMorph [
	|origin corner|
	
	aMorph withWidth: self band width.
	aMorph doLayout.
	
	corner := beforeMorph brickBounds topRight.
	origin  := beforeMorph brickBounds topLeft - (0@aMorph height).
	
	aMorph brickBounds: (origin corner: corner)
]

{ #category : #accessing }
GLMScrollListBrick >> setIndex: anInteger in: aBrick [ 

	aBrick setProperty: #brickScrollListIndex toValue: anInteger
]

{ #category : #accessing }
GLMScrollListBrick >> topOffset [

	^ self band firstSubbrick brickBounds top
]

{ #category : #scrolling }
GLMScrollListBrick >> update [

	self updateVisible.
	self band updateHeight.
	self preventOverscrolling.
	self verticalScrollbar updatePosition.
]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> updateVisible [
	|invisible|
	
	self adaptor ifNil: [ ^ self ].
	self adaptor count = 0 ifTrue: [ ^ self ].
	
	invisible := self gatherInvisibleItems.
	invisible = self band subbricks & invisible isEmpty not ifTrue: [ ^ self ].
	
	self updateVisibleTop: invisible.
	self updateVisibleBottom: invisible.
	
	invisible do: [ :each | self band removeBrick: each ].
	
	visibleIndex := self getIndex: self band firstSubbrick 
]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> updateVisibleBottom: invisibleBricks [
	|after|
	
	after := self band lastSubbrick.
	[ after isNotNil and: [ (self isPartiallyVisible: after) and: [ (self getIndex: after) < self adaptor count ] ] ] whileTrue: [
		after := self
			addItemMorph: (
				self
					getMorphAt: (self getIndex: after) + 1
					recycled: (self getAndRemoveInvisibleMorph: invisibleBricks))
			after: after ].
]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> updateVisibleTop: invisibleBricks [
	|before|
	
	before := self band hasSubbricks not
		ifFalse: [ self band firstSubbrick]
		ifTrue: [ self band addBrickBack: (self getMorphAt: self visibleIndex recycled: (self getAndRemoveInvisibleMorph: invisibleBricks)) ].
		
	[ before isNotNil and: [ (self isPartiallyVisible: before) and: [ (self getIndex: before) > 1 ] ] ] whileTrue: [
		before := self
			addItemMorph: (
				self
					getMorphAt: (self getIndex: before) - 1
					recycled: (self getAndRemoveInvisibleMorph: invisibleBricks))
			before: before  ]
	
]

{ #category : #accessing }
GLMScrollListBrick >> visibleIndex [

	^ visibleIndex ifNil: [ visibleIndex := 1 ]
]
