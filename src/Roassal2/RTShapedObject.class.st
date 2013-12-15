Class {
	#name : #RTShapedObject,
	#superclass : #RTObject,
	#instVars : [
		'shape'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTShapedObject >> initialize [
	super initialize.
	shape := RTNull new
]

{ #category : #'as yet unclassified' }
RTShapedObject >> renderOn: trachelCanvas [

	shape renderOn: trachelCanvas for: self
]

{ #category : #'as yet unclassified' }
RTShapedObject >> shape [
	^ shape
]
