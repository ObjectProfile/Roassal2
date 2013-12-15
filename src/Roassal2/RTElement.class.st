Class {
	#name : #RTElement,
	#superclass : #RTShapedObject,
	#instVars : [
		'position',
		'model',
		'width',
		'height'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTElement class >> on: anObject [

	^ self new model: anObject; yourself
]

{ #category : #'as yet unclassified' }
RTElement >> addShape: aRTShape [
	shape := aRTShape instance.
	width := width max: (shape widthFor: self).
	height := height max: (shape heightFor: self).
]

{ #category : #'as yet unclassified' }
RTElement >> height [
	^ height
]

{ #category : #'as yet unclassified' }
RTElement >> initialize [
	super initialize.
	position := 0 @ 0.
	width := 0.
	height := 0
]

{ #category : #'as yet unclassified' }
RTElement >> model [
	^ model
]

{ #category : #'as yet unclassified' }
RTElement >> model: anObject [
	"anObject could be any Smalltalk object. Shapes are computed based on that object"
	model := anObject
]

{ #category : #'as yet unclassified' }
RTElement >> position [
	^ position
]

{ #category : #'as yet unclassified' }
RTElement >> translateBy: delta [
	self translateTo: position + delta
]

{ #category : #'as yet unclassified' }
RTElement >> translateTo: newPosition [
	position := newPosition
]

{ #category : #'as yet unclassified' }
RTElement >> width [
	^ width
]
