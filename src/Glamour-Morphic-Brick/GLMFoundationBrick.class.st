"
A GLMFoundationBrick is connection layer between brick widgets and morphic.

See GLMBrick class comment for more info.

Instance Variables
	brickRoot:		<Object>

brickRoot
	- xxxxx

"
Class {
	#name : #GLMFoundationBrick,
	#superclass : #Morph,
	#instVars : [
		'brickRoot'
	],
	#category : #'Glamour-Morphic-Brick-Morphic'
}

{ #category : #examples }
GLMFoundationBrick class >> exampleLarge [
	|foundation scrollPane|
	
	scrollPane := GLMScrollPaneBrick new.
	
	foundation := self new.
	foundation brickRoot: scrollPane.
	
	1 to: 10000 do: [ :index |
		scrollPane addBrickBack: (GLMBrick new
			color: Color random;
			extent: 200@50).
	].
	
	foundation extent: 400@300.
	
	foundation openInWindow
]

{ #category : #'instance creation' }
GLMFoundationBrick class >> root: aBrick [

	^ self new brickRoot: aBrick
]

{ #category : #adding }
GLMFoundationBrick >> addAllBricks: aCollection [

	aCollection do: [ :each | self addBrickBack: each ]
]

{ #category : #adding }
GLMFoundationBrick >> addBrickBack: aBrick [

	self brickRoot addBrickBack: aBrick.
]

{ #category : #accessing }
GLMFoundationBrick >> brickRoot [

	^ brickRoot
]

{ #category : #accessing }
GLMFoundationBrick >> brickRoot: aBrick [

	self brickRoot ifNotNil: [
		self removeMorph: self brickRoot.
		brickRoot := nil.
	].
	
	brickRoot := aBrick.
	self addMorphBack: brickRoot.
	
	
]

{ #category : #'as yet unclassified' }
GLMFoundationBrick >> brickThemerChanged [

	self brickRoot themerChanged
]

{ #category : #layouting }
GLMFoundationBrick >> doLayout [

	self brickRoot doLayout.
]

{ #category : #geometry }
GLMFoundationBrick >> extent: aPoint [
	|left top right bottom|
	
	super extent: aPoint.
	
	left := self brickRoot layoutProperties marginLeft.
	top := self brickRoot layoutProperties marginTop.
	
	right := self extent x - self brickRoot layoutProperties marginRight.
	bottom := self extent y - self brickRoot layoutProperties marginBottom.
	
	self brickRoot brickBounds: (left@top corner: (right@bottom)).
	
	self brickRoot doLayout.
]

{ #category : #drawing }
GLMFoundationBrick >> fullDrawOn: aCanvas [
	"preventing from drawing outside of me"
	super fullDrawOn: (aCanvas copyClipRect: self fullBounds).
]

{ #category : #geometry }
GLMFoundationBrick >> globalBounds [

	^ self bounds
]

{ #category : #geometry }
GLMFoundationBrick >> globalBoundsTranslateFactor [

	^ self globalBounds origin
]

{ #category : #initialization }
GLMFoundationBrick >> initialize [
	super initialize.
	
	self beTransparent.
	
	self brickRoot: GLMBrick new.
	self brickRoot layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
]

{ #category : #testing }
GLMFoundationBrick >> isFocused [

	^ false
]

{ #category : #initialize }
GLMFoundationBrick >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	
	self brickRoot onRemovedFrom: self
]

{ #category : #private }
GLMFoundationBrick >> privateExtent: aPoint [

	super extent: aPoint.
]

{ #category : #private }
GLMFoundationBrick >> privateThemer [

	^ self valueOfProperty: #brickThemer ifAbsentPut: [ nil ]
]

{ #category : #adding }
GLMFoundationBrick >> removeAllBricks [

	self brickRoot removeAllBricks
]

{ #category : #adding }
GLMFoundationBrick >> removeBrick: aBrick [

	self brickRoot removeBrick: aBrick
]

{ #category : #accessing }
GLMFoundationBrick >> themer [

	^ self privateThemer
		ifNotNil: [ self privateThemer ]
		ifNil: [ self owner isNotNil
			ifTrue: [ self owner isBrick ifTrue: [ self owner themer ] ifFalse: [ super brickThemer ] ]
			ifFalse: [ self theme brickThemer ] ]
]

{ #category : #accessing }
GLMFoundationBrick >> themer: aThemer [

	self setProperty: #brickThemer toValue: aThemer.
	self brickRoot themerChanged
]
