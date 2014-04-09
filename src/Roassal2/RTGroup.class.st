Class {
	#name : #RTGroup,
	#superclass : #OrderedCollection,
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTGroup >> + aShape [
	self do: [ :e | e + aShape ]
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
RTGroup >> addedIn: view [
	self do: [ :e | view add: e ]
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

{ #category : #public }
RTGroup >> height [
	^ self encompassingRectangle height
]

{ #category : #accessing }
RTGroup >> position [
	^ self encompassingRectangle center
]

{ #category : #public }
RTGroup >> remove [
	self do: #remove
]

{ #category : #public }
RTGroup >> renderOn: trCanvas [ 
	"Not sure whether this method is necessary..."
	self do: [ :e | e renderOn: trCanvas ]
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

{ #category : #public }
RTGroup >> when: evt do: callback [
	self do: [ :e | e when: evt do: callback ]
]

{ #category : #public }
RTGroup >> width [
	^ self encompassingRectangle width
]
