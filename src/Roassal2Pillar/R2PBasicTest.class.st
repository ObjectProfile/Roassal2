Class {
	#name : #R2PBasicTest,
	#superclass : #TestCase,
	#category : #Roassal2Pillar
}

{ #category : #tests }
R2PBasicTest >> testAccessingScript [

	| doc script |
	doc := PRDocumentParser parse: 'HelloWorld
[[[language=smalltalk|hello=world
			1 + 2
]]]'.
	self assert: doc class equals: PRDocument.
	
	self assert: doc children first children size equals: 3.
	script := doc children first children third.
	self assert: (script parameterAt: 'hello' ifAbsent: [ nil ]) equals: 'world'.
	self deny: script isEvaluated.
]

{ #category : #tests }
R2PBasicTest >> testEvaluatingScript [

	| doc script |
	doc := PRDocumentParser parse: '100 factorial =
[[[language=smalltalk|eval=true
			stream nextPutAll: 100 factorial asString
]]]'.
	
	script := doc children first children third.
	self assert: script isEvaluated.
]
