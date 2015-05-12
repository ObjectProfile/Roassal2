"
A RTVisitor is a simple visitor.

"
Class {
	#name : #RTVisitor,
	#superclass : #RTObject,
	#instVars : [
		'names'
	],
	#category : #'Roassal2-Core'
}

{ #category : #initialization }
RTVisitor >> initialize [
	super initialize.
	names := Dictionary new.
]

{ #category : #utils }
RTVisitor >> nameFor: anElement [

	(names includesKey: anElement) ifTrue: [ 
		^ names at: anElement ] ifFalse: [ 
		| n |
		n := names size printStringHex.
		names at: anElement put: n.
		^ n.
	 ]
]

{ #category : #visitor }
RTVisitor >> visitCanvas: aCanvas [
]

{ #category : #visitor }
RTVisitor >> visitView: aView [
	aView canvas accept: self
]
