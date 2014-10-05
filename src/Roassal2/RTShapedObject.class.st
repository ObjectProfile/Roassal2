Class {
	#name : #RTShapedObject,
	#superclass : #RTAnnounceableObject,
	#instVars : [
		'shape',
		'trachelShape',
		'attributes',
		'view',
		'model',
		'isFixed'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTShapedObject class >> model: anObject [
	^ self new model: anObject
]

{ #category : #adding }
RTShapedObject >> + aRTShape [
	"Add a Roassal shape, class or instance of it. Not that a Trachel cannot be given as argument"
	self addShape: aRTShape instance
]

{ #category : #adding }
RTShapedObject >> addShape: aRTShape [
	(shape class == RTNoShape)  
		ifTrue: [	shape := aRTShape instance ]
		ifFalse: [ shape := RTMultiCompositeShape with: shape with: aRTShape ].
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

{ #category : #'accessing trachel' }
RTShapedObject >> color [
	^ trachelShape color
]

{ #category : #'accessing trachel' }
RTShapedObject >> color: aColor [ 
	^ trachelShape color: aColor
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
	trachelShape := TRNoShape instance.
	isFixed := false
]

{ #category : #testing }
RTShapedObject >> isFixed [
	"True if the element is added in the trachel canvas as a fixed shape. 
	If this is the case, then it will remain fixed when drag and dropping the view"
	^ isFixed
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

{ #category : #actions }
RTShapedObject >> pushBack [
	"Move the shaped object back"
	self trachelShape pushBack
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
		
	"Trachel shape use the same announcer than myself"
	trachelShape announcer: self announcer.
	
	"Each trachel shape knows the element. Note that this is not a static dependency between Trachel and Roassal since in Trachel, this element could be any object"
	trachelShape element: self.

	"This ifTrue:ifFalse: is not great. However it simplifies the design"
	self isFixed
		ifTrue: [ trachelCanvas addFixedShape: trachelShape ]
		ifFalse: [ trachelCanvas addShape: trachelShape ].

]

{ #category : #transformations }
RTShapedObject >> scaleBy: aPoint [ 
	trachelShape scaleBy: aPoint
]

{ #category : #actions }
RTShapedObject >> setAsFixed [
	"I will remain fixed when drag and dropping the view"
	isFixed := true 
]

{ #category : #actions }
RTShapedObject >> setAsNotFixed [
	"I will move when dragging the view"
	isFixed := false
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
