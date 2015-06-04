"
A class to have nice scales checks subclasses
"
Class {
	#name : #RTScale,
	#superclass : #RTObject,
	#category : #'Roassal2-Experimental'
}

{ #category : #'instance creation' }
RTScale class >> linear [
	^ RTScaleLinear new.
]
