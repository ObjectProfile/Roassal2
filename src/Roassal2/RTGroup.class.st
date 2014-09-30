Class {
	#name : #RTGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'attributes'
	],
	#category : #'Roassal2-Core'
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

{ #category : #resizing }
RTGroup >> extent: newExtentT [

	| newExtent oldExtent encompassingRectangle |
	newExtent := newExtentT max: 1 @ 1.
	encompassingRectangle := self encompassingRectangle.
	oldExtent := encompassingRectangle extent.
	
	"Make top left to 0 @ 0"
	self translateBy: encompassingRectangle topLeft negated.
	
	"Resizing and moving the position of each element"
	self do: [ :element |
		element translateTo: (element position * newExtent / oldExtent).
		element extent: (element extent * newExtent / oldExtent).
	].
	
	"Move back all the element to the original position"
	self translateBy: encompassingRectangle topLeft.
	
	
	
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

{ #category : #resizing }
RTGroup >> height: newHeight [
	self extent: self extent x @ newHeight
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

{ #category : #actions }
RTGroup >> pushBack [
	self do: #pushBack
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

{ #category : #actions }
RTGroup >> updateShape [
	self do: #updateShape
]

{ #category : #accessing }
RTGroup >> view [
	"Return the view of the group. This method assumes that all the elements of group belong to the same view"
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

{ #category : #resizing }
RTGroup >> width: newWidth [

	self extent: newWidth @ self extent y
]
