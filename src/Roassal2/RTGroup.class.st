Class {
	#name : #RTGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'attributes'
	],
	#category : 'Roassal2-Core'
}

{ #category : #public }
RTGroup >> + aShape [
	self addShape: aShape
]

{ #category : #public }
RTGroup >> @ interaction [
	self do: [ :e | e @ interaction ]
]

{ #category : #visitor }
RTGroup >> accept: aRTVisitor [
	self  do: [ :e | e trachelShape accept: aRTVisitor]
]

{ #category : #public }
RTGroup >> addShape: aShape [
	self do: [ :e | e addShape: aShape ]
]

{ #category : #public }
RTGroup >> addedIn: view [
	self do: [ :e | view add: e ]
]

{ #category : #converting }
RTGroup >> asGroup [
	^ self
]

{ #category : #attributes }
RTGroup >> attributeAt: aKey [
	^ self attributes at: aKey
]

{ #category : #attributes }
RTGroup >> attributeAt: aKey ifAbsent: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsent: aBlockClosure 
]

{ #category : #attributes }
RTGroup >> attributeAt: aKey ifAbsentPut: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsentPut: aBlockClosure 
]

{ #category : #attributes }
RTGroup >> attributes [
	"Return the list of attributes associated to the element. Attributes are useful for caching values"

	^ attributes ifNil: [ attributes := Dictionary new ]
]

{ #category : #public }
RTGroup >> center [
	^ self encompassingRectangle center
]

{ #category : #public }
RTGroup >> elementFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ self detect: [ :el | el model = anObject ] ifNone: [ nil ]
]

{ #category : #public }
RTGroup >> encompassingRectangle [
	^ self 
		ifEmpty: [ (0 @ 0) corner: (0 @ 0) ]
		ifNotEmpty: [ Rectangle merging: (self collect: #encompassingRectangle) ]
]

{ #category : #public }
RTGroup >> extent [
	^ self encompassingRectangle extent
]

{ #category : #attributes }
RTGroup >> hasAttribute: aKey [ 
	"Return true if attributes includes aKey"
	
	^ attributes notNil and: [ attributes includesKey: aKey ]
]

{ #category : #attributes }
RTGroup >> hasAttributes [ 
	"Return true if at least one attributes is present"
	
	^ attributes notNil and: [ attributes notEmpty ]
]

{ #category : #public }
RTGroup >> height [
	^ self encompassingRectangle height
]

{ #category : #public }
RTGroup >> leftMostElement [
	"Return the element located on the most left"
	| t |
	t := self first.
	self do: [ :e | (t position x > e position x) ifTrue: [ t := e ] ].
	^ t
]

{ #category : #accessing }
RTGroup >> model [
	^ 'group'
]

{ #category : #accessing }
RTGroup >> position [
	^ self encompassingRectangle center
]

{ #category : #public }
RTGroup >> remove [
	self do: #remove
]

{ #category : #attributes }
RTGroup >> removeAttributeAt: aKey [
	^ self attributes removeKey: aKey
]

{ #category : #attributes }
RTGroup >> removeAttributeAt: aKey ifAbsent: anErrorBlock [
	^ self attributes removeKey: aKey ifAbsent: anErrorBlock
]

{ #category : #public }
RTGroup >> renderOn: trCanvas [ 
	"Not sure whether this method is necessary..."
	self do: [ :e | e renderOn: trCanvas ]
]

{ #category : #public }
RTGroup >> rightMostElement [
	"Return the element located on the most left"
	| t |
	t := self first.
	self do: [ :e | (t position x < e position x) ifTrue: [ t := e ] ].
	^ t
]

{ #category : #public }
RTGroup >> rotateByDegrees: degree [
	self do: [ :e | e rotateByDegrees: degree ]
]

{ #category : #signalling }
RTGroup >> signalUpdate [
	self ifEmpty: [ ^ self ].
	self first signalUpdate.
]

{ #category : #public }
RTGroup >> translateBy: aPoint [
	self do: [ :e | e translateBy: aPoint ]
]

{ #category : #public }
RTGroup >> translateTo: aPosition [
	| center |
	center := self encompassingRectangle center.
	self translateBy: (aPosition - center)
]

{ #category : #public }
RTGroup >> translateTopLeftTo: aPosition [
	| center |
	center := self encompassingRectangle topLeft.
	self translateBy: (aPosition - center)
]

{ #category : #accessing }
RTGroup >> view [
	^ self anyOne view
]

{ #category : #public }
RTGroup >> when: evt do: callback [
	self do: [ :e | e when: evt do: callback ]
]

{ #category : #public }
RTGroup >> width [
	^ self encompassingRectangle width
]
