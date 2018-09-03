"
A GLMBrick is xxxxxxxasdadxx.

Instance Variables
	brickBounds:		<Object>
	transmissions:		<Object>

brickBounds
	- xxxxx

transmissions
	- xxxxx

"
Class {
	#name : #GLMBrick,
	#superclass : #GLMBrickedMorph,
	#traits : 'GLMBrickPropertiesTrait + GLMBrickGeometryTrait + GLMBrickLayoutTrait + GLMBrickStructureTrait + GLMPhlowTrait',
	#classTraits : 'GLMBrickPropertiesTrait classTrait + GLMBrickGeometryTrait classTrait + GLMBrickLayoutTrait classTrait + GLMBrickStructureTrait classTrait + GLMPhlowTrait classTrait',
	#instVars : [
		'#brickBounds => GLMPhlowSlot',
		'#ports => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #examples }
GLMBrick class >> exampleWithMorphInsideBrick [

	"self exampleWithMorphInsideBrick"

	|foundation brick morph|
	
	foundation := GLMFoundationBrick new.
	foundation extent: 800@400.

	brick := GLMLabelBrick new.
	brick text: 'Hello, I''m a Brick inside another Brick!'.
	brick layoutProperties horizontalPercent: 50.
	brick color: Color lightBlue lighter.

	morph := Morph new.
	morph color: Color lightGreen lighter.
	morph layoutProperties: GLMBrickLayoutProperties new.
	morph layoutProperties horizontalPercent: 50.

	morph addMorphBack: (LabelMorph new
		contents: 'Hello, I''m a Morph inside another Morph inside Brick!';
		hResizing: #spaceFill;
		vResizing: #spaceFill).

	foundation
		addBrickBack: brick;
		addBrickBack: morph;
		doLayout;
		openInWindow.
]

{ #category : #examples }
GLMBrick class >> exampleZindex [

	"self exampleZindex"

	|foundationBrick rootBrick brick1 brick2 brick3|
	
	rootBrick := GLMBrick new.
	rootBrick layoutPolicy: GLMBrickNoLayout new.

	rootBrick color: Color blue.
	
	brick1 := GLMBrick new.
	brick1 color: Color red.
	brick1 brickBounds: (0@0 extent: 300@200).
	brick1 layoutProperties zIndex: 1.
	
	brick2 := GLMBrick new.
	brick2 color: Color green.
	brick2 brickBounds: (50@50 extent: 200@100).
	brick2 layoutProperties zIndex: 2.
	
	brick3 := GLMBrick new.
	brick3 color: Color yellow.
	brick3 brickBounds: (100@100 extent: 100@100).
	brick3 layoutProperties zIndex: 3.
	
	rootBrick
		addBrickBack: brick3;
		addBrickBack: brick2;
		addBrickBack: brick1.
		
	foundationBrick := GLMFoundationBrick new.
	foundationBrick brickRoot: rootBrick.
	foundationBrick openInWindow.
	foundationBrick color: Color pink.
]

{ #category : #utils }
GLMBrick class >> resizeImage: anImage scale: aScale [

	((aScale > (1@0)) | (aScale > (0@1))) ifTrue: [
		^ GLMForm increaseFormExtentCentered: anImage to: (anImage extent * aScale).
	].

	aScale = (1@1) ifTrue: [
		^ anImage
	].
	
	^ anImage magnify: anImage boundingBox by: aScale smoothing: 2.
]

{ #category : #'brick-geometry' }
GLMBrick >> bounds [

	^ self globalBounds
]

{ #category : #'morph-drawing' }
GLMBrick >> changed [
	"Report that the area occupied by this morph should be redrawn.
	Fixed to include submorphs outside the outerBounds."
	
	"fixed direct reference to fullBounds, causing wrong results, because fullBounds are not being updated when parent's or child's bounds changed"
	^ self fullBounds 
		ifNil: [self invalidRect: self privateFullBounds]
		ifNotNil: [self invalidRect: self fullBounds]
]

{ #category : #'morph-drawing' }
GLMBrick >> drawOn: aCanvas [
	super drawOn: aCanvas.
	
	"translating canvas coordinates"
	 (aCanvas isKindOf: ClippingCanvas) ifTrue: [ ^self "no need to draw anything" ].
	self onDraw: (aCanvas copy setOrigin: (aCanvas origin + self globalBounds origin - self brickBounds origin) clipRect: (aCanvas clipRect translateBy: aCanvas origin))
]

{ #category : #'morph-drawing' }
GLMBrick >> drawSubmorphsOn: aCanvas [
	| area zIndexedBricks |
	
	self submorphs isEmpty ifTrue: [ ^ self ].

	"make sure my children will not go away of my inner bounds (we take care about paddings)"
	area := aCanvas clipRect intersect: self globalInnerBounds ifNone: (0 @ 0 extent: 0 @ 0).
	"do smart drawing logic here"
	area width = 0 | (area height = 0) ifTrue: [ 
			"draw nothing"
			^ self ].
	
	zIndexedBricks := OrderedCollection new.
	
	self subbricks
		do: [ :each | 
			| intersection canvas globalBounds |
			each ifNotNil: [ self flag: 'fix nil case'.
			globalBounds := each isBrick
				ifTrue: [ each globalBounds ]
				ifFalse: [ each fullBounds ].
				
			(area intersects: globalBounds) ifTrue: [
				| zIndex |
				zIndex := each layoutProperties zIndex.
				zIndex = 1 ifTrue: [
					"immediately draw ones with the lowest possible z-index.
					With this approach performance doesn't degrade"
					intersection := area intersect: globalBounds ifNone: (0 @ 0 extent: 0 @ 0).
					canvas := aCanvas copyClipRect: intersection.
					each fullDrawOn: canvas ]
					"if z-index is not 1 we add it to collection, in order to sort and draw as second attempt"
				ifFalse: [ zIndexedBricks add: each ] ] ] ].
		
		"z-index drawing section"
		zIndexedBricks sort: [ :first :second | first layoutProperties zIndex < second layoutProperties zIndex ].
		
		zIndexedBricks do: [ :each |
			| intersection canvas globalBounds |
			each ifNotNil: [ self flag: 'fix nil case'.
			globalBounds := each isBrick
				ifTrue: [ each globalBounds ]
				ifFalse: [ each fullBounds ].
				
			intersection := area intersect: globalBounds ifNone: (0 @ 0 extent: 0 @ 0).
			canvas := aCanvas copyClipRect: intersection.
			each fullDrawOn: canvas ] ]
		
]

{ #category : #'morph-common' }
GLMBrick >> fullBounds [

	^ self globalBounds
]

{ #category : #'morph-drawing' }
GLMBrick >> fullDrawOn: aCanvas [
	"fixes bug in canvas, when it tries to draw a morph even if clip rect has size 0"
	aCanvas clipRect width = 0 | (aCanvas clipRect height = 0) ifTrue: [ ^ self ].
	super fullDrawOn: aCanvas.
]

{ #category : #'private-extension' }
GLMBrick >> hasProperty: aSymbol [ 
	
	^ super hasProperty: aSymbol
]

{ #category : #initialization }
GLMBrick >> initialize [
	super initialize.
	color := Color transparent.
	submorphs := OrderedCollection new.
	
	self layoutProperties: GLMBrickLayoutProperties new.
	self layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
	self renderer: GLMBrickRenderer new.
]

{ #category : #'brick-testing' }
GLMBrick >> isFitsInParent [

	^ self owner
		"if our owner is a brick"
		ifNotNil: [ self owner globalBounds containsRect: self globalBounds ]
		"if our owner is a morph"
		ifNil: [ self owner ifNotNil: [ self owner bounds containsRect: self globalBounds ] ifNil: [ ^ true ] ]
]

{ #category : #'brick-layout' }
GLMBrick >> layoutPolicy [

	^ super layoutPolicy
]

{ #category : #'brick-layout' }
GLMBrick >> layoutPolicy: aLayout [
	
	super layoutPolicy: aLayout
]

{ #category : #'brick-layout' }
GLMBrick >> layoutProperties [
	
	^ super layoutProperties
]

{ #category : #'brick-layout' }
GLMBrick >> layoutProperties: aLayoutProperties [ 

	super layoutProperties: aLayoutProperties.
	self layoutProperties brick: self
]

{ #category : #'brick-drawing' }
GLMBrick >> onDraw: aCanvas [

	self renderer render: self on: aCanvas. 
]

{ #category : #'brick-properties-events' }
GLMBrick >> onThemerChanged [

	self changed
]

{ #category : #'brick-structure' }
GLMBrick >> owner [

	^ owner
]

{ #category : #'phlow-transmissions' }
GLMBrick >> ports [

	^ ports  ifNil: [ ports := Dictionary new ]
]

{ #category : #'private-geometry' }
GLMBrick >> privateBounds: aRectangle [

	self wrappedBounds bounds: aRectangle.
	bounds := self globalBounds.
	fullBounds := bounds.
]

{ #category : #'private-structure' }
GLMBrick >> privateOwner: aBrick [

	owner := aBrick
]

{ #category : #'private-structure' }
GLMBrick >> privateSubbricks: aCollection [

	submorphs := aCollection
]

{ #category : #'morph-common' }
GLMBrick >> removeAllMorphs [
	| oldMorphs myWorld |
	"we don't invalidate world"
	myWorld := self world.
	submorphs do: [:m | myWorld ifNotNil: [ m outOfWorld: myWorld ]. m privateOwner: nil].
	oldMorphs := submorphs.
	submorphs := EmptyArray.
	oldMorphs do: [ :m | self removedMorph: m ].

]

{ #category : #'private-extension' }
GLMBrick >> removeProperty: aSymbol [
	
	super removeProperty: aSymbol
]

{ #category : #'private-extension' }
GLMBrick >> setProperty: aSymbol toValue: anObject [
	
	super setProperty: aSymbol toValue: anObject
]

{ #category : #'brick-structure' }
GLMBrick >> subbricks [

	^ self submorphs
]

{ #category : #'morph-common' }
GLMBrick >> submorphAfter [

	^ self subbrickAfter
]

{ #category : #'morph-common' }
GLMBrick >> submorphBefore [

	^ self subbrickBefore
]

{ #category : #'private-extension' }
GLMBrick >> valueOfProperty: aSymbol [
	
	^ super valueOfProperty: aSymbol
]

{ #category : #'private-extension' }
GLMBrick >> valueOfProperty: aSymbol ifAbsent: aBlock [
	
	^ super valueOfProperty: aSymbol ifAbsent: aBlock
]

{ #category : #'private-extension' }
GLMBrick >> valueOfProperty: aSymbol ifAbsentPut: aBlock [ 
	
	^ super valueOfProperty: aSymbol ifAbsentPut: aBlock
]

{ #category : #'brick-geometry' }
GLMBrick >> wrappedBounds [

	^ brickBounds ifNil: [ brickBounds := GLMBrickBounds new ]
]
