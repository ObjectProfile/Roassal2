Class {
	#name : #RTViewTest,
	#superclass : #RTTest,
	#instVars : [
		'view'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTViewTest >> setUp [
	super setUp.
	view := RTView new
]

{ #category : #'as yet unclassified' }
RTViewTest >> testAdding [

	view add: RTElement new.
	self assert: view numberOfElements = 1
]

{ #category : #'as yet unclassified' }
RTViewTest >> testDefault [

	self assert: view numberOfElements = 0
]
