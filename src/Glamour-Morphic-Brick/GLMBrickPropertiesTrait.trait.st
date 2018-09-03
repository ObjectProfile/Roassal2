"
I declare api and logic to work with properties of a Brick, such as color, shadow, renderer and more
"
Trait {
	#name : #GLMBrickPropertiesTrait,
	#traits : 'GLMBrickExtensionTrait',
	#classTraits : 'GLMBrickExtensionTrait classTrait',
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> color [

	^ self valueOfProperty: #brickBackgroundColor ifAbsent: [ self themer backgroundColor ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> color: aColor [

	self setProperty: #brickBackgroundColor toValue: aColor
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> data [

	^ self valueOfProperty: #brickDataObject ifAbsentPut: [ nil ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> data: anObject [

	^ self setProperty: #brickDataObject  toValue:  anObject
]

{ #category : #'brick-properties-testing' }
GLMBrickPropertiesTrait >> isColorSet [

	^ self hasProperty: #brickBackgroundColor
]

{ #category : #'brick-properties-events' }
GLMBrickPropertiesTrait >> onThemerChanged [

]

{ #category : #'private-properties' }
GLMBrickPropertiesTrait >> privateThemer [

	^ self valueOfProperty: #brickThemer ifAbsentPut: [ nil ]
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> removeProperty: aSymbol [
	
	^ self explicitRequirement
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> renderer [

	^ self valueOfProperty: #brickRenderer ifAbsentPut: [ nil ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> renderer: aRenderer [

	self setProperty: #brickRenderer toValue: aRenderer
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> setProperty: aSymbol toValue: anObject [
	
	^ self explicitRequirement
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> shadowColor [

	^ self valueOfProperty: #brickShadowColor ifAbsentPut: [ Color transparent ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> shadowColor: aColor [

	self setProperty: #brickShadowColor toValue: aColor
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> shadowWidth [

	^ self valueOfProperty: #brickShadowWidth ifAbsentPut: [ 0 ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> shadowWidth: anInteger [

	self setProperty: #brickShadowWidth toValue: anInteger
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> themer [

	^ self privateThemer
		ifNotNil: [ self privateThemer ]
		ifNil: [ self hasOwner
			ifTrue: [ self owner themer ]
			ifFalse: [ self theme brickThemer ] ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> themer: aThemer [

	self setProperty: #brickThemer toValue: aThemer.
	self themerChanged
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> themerChanged [

	self onThemerChanged.
	self subbricks do: #themerChanged
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> valueOfProperty: aSymbol [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> valueOfProperty: aSymbol ifAbsent: aBlock [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> valueOfProperty: aSymbol ifAbsentPut: aBlock [ 
	
	^ self explicitRequirement
]
