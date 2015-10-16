Class {
	#name : #RTExampleFinder,
	#superclass : #GTExampleFinder,
	#category : #'Roassal2GT-Inspector'
}

{ #category : #examples }
RTExampleFinder class >> gtExampleInstance [
	<gtExample>
	<label: 'An example finder on the source #RTExploraBuilder and provider #RTExploraBuilderExample'>
	
	^ self new
		source: RTExploraBuilder;
		provider: RTExploraBuilderExample new;
		subjects: #();
		yourself
]

{ #category : #private }
RTExampleFinder >> class: aClass selector: aSelector method: aMethod to: examples [
	(aSelector beginsWith: 'example') ifFalse: [ ^ self ].
	(aSelector endsWith: 'Icon') ifTrue: [ ^ self ].
	
	self example: (self class: aClass selector: aSelector method: aMethod pragma: (self newImpostorPragma: aMethod)) to: examples
]

{ #category : #private }
RTExampleFinder >> newExample [
	^ RTExampleSelection new
]
