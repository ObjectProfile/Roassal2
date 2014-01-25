Class {
	#name : #TRFocusing,
	#superclass : #TRObject,
	#category : #'Trachel-Core'
}

{ #category : #public }
TRFocusing class >> on: canvas [
	^ self new on: canvas
]

{ #category : #utility }
TRFocusing >> encompassingRectangleOf: shapes [
	| encompassingRectangle |
	encompassingRectangle := shapes anyOne encompassingRectangle.
	shapes do: [ :e | encompassingRectangle := encompassingRectangle merge: e encompassingRectangle ].
	^ encompassingRectangle 
]

{ #category : #hooks }
TRFocusing >> on: canvas [
	self subclassResponsibility
]
