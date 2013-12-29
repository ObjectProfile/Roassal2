Class {
	#name : #TRFocusTopRight,
	#superclass : #TRFocusing,
	#category : #Trachel
}

{ #category : #hooks }
TRFocusTopRight >> on: canvas [
	| encompassingRectangle |
	encompassingRectangle := self encompassingRectangleOf: canvas shapes. 
	canvas camera translateTo: encompassingRectangle topRight
]
