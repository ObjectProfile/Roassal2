Class {
	#name : #CPPFileTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Plugins-CProjectVisualizer'
}

{ #category : #tests }
CPPFileTest >> testFileReference [

	self assert: CPPFile new fileReference notNil
]

{ #category : #tests }
CPPFileTest >> testFilename [
	self assert: CPPFile new filename equals: 'UNAMED'.
	self assert: (CPPFile new filename: 'foo.h'; filename) equals: 'foo.h'.
]

{ #category : #tests }
CPPFileTest >> testLOC [

	self assert: CPPFile new loc equals: -1.
	self assert: (CPPFile new loc: 10; loc) equals: 10
]

{ #category : #tests }
CPPFileTest >> testPrintOn [

	self assert: CPPFile new printString equals: 'a CPPFile<UNAMED>'
]
