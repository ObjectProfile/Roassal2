Class {
	#name : #RTShapedObject,
	#superclass : #RTObject,
	#instVars : [
		'shape',
		'announcer',
		'trachelShape',
		'attributes',
		'view',
		'model'
	],
	#category : #'Roassal2-Core'
}

{ #category : #adding }
RTShapedObject >> + aRTShape [
	"Add a Roassal shape, class or instance of it. Not that a Trachel cannot be given as argument"
	self addShape: aRTShape instance
]

{ #category : #adding }
RTShapedObject >> @ anInteractionClassOrInstance [
	"Add an interaction to the node"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #adding }
RTShapedObject >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance initializeElement: self
]

{ #category : #adding }
RTShapedObject >> addShape: aRTShape [
	(shape class == RTNoShape)  
		ifTrue: [	shape := aRTShape instance ]
		ifFalse: [ shape := RTCompositeShape with: shape with: aRTShape ].
	trachelShape := shape trachelShapeFor: self

]

{ #category : #adding }
RTShapedObject >> addedIn: aView [
	self subclassReponsibility
]

{ #category : #announce }
RTShapedObject >> announce: evt [
	self announcer announce: evt
]

{ #category : #accessing }
RTShapedObject >> announcer [
	announcer ifNil: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #attributes }
RTShapedObject >> attributeAt: aKey [
	^ self attributes at: aKey
]

{ #category : #attributes }
RTShapedObject >> attributeAt: aKey ifAbsentPut: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsentPut: aBlockClosure 
]

{ #category : #attributes }
RTShapedObject >> attributeAt: aKey put: value [
	^ self attributes at: aKey put: value
]

{ #category : #attributes }
RTShapedObject >> attributes [
	"Return the list of attributes associated to the element. Attributes are useful for caching values"

	^ attributes ifNil: [ attributes := Dictionary new ]
]

{ #category : #attributes }
RTShapedObject >> hasAttributes [ 
	"Return true if at least one attributes is present"
	
	^ attributes notNil and: [ attributes notEmpty ]
]

{ #category : #initialization }
RTShapedObject >> initialize [
	super initialize.
	shape := RTNoShape new
]

{ #category : #accessing }
RTShapedObject >> model [
	^ model
]

{ #category : #accessing }
RTShapedObject >> model: anObject [
	"anObject could be any Smalltalk object. Shapes are computed based on that object"
	model := anObject
]

{ #category : #interaction }
RTShapedObject >> on: evt do: aBlock [
	self announcer on: evt do: aBlock
]

{ #category : #rendering }
RTShapedObject >> renderOn: trachelCanvas [
	trachelShape isNil ifTrue: [ self error: 'Cannot add an element without a shape. Add a shape to myself, using + or addShape:' . ^ self ].
	trachelCanvas addShape: trachelShape.
	trachelShape announcer: self announcer.
	trachelShape element: self
]

{ #category : #accessing }
RTShapedObject >> shape [
	^ shape
]

{ #category : #accessing }
RTShapedObject >> trachelShape [
	^ trachelShape
]

{ #category : #updating }
RTShapedObject >> update [
	"Update the trachel shape and reset the path. This has the effect of moving the visual widget"
	shape updateFor: self.
	trachelShape ifNotNil: [ trachelShape resetPath ]

]

{ #category : #accessing }
RTShapedObject >> view [
	^ view
]

{ #category : #accessing }
RTShapedObject >> view: aRoassalView [
	view := aRoassalView
]
