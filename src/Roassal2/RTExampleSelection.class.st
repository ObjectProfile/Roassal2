Class {
	#name : #RTExampleSelection,
	#superclass : #GTExample,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #'as yet unclassified' }
RTExampleSelection >> exampleObject [
]

{ #category : #'as yet unclassified' }
RTExampleSelection >> exampleObject: a [
]

{ #category : #'as yet unclassified' }
RTExampleSelection >> gtDisplayString [
]

{ #category : #accessing }
RTExampleSelection >> iconForm [
	|icon64Mime|
	icon64Mime := self provider perform: (self selector, 'Icon') asSymbol.
	^ TRPlatform current formClass fromBinaryStream: 
		(TRPlatform current  mimeDecodeToBytes: icon64Mime readStream) 
]

{ #category : #'as yet unclassified' }
RTExampleSelection >> result [
]

{ #category : #'as yet unclassified' }
RTExampleSelection >> selector [
]

{ #category : #'as yet unclassified' }
RTExampleSelection >> selector: a [
]
