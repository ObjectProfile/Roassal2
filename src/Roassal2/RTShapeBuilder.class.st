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
	self reset
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
RTShapeBuilder >> reset [
	shape := RTNoShape instance
]

{ #category : #accessing }
RTShapeBuilder >> shape [
	"Return the shape currently built"
	^ shape
]

{ #category : #accessing }
RTShapeBuilder >> shape: aRoassalShape [
	shape := aRoassalShape
]
