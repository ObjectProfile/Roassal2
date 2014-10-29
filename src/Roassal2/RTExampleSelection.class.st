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
RTExampleSelection >> selector [
	^ selector
]

{ #category : #accessing }
RTExampleSelection >> selector: anObject [
	selector := anObject
]
