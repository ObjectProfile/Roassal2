"
I declare api and logic to layout Bricks
"
Trait {
	#name : #GLMBrickLayoutTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> doLayout [

	self layoutSubbricks.
	self subbricks do: [ :each | each doLayout ]
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hResizing [

	^ self layout hResizing
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hResizing: aSymbol [

	self layout hResizing: aSymbol
]

{ #category : #'brick-geometry' }
GLMBrickLayoutTrait >> innerBounds [

	^ self explicitRequirement
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isHeightDependsOnChildren [
	"Returns true if my height depends only from my children, otherwise false.
	It means that layouter should first position my children and only then based on their
	sizes set my height"
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isHeightDependsOnMyself [
	"Returns true if my height depends only from myself, otherwise false.
	It means that layouter can immediately calculate and set it"
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isHeightDependsOnParent [
	"Returns true if my height depends only from my parent, otherwise false.
	It means that layouter must first calculate height of my parent and only then my"
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isHeightDependsOnWidth [
	"Returns true if my height depends from my width, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my height"
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isWidthDependsOnChildren [
	"Returns true if my width depends only from my children, otherwise false.
	It means that layouter should first position my children and only then based on their
	sizes set my width"
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isWidthDependsOnHeight [
	"Returns true if my width depends from my height, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my width"
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isWidthDependsOnMyself [
	"Returns true if my width depends only from myself, otherwise false.
	It means that layouter can immediately calculate and set it"
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isWidthDependsOnParent [
	"Returns true if my width depends only from my parent, otherwise false.
	It means that layouter must first calculate width of my parent and only then my"
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layout [
	"Alias for layoutProperies"
	^ self layoutProperties
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layout: aLayout [
	"Alias for layoutPolicy:"
	self layoutPolicy: aLayout
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutPolicy [

	^ self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutPolicy: aLayout [

	self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutProperties [

	^ self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutProperties: aLayoutProperties [

	self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutSubbricks [

	self layoutPolicy layout: self in: self innerBounds
]

{ #category : #'brick-layout-events' }
GLMBrickLayoutTrait >> onLayoutEvent: aLayoutEvent [
	"in case layout want's to trigger any specific event"
]

{ #category : #'brick-layout-events' }
GLMBrickLayoutTrait >> onPrepareLayout [
	"is called before I'm started layouting"
]

{ #category : #'brick-structure' }
GLMBrickLayoutTrait >> subbricks [

	^ self explicitRequirement
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vResizing [

	^ self layout vResizing
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vResizing: aSymbol [

	self layout vResizing: aSymbol
]
