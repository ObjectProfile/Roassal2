Class {
	#name : #RTShapedObject,
	#superclass : #RTAnnounceableObject,
	#instVars : [
		'shape',
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

{ #category : #attributes }
RTShapedObject >> attributeAt: aKey [
	^ self attributes at: aKey
]

{ #category : #attributes }
RTShapedObject >> attributeAt: aKey ifAbsent: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsent: aBlockClosure 
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
RTShapedObject >> hasAttribute: aKey [ 
	"Return true if attributes includes aKey"
	
	^ attributes notNil and: [ attributes includesKey: aKey ]
]

{ #category : #attributes }
RTShapedObject >> hasAttributes [ 
	"Return true if at least one attributes is present"
	
	^ attributes notNil and: [ attributes notEmpty ]
]

{ #category : #initialization }
RTShapedObject >> initialize [
	super initialize.
	shape := RTNoShape new.
	trachelShape := TRNoShape instance
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

{ #category : #attributes }
RTShapedObject >> removeAttributeAt: aKey [
	^ self attributes removeKey: aKey
]

{ #category : #attributes }
RTShapedObject >> removeAttributeAt: aKey ifAbsent: anErrorBlock [
	^ self attributes removeKey: aKey ifAbsent: anErrorBlock
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

{ #category : #signalling }
RTShapedObject >> signalUpdate [
	^ trachelShape signalUpdate
]

{ #category : #announce }
RTShapedObject >> testCaseAnnounce: evt [
	"It is used for Test Cases because in that case evt does not know where it has been announced."
	| evtInstance |
	evtInstance := evt shape: self trachelShape.
	self announce: evtInstance
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

{ #category : #rendering }
RTShapedObject >> updateShape [
	shape updateFor: self.
]

{ #category : #accessing }
RTShapedObject >> view [
	^ view
]

{ #category : #accessing }
RTShapedObject >> view: aRoassalView [
	view := aRoassalView
]
