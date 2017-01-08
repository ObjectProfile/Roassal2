Class {
	#name : #JVFileTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Plugins-JavaVisualizer'
}

{ #category : #tests }
JVFileTest >> testFileReference [

	self assert: JVFile new fileReference notNil
]

{ #category : #tests }
JVFileTest >> testFileReference02 [
	| f1 f2 |
	f1 := JVFile new.
	f1 filename: '/tmp/foo.java'.
	self assert: f1 fileReference notNil.
	
	f2 := JVFile new.
	f2 filename: '/tmp/foo.java'.
	self assert: f2 fileReference notNil.
	self assert: f2 fileReference ~~ f1 fileReference.
]

{ #category : #tests }
JVFileTest >> testFilename [
	self assert: CPPFile new filename equals: 'UNAMED'.
	self assert: (CPPFile new filename: 'foo.java'; filename) equals: 'foo.java'.
]

{ #category : #tests }
JVFileTest >> testLOC [

	self assert: JVFile new loc equals: -1.
	self assert: (JVFile new loc: 10; loc) equals: 10
]

{ #category : #tests }
JVFileTest >> testPrintOn [

	self assert: JVFile new printString equals: 'a JVFile<UNAMED>'
]
