Class {
	#name : #RTExampleFinder,
	#superclass : #AnObsoleteGTExampleFinder,
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
	" allow gt examples using pragmas and old-style roassal examples at the same time "
		
	aMethod pragmas size > 0 ifTrue: [ 
		| previousSize |
		previousSize := examples size.
		super class: aClass selector: aSelector method: aMethod to: examples.
		examples size > previousSize ifTrue: [ ^ self ]. " we have found some examples in this method, no need to continue " ].
	
	(aSelector beginsWith: 'example') ifFalse: [ ^ self ].
	(aSelector endsWith: 'Icon') ifTrue: [ ^ self ].
	
	self example: (self class: aClass selector: aSelector method: aMethod pragma: (self newImpostorPragma: aMethod)) to: examples
]

{ #category : #private }
RTExampleFinder >> newExample [
	^ RTExampleSelection new
]
