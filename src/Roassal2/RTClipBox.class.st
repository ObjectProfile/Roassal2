"
I am a simple class to clip a part of the canvas
"
Class {
	#name : #RTClipBox,
	#superclass : #RTBox,
	#category : #'Roassal2-Experimental'
}

{ #category : #hooks }
RTClipBox >> trachelShapeClass [
	^ TRClipBoxShape
]

{ #category : #rendering }
RTClipBox >> updateFor: anElement trachelShape: trachelShape [
	super updateFor: anElement trachelShape: trachelShape
]
