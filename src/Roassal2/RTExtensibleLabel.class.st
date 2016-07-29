"
My instances can create Text in roassal uses a rectangle to fit.
"
Class {
	#name : #RTExtensibleLabel,
	#superclass : #RTLabel,
	#category : #'Roassal2-Shapes'
}

{ #category : #hooks }
RTExtensibleLabel >> trachelShapeClass [
	^ TRExtensibleLabelShape
]

{ #category : #hooks }
RTExtensibleLabel >> trachelShapeFor: anElement [
	|  shape |	
	shape := TRExtensibleLabelShape new.
	shape text: (self textFor: anElement);
			color: (self colorFor: anElement);
			position: anElement position;
			fontSize: (self heightFor: anElement).
	^ shape
]
