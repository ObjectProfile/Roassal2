Class {
	#name : #RTExampleSelection,
	#superclass : #GTExample,
	#category : #'Roassal2-ExampleBrowser'
}

{ #category : #accessing }
RTExampleSelection >> iconForm [
	|icon64Mime|
	icon64Mime := self provider perform: (self selector, 'Icon') asSymbol.
	^ TRPlatform current formClass fromBinaryStream: 
		(TRPlatform current  mimeDecodeToBytes: icon64Mime readStream) 
]
