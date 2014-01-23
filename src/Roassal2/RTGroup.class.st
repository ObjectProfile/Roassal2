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
	^ Rectangle merging: (self collect: #encompassingRectangle)
]

{ #category : #public }
RTGroup >> height [
	^ self encompassingRectangle height
]

{ #category : #public }
RTGroup >> on: evt do: callback [
	self do: [ :e | e on: evt do: callback ]
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
	| topLeft |
	topLeft := self encompassingRectangle topLeft.
	self translateBy: (aPosition - topLeft)
]

{ #category : #public }
RTGroup >> width [
	^ self encompassingRectangle width
]
