"
I'm a mouse wheel scrolling event.

direction
	- #up or #down

"
Class {
	#name : #TRMouseWheelEvent,
	#superclass : #TRAbstractMouseEvent,
	#instVars : [
		'direction'
	],
	#category : #'Trachel-Core'
}

{ #category : #accessing }
TRMouseWheelEvent >> direction [
	^ direction
]

{ #category : #accessing }
TRMouseWheelEvent >> direction: anObject [
	direction := anObject
]
