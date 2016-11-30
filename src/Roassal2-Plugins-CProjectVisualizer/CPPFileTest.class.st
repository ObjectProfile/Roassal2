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
CPPFileTest >> testFileReference02 [
	| f1 f2 |
	f1 := CPPFile new.
	f1 filename: '/tmp/foo.c'.
	self assert: f1 fileReference notNil.
	
	f2 := CPPFile new.
	f2 filename: '/tmp/foo.c'.
	self assert: f2 fileReference notNil.
	self assert: f2 fileReference ~~ f1 fileReference.
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
