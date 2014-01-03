Class {
	#name : #RTShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'shape'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'reflective operations' }
RTShapeBuilder >> doesNotUnderstand: aMessage [
	"we simply forward the messages we do not understand
	to the actual shape implementation"
	self shape 
		perform: aMessage selector 
		withArguments: aMessage arguments
]

{ #category : #initialization }
RTShapeBuilder >> initialize [
	shape := RTNull new
]

{ #category : #shapes }
RTShapeBuilder >> line [
	self shape: RTLine new
]

{ #category : #shapes }
RTShapeBuilder >> rectangle [
	self shape: RTBox new
]

{ #category : #accessing }
RTShapeBuilder >> shape [
	^ shape
]

{ #category : #accessing }
RTShapeBuilder >> shape: anObject [
	shape := anObject
]
