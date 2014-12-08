Class {
	#name : #RTExampleSelection,
	#superclass : #RTObject,
	#instVars : [
		'exampleObject',
		'selector'
	],
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #accessing }
RTExampleSelection >> exampleObject [
	^ exampleObject
]

{ #category : #accessing }
RTExampleSelection >> exampleObject: anObject [
	exampleObject := anObject
]

{ #category : #accessing }
RTExampleSelection >> gtDisplayString [

	^ selector asString
]

{ #category : #testing }
RTExampleSelection >> matchesQuery: aSetOfNames [
	| sourceCode |
	
	sourceCode := (self exampleObject class >> self selector) sourceCode asLowercase.
	^ aSetOfNames allSatisfy: [ :each | sourceCode includesSubstring: each ]

]

{ #category : #accessing }
RTExampleSelection >> result [

	^ self exampleObject perform: self selector
]

{ #category : #accessing }
RTExampleSelection >> selector [
	^ selector
]

{ #category : #accessing }
RTExampleSelection >> selector: anObject [
	selector := anObject
]
