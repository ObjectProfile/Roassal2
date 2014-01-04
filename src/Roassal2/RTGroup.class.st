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
RTGroup >> elementFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ self detect: [ :el | el model == anObject ] ifNone: [ nil ]
]

{ #category : #public }
RTGroup >> translateBy: aPoint [
	self do: [ :e | e translateBy: aPoint ]
]
