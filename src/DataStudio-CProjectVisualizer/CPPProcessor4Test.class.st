Class {
	#name : #CPPProcessor4Test,
	#superclass : #RTTest,
	#instVars : [
		'p'
	],
	#category : #'DataStudio-CProjectVisualizer-Tests'
}

{ #category : #'code example' }
CPPProcessor4Test >> fileFoo_C [

^ '#include "foo.h"
#include <stdio.h>

void foo(void) {
  printf("This is super cool!\n");
}
'
]

{ #category : #'code example' }
CPPProcessor4Test >> fileFoo_H [

^ '#ifndef FOO_H
#define FOO_H

void foo(void);

#endif
'
]

{ #category : #'code example' }
CPPProcessor4Test >> fileMain_C [

^ '   #include "foo.h"

int main(int argc, char* argv[]) {
  foo();
  return 0;
}
'
]

{ #category : #initialization }
CPPProcessor4Test >> setUp [
	super setUp.
	p := CPPProcessor new
]

{ #category : #tests }
CPPProcessor4Test >> testDependencies [

	| main header |
	p processFileAsString: self fileFoo_C named: 'foo.c'.
	p processFileAsString: self fileFoo_H named: 'foo.h'.
	p processFileAsString: self fileMain_C named: 'main.c'.
	p resolveDependencies.
	
	self assert: p numberOfHeaders equals: 1.
	self assert: p numberOfModules equals: 2.

	main := p moduleNamed: 'main.c'.
	header := p headerNamed: 'foo.h'.
	self assert: main filename equals: 'main.c'.
	
	self assert: main includedNames size equals: 1.
	
	self assert: main outgoingHeaders size equals: 1.
	self assert: main outgoingHeaders first equals: header.
	 
]
