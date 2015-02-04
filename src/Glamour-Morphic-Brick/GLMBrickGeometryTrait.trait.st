"
I declare api and logic to work with geometry of a Brick
"
Trait {
	#name : #GLMBrickGeometryTrait,
	#traits : 'GLMBrickExtensionTrait',
	#classTraits : 'GLMBrickExtensionTrait classTrait',
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> brickBounds [

	^ self wrappedBounds bounds
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> brickBounds: aRectangle [
	"if you want to change brick's position or bounds use only this method!"
	self privateBounds: aRectangle.
	
	self
		updateWidth;
		updateHeight
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> extent [

	self
		updateWidth;
		updateHeight.
		
	^ self brickBounds extent
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> extent: aPoint [
	"actually works only if width or height are not custom"
	self brickBounds: (self brickBounds origin extent: aPoint)
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> globalBounds [
	"converts local bounds to global bounds on fly"
	
	^ self owner ifNotNil: [ self brickBounds translateBy: self owner globalBoundsTranslateFactor ] ifNil: [ self brickBounds ].
]

{ #category : #'private-geometry' }
GLMBrickGeometryTrait >> globalBoundsTranslateFactor [

	^ self owner ifNotNil: [ self owner globalBoundsTranslateFactor + self brickBounds origin ] ifNil: [ 0@0 ]
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> globalInnerBounds [
	"converts local inner bounds to global inner bounds on fly"
	
	^ self owner ifNotNil: [ self innerBounds translateBy: self owner globalBoundsTranslateFactor ] ifNil: [ self innerBounds ].
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> globalOuterBounds [
	"converts local outer bounds to global inner bounds on fly"
	
	^ self owner ifNotNil: [ self outerBounds translateBy: self owner globalBoundsTranslateFactor ] ifNil: [ self outerBounds ].
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> height [

	self updateHeight.
	^ self brickBounds height
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> height: anObject [
	
	self setProperty: #brickGeometryHeightLogic toValue: anObject.
	self updateHeight
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> innerBounds [

	^ (self brickBounds origin + (self paddingLeft @ self paddingTop))
		corner: (self brickBounds corner - ((self paddingRight) @ (self paddingBottom))).
]

{ #category : #'private-geometry' }
GLMBrickGeometryTrait >> isHeightCustom [

	^ (self valueOfProperty: #brickGeometryHeightLogic ifAbsentPut: [ nil ]) isNotNil
]

{ #category : #'private-geometry' }
GLMBrickGeometryTrait >> isWidthCustom [

	^ (self valueOfProperty: #brickGeometryWidthLogic ifAbsentPut: [ nil ]) isNotNil
]

{ #category : #'brick-layout' }
GLMBrickGeometryTrait >> layout [

	^ self explicitRequirement
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> margin: aCollection [

	self layout margin: aCollection
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> marginBottom [

	^ self layout marginBottom
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> marginBottom: anObject [

	self layout marginBottom: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> marginLeft [

	^ self layout marginLeft
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> marginLeft: anObject [

	self layout marginLeft: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> marginRight [

	^ self layout marginRight
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> marginRight: anObject [

	self layout marginRight: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> marginTop [

	^ self layout marginTop
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> marginTop: anObject [

	self layout marginTop: anObject
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> outerBounds [

	^ (self brickBounds origin - ((self marginLeft) @ (self marginTop)))
		corner: (self brickBounds corner + ((self marginRight) @ (self marginBottom)))
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> padding: aCollection [

	self layout padding: aCollection
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> paddingBottom [

	^ self layout paddingBottom
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> paddingBottom: anObject [

	self layout paddingBottom: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> paddingLeft [

	^ self layout paddingLeft
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> paddingLeft: anObject [

	self layout paddingLeft: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> paddingRight [

	^ self layout paddingRight
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> paddingRight: anObject [

	self layout paddingRight: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> paddingTop [

	^ self layout paddingTop
]

{ #category : #'brick-geometry-properties' }
GLMBrickGeometryTrait >> paddingTop: anObject [

	self layout paddingTop: anObject
]

{ #category : #'private-geometry' }
GLMBrickGeometryTrait >> privateBounds: aRectangle [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickGeometryTrait >> removeProperty: aSymbol [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickGeometryTrait >> setProperty: aSymbol toValue: anObject [
	
	^ self explicitRequirement
]

{ #category : #'brick-geometry-transformations' }
GLMBrickGeometryTrait >> translateBy: aPoint [

	self brickBounds: (self brickBounds translateBy: aPoint)
]

{ #category : #'brick-geometry-transformations' }
GLMBrickGeometryTrait >> translateX: anInteger [

	self translateBy: anInteger@0
]

{ #category : #'brick-geometry-transformations' }
GLMBrickGeometryTrait >> translateY: anInteger [

	self translateBy: 0@anInteger
]

{ #category : #'private-geometry' }
GLMBrickGeometryTrait >> updateHeight [

	"no need to care about height, when it's logic is not customized"
	self isHeightCustom ifFalse: [ ^ self ].
	[ self privateBounds: (self brickBounds withHeight: ((self valueOfProperty: #brickGeometryHeightLogic) brickValue: self)) ]
		on: Exception
		do: [ "just skip and do nothing" ]
]

{ #category : #'private-geometry' }
GLMBrickGeometryTrait >> updateWidth [

	"no need to care about width, when it's logic is not customized"
	self isWidthCustom ifFalse: [ ^ self ].
	[ self privateBounds: (self brickBounds withWidth: ((self valueOfProperty: #brickGeometryWidthLogic) brickValue: self)) ]
		on: Exception
		do: [ "just skip and do nothing" ]
]

{ #category : #'private-extension' }
GLMBrickGeometryTrait >> valueOfProperty: aSymbol [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickGeometryTrait >> valueOfProperty: aSymbol ifAbsent: aBlock [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickGeometryTrait >> valueOfProperty: aSymbol ifAbsentPut: aBlock [ 
	
	^ self explicitRequirement
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> width [

	self updateWidth.
	^ self brickBounds width
]

{ #category : #'brick-geometry' }
GLMBrickGeometryTrait >> width: anObject [

	self setProperty: #brickGeometryWidthLogic toValue: anObject.
	self updateWidth
]

{ #category : #'brick-geometry-transformations' }
GLMBrickGeometryTrait >> withHeight: anInteger [

	self brickBounds: (self brickBounds withHeight: anInteger)
]

{ #category : #'brick-geometry-transformations' }
GLMBrickGeometryTrait >> withWidth: anInteger [

	self brickBounds: (self brickBounds withWidth: anInteger)
]

{ #category : #'private-geometry' }
GLMBrickGeometryTrait >> wrappedBounds [

	^ self explicitRequirement
]
