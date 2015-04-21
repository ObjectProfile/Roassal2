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

{ #category : #accessing }
RTExampleSelection >> iconForm [
	|icon64Mime|
	icon64Mime := self exampleObject perform: (self selector, 'Icon') asSymbol.
	^ TRPlatform current formClass fromBinaryStream: 
		(TRPlatform current  mimeDecodeToBytes: icon64Mime readStream) 
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
