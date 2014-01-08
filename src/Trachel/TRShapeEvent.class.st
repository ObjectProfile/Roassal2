Class {
	#name : #TRShapeEvent,
	#superclass : #TREvent,
	#instVars : [
		'shape'
	],
	#category : #Trachel
}

{ #category : #accessing }
TRShapeEvent >> element [
	"Could be any object"
	^ self shape element
]

{ #category : #accessing }
TRShapeEvent >> shape [
	
	^ shape
]

{ #category : #accessing }
TRShapeEvent >> shape: aTrachelShape [
	
	shape := aTrachelShape
]
