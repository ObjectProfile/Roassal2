"
A ROMouseClick is xxxxxxxxx.

Instance Variables
	commandKeyPressed:		<Object>
	controlKeyPressed:		<Object>
	shiftKeyPressed:		<Object>

commandKeyPressed
	- xxxxx

controlKeyPressed
	- xxxxx

shiftKeyPressed
	- xxxxx

"
Class {
	#name : #TRMouseClick,
	#superclass : #TRAbstractMouseEvent,
	#instVars : [
		'commandKeyPressed',
		'controlKeyPressed',
		'shiftKeyPressed'
	],
	#category : #'Trachel-Core'
}

{ #category : #accessing }
TRMouseClick >> commandKeyPressed [
	^ commandKeyPressed
]

{ #category : #accessing }
TRMouseClick >> commandKeyPressed: anObject [
	commandKeyPressed := anObject
]

{ #category : #accessing }
TRMouseClick >> controlKeyPressed [
	^ controlKeyPressed
]

{ #category : #accessing }
TRMouseClick >> controlKeyPressed: anObject [
	controlKeyPressed := anObject
]

{ #category : #accessing }
TRMouseClick >> initialize [ 
	super initialize.
	commandKeyPressed := false.
	controlKeyPressed := false.
	shiftKeyPressed := false.
]

{ #category : #accessing }
TRMouseClick >> shiftKeyPressed [
	^ shiftKeyPressed
]

{ #category : #accessing }
TRMouseClick >> shiftKeyPressed: anObject [
	shiftKeyPressed := anObject
]
