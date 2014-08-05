Class {
	#name : #TRAbstractMouseClick,
	#superclass : #TRAbstractMouseEvent,
	#instVars : [
		'commandKeyPressed',
		'controlKeyPressed',
		'shiftKeyPressed'
	],
	#category : #'Trachel-Core'
}

{ #category : #accessing }
TRAbstractMouseClick >> commandKeyPressed [
	^ commandKeyPressed
]

{ #category : #accessing }
TRAbstractMouseClick >> commandKeyPressed: anObject [
	commandKeyPressed := anObject
]

{ #category : #accessing }
TRAbstractMouseClick >> controlKeyPressed [
	^ controlKeyPressed
]

{ #category : #accessing }
TRAbstractMouseClick >> controlKeyPressed: anObject [
	controlKeyPressed := anObject
]

{ #category : #accessing }
TRAbstractMouseClick >> initialize [ 
	super initialize.
	commandKeyPressed := false.
	controlKeyPressed := false.
	shiftKeyPressed := false.
]

{ #category : #accessing }
TRAbstractMouseClick >> shiftKeyPressed [
	^ shiftKeyPressed
]

{ #category : #accessing }
TRAbstractMouseClick >> shiftKeyPressed: anObject [
	shiftKeyPressed := anObject
]
