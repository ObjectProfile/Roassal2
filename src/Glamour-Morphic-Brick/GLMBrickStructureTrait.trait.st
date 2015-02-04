"
I declare api and logic to work with structure of a Brick as adding, removing, testing for existance and some more
"
Trait {
	#name : #GLMBrickStructureTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> addAllBricks: aCollection [

	aCollection do: [ :each | self addBrickBack: each ]
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> addBrick: aBrick before: otherBrick [
	| brick link otherLink otherLinkPredeccessor|
	brick := aBrick asBrick.
	
	otherLink := otherBrick brickDoubleLink.
	otherLink = self firstSubbrick brickDoubleLink
		ifTrue: [ ^ self addBrickFirst: brick ].
		
	link := brick asDoubleLink.
	brick brickDoubleLink: link.
	otherLinkPredeccessor := otherLink previousLink.
	otherLink previousLink: link.
	link nextLink: otherLink.
	link previousLink: otherLinkPredeccessor.
	otherLinkPredeccessor nextLink: link.
	
	self subbricks add: brick before: otherBrick.
	
	brick owner: self.
	
	^ aBrick
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> addBrickBack: aBrick [
	|link brick|
	
	brick := aBrick asBrick.
	link := brick asDoubleLink.
	brick brickDoubleLink: link.
	
	self hasSubbricks ifTrue: [
		self lastSubbrick brickDoubleLink nextLink: link.	
		link previousLink: self lastSubbrick brickDoubleLink.
	].
	
	self privateSubbricks: (self subbricks copyWith: brick).
	brick owner: self.
	
	^ aBrick
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> addBrickFirst: aBrick [
	| link head tail brick|
	
	brick := aBrick asBrick.
	head := nil.
	tail := nil.
	self hasSubbricks ifTrue: [
		head := self firstSubbrick brickDoubleLink.
		tail := self lastSubbrick brickDoubleLink ].
	
	link := brick asDoubleLink.
	brick brickDoubleLink: link.
	link nextLink: head.
	head ifNotNil: [ head previousLink: link ].
	
	self privateSubbricks: (self subbricks copyWithFirst: brick).
	brick owner: self.
	
	^ aBrick
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> allSubbricks [
	| all |
	all := OrderedCollection new.
	self allSubbricksDo: [:each | all add: each ].
	^ all
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> allSubbricksDo: aBlock [

	self subbricks do: [:each | 
		aBlock value: each.
		each isBrick ifTrue: [ each allSubbricksDo: aBlock ] ]
]

{ #category : #'brick-structure-converting' }
GLMBrickStructureTrait >> asBrick [
	^ self
]

{ #category : #'brick-structure-converting' }
GLMBrickStructureTrait >> asBrickedMorph [

	^ GLMFoundationBrick new brickRoot: self
]

{ #category : #'private-structure' }
GLMBrickStructureTrait >> brickDoubleLink [

	^ self valueOfProperty: #brickDoubleLink ifAbsentPut: [ nil ]
]

{ #category : #'private-structure' }
GLMBrickStructureTrait >> brickDoubleLink: aDoubleLink [

	self setProperty: #brickDoubleLink toValue: aDoubleLink
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> brickRoot [

	^ self owner ifNotNil: [ self owner brickRoot ] ifNil: [ ^ self ]
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> firstSubbrick [

	^ self subbricks first
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> hasOwner [

	^ self owner isNotNil
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> hasSubbrick: aBrick [

	^ aBrick owner = self
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> hasSubbricks [

	^ self subbricks isEmpty not
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> isBrick [

	^ true
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> isFirstInOwner [

	^ self brickDoubleLink hasPredecessor not
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> isLastInOwner [

	^ self brickDoubleLink hasSuccessor not
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> lastSubbrick [

	^ self subbricks last
]

{ #category : #'brick-structure-converting' }
GLMBrickStructureTrait >> morph [
	^ self
]

{ #category : #'brick-structure-events' }
GLMBrickStructureTrait >> onRemovedFrom: aBrick [
	"is called when brick is removed from aBrick"
	self subbricks do: [ :each | each onRemovedFrom: aBrick ]
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> owner [

	^ self explicitRequirement
]

{ #category : #'private-structure' }
GLMBrickStructureTrait >> owner: aBrick [
	|oldOwner|
	oldOwner := self owner.
	self privateOwner: aBrick.
	aBrick
		ifNotNil: [ self themerChanged ]
		ifNil: [ self onRemovedFrom: oldOwner ]
]

{ #category : #'private-structure' }
GLMBrickStructureTrait >> privateOwner: aBrick [

	^ self explicitRequirement
]

{ #category : #'private-structure' }
GLMBrickStructureTrait >> privateSubbricks: aCollection [

	^ self explicitRequirement
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> removeAllBricks [

	self subbricks do: [:each |
		each brickDoubleLink: nil.
		each owner: nil ].
	self subbricks removeAll
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> removeBrick: aBrick [
	| predecessor successor link head tail index|
	
	link := aBrick brickDoubleLink.
	head := self firstSubbrick brickDoubleLink.
	tail := self lastSubbrick brickDoubleLink.
	
	predecessor := link previousLink.
	successor := link nextLink.
	predecessor
		ifNotNil: [ predecessor nextLink: successor ].
	successor
		ifNotNil: [ successor previousLink: predecessor ].
	link clearLinks.
	
	aBrick brickDoubleLink: nil.
	
	index := self subbricks find: aBrick.
	self privateSubbricks: (self subbricks copyWithoutIndex: index).
	aBrick owner: nil.
	
	^ aBrick
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> subbrickAfter [

	"Return the subbbrick after (behind) me, or nil"
	| link |
	link := self brickDoubleLink.
	link ifNil: [ ^ nil ].
	link nextLink ifNil: [ ^ nil ].
	^ link nextLink value
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> subbrickBefore [

	"Return the subbrick before me, or nil"
	| link |
	link := self brickDoubleLink.
	link ifNil: [ ^ nil ].
	link previousLink ifNil: [ ^ nil ].
	^ link previousLink value
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> subbricks [

	^ self explicitRequirement
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> subbricksCount [

	^ self subbricks size
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> subbricksReverseDo: aBlock [

	self subbricks reverseDo: aBlock
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> withAllSubbricks [

	^ self allSubbricks add: self;
		 yourself
]
