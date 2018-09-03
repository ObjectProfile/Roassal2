Class {
	#name : #CPPProcessor3Test,
	#superclass : #RTTest,
	#instVars : [
		'p'
	],
	#category : #'Roassal2-Plugins-CProjectVisualizer-Tests'
}

{ #category : #'code example' }
CPPProcessor3Test >> file01 [
	^ 
'
#include "util/foo.h"

void main() { 
}
'
]

{ #category : #'code example' }
CPPProcessor3Test >> file02 [
	^ 
'
// Foo.hpp
'
]

{ #category : #'code example' }
CPPProcessor3Test >> file03 [
	^ 
'
#include <foo.h>
#include <foo2.h>
#include <bar.h>

void zork() { 
}
'
]

{ #category : #'code example' }
CPPProcessor3Test >> file04 [
	^ 
'
// bar.h
#include <foo.h>
#include <foo2.h>

void zork();
'
]

{ #category : #'code example' }
CPPProcessor3Test >> file05 [
	^ 
'
#include "foo.h"

'
]

{ #category : #'code example' }
CPPProcessor3Test >> file06NodDotC [
	^ 
'
#include "Nod.h"
#include <nuclear>

#include "message/input/ServoID.h"
#include "message/motion/Script.h"
#include "message/behaviour/Action.h"
#include "message/support/Configuration.h"
#include "message/behaviour/Nod.h"

'
]

{ #category : #'code example' }
CPPProcessor3Test >> file07NodDotH [
	^ 
'
#ifndef MESSAGE_BEHAVIOUR_NOD_H
#define MESSAGE_BEHAVIOUR_NOD_H

#include <armadillo>

namespace message {
namespace behaviour {
    struct Nod {
    	Nod(bool value) : value(value) {
    	}
    	
    	bool value;
    };

}
}

#endif


'
]

{ #category : #running }
CPPProcessor3Test >> setUp [
	super setUp.
	p := CPPProcessor new
]

{ #category : #tests }
CPPProcessor3Test >> testBasic [
	| m h |
	p processFileAsString: self file01 named: 'util/foo.cc'.
	p processFileAsString: self file02 named: 'util/foo.h'.
	p resolveDependencies.
	
	self assert: p numberOfHeaders equals: 1.
	self assert: p numberOfModules equals: 1.
	
	m := p modules anyOne.
	h := p headers anyOne.
	self assert: m loc equals: self file01 lines size.
	self assert: h loc equals: self file02 lines size.
	self assert: m includedNames size equals: 1.
	self assert: m includedNames anyOne equals: 'util/foo.h'.
	
	self assert: m baseFilenameWithoutExtension equals: 'foo'.
	self assert: h baseFilenameWithoutExtension equals: 'foo'.	
	
	self assert: m hasHeader.
	self assert: m header equals: h.
	self assert: h hasModule.
	self assert: h module equals: m.

	self assert: h incomingHeaders isEmpty.
	self assert: h outgoingHeaders isEmpty.

]

{ #category : #tests }
CPPProcessor3Test >> testBasic01 [
	| m h |
	p processFileAsString: self file01 named: 'foo.c'.
	p processFileAsString: self file02 named: 'util/foo.h'.
	p resolveDependencies.
	
	self assert: p numberOfHeaders equals: 1.
	self assert: p numberOfModules equals: 1.
	
	m := p modules anyOne.
	h := p headers anyOne.
	self assert: m loc equals: self file01 lines size.
	self assert: h loc equals: self file02 lines size.
	self assert: m includedNames size equals: 1.
	self assert: m includedNames anyOne equals: 'util/foo.h'.
	
	self assert: m baseFilenameWithoutExtension equals: 'foo'.
	self assert: h baseFilenameWithoutExtension equals: 'foo'.	
	
	self assert: m hasHeader.
	self assert: m header equals: h.
	self assert: h hasModule.
	self assert: h module equals: m.

	self assert: h incomingHeaders isEmpty.
	self assert: h outgoingHeaders isEmpty.

]

{ #category : #tests }
CPPProcessor3Test >> testBasic01bis [
	| m h |
	p processFileAsString: self file01 named: 'foo.c'.
	p processFileAsString: self file02 named: 'foo.h'.
	p resolveDependencies.
	
	self assert: p numberOfHeaders equals: 1.
	self assert: p numberOfModules equals: 1.
	
	m := p modules anyOne.
	h := p headers anyOne.
	self assert: m loc equals: self file01 lines size.
	self assert: h loc equals: self file02 lines size.
	self assert: m includedNames size equals: 1.
	self assert: m includedNames anyOne equals: 'util/foo.h'.
	
	self assert: m baseFilenameWithoutExtension equals: 'foo'.
	self assert: h baseFilenameWithoutExtension equals: 'foo'.	
	
	self assert: m hasHeader.
	self assert: m header equals: h.
	self assert: h hasModule.
	self assert: h module equals: m.

	self assert: h incomingHeaders isEmpty.
	self assert: h outgoingHeaders isEmpty.

]

{ #category : #tests }
CPPProcessor3Test >> testBasic01bisbis [
	| m h |
	p processFileAsString: self file01 named: 'foo.c'.
	p processFileAsString: self file02 named: 'foo.hpp'.
	p resolveDependencies.
	
	self assert: p numberOfHeaders equals: 1.
	self assert: p numberOfModules equals: 1.
	
	m := p modules anyOne.
	h := p headers anyOne.
	self assert: m loc equals: self file01 lines size.
	self assert: h loc equals: self file02 lines size.
	self assert: m includedNames size equals: 1.
	self assert: m includedNames anyOne equals: 'util/foo.h'.
	
	self assert: m baseFilenameWithoutExtension equals: 'foo'.
	self assert: h baseFilenameWithoutExtension equals: 'foo'.	
	
	self assert: m hasHeader.
	self assert: m header equals: h.
	self assert: h hasModule.
	self assert: h module equals: m.

	self assert: h incomingHeaders isEmpty.
	self assert: h outgoingHeaders isEmpty.

]

{ #category : #tests }
CPPProcessor3Test >> testBasic01bisbisbis [
	| m h |
	p processFileAsString: self file01 named: 'foo.cpp'.
	p processFileAsString: self file02 named: 'foo.hpp'.
	p resolveDependencies.
	
	self assert: p numberOfHeaders equals: 1.
	self assert: p numberOfModules equals: 1.
	
	m := p modules anyOne.
	h := p headers anyOne.
	self assert: m loc equals: self file01 lines size.
	self assert: h loc equals: self file02 lines size.
	self assert: m includedNames size equals: 1.
	self assert: m includedNames anyOne equals: 'util/foo.h'.
	
	self assert: m baseFilenameWithoutExtension equals: 'foo'.
	self assert: h baseFilenameWithoutExtension equals: 'foo'.	
	
	self assert: m hasHeader.
	self assert: m header equals: h.
	self assert: h hasModule.
	self assert: h module equals: m.

	self assert: h incomingHeaders isEmpty.
	self assert: h outgoingHeaders isEmpty.

]

{ #category : #tests }
CPPProcessor3Test >> testBasic02 [
	p processFileAsString: self file01 named: 'foo.c'.
	p processFileAsString: self file02 named: 'foo.h'.

	self assert: (p moduleNamed: 'foo.c') equals: p modules anyOne.
	self assert: (p headerNamed: 'foo.h') equals: p headers anyOne.
	self assert: (p moduleNamed: 'foo.h') isNil.
	self assert: (p headerNamed: 'foo.c') isNil.
]

{ #category : #tests }
CPPProcessor3Test >> testBasic03 [
	| h1 h2 |
	p processFileAsString: self file01 named: 'util/foo.c'.
	p processFileAsString: self file02 named: 'util/foo.h'.
	p processFileAsString: self file03 named: '/foo/zork/bar.c'.
	p processFileAsString: self file04 named: 'bar.h'.
	p resolveDependencies.
	
	self assert: p numberOfHeaders equals: 2.
	self assert: p numberOfModules equals: 2.
	
	h1 := p headerNamed: 'bar.h'.
	h2 := p headerNamed: 'foo.h'.
	self assert: h1 incomingHeaders isEmpty.
	self assert: h1 outgoingHeaders size equals: 1.
	
	self assert: h2 incomingHeaders size equals: 1.
	self assert: h2 incomingHeaders anyOne equals: h1.
]

{ #category : #tests }
CPPProcessor3Test >> testBasic04 [
	| m1  m2 |
	p processFileAsString: self file01 named: 'foo.c'.
	p processFileAsString: self file02 named: 'foo.h'.
	p processFileAsString: self file03 named: 'bar.c'.
	p processFileAsString: self file04 named: 'bar.h'.
	p resolveDependencies.
	
	m1 := p moduleNamed: 'bar.c'.
	m2 := p moduleNamed: 'foo.c'.
	self assert: m1 dependentModules size equals: 1.
	self assert: m1 dependentModules anyOne equals: m2.
	
	self assert: m2 dependentModules size equals: 0
]

{ #category : #tests }
CPPProcessor3Test >> testBasic05 [
	| m |
	p processFileAsString: self file05 named: 'foo.c'.
	p resolveDependencies.
	m := p moduleNamed: 'foo.c'.
	self assert: m includedNames size equals: 1.
	self assert: m includedNames anyOne equals: 'foo.h'
]

{ #category : #tests }
CPPProcessor3Test >> testBasic06 [
	| m1  m2 |
	p processFileAsString: self file01 named: '/abc/def/foo.c'.
	p processFileAsString: self file02 named: '/abc/def/foo.h'.
	p processFileAsString: self file03 named: '/abc/def/bar.c'.
	p processFileAsString: self file04 named: '/abc/def/bar.h'.
	p resolveDependencies.
	
	m1 := p moduleNamed: 'bar.c'.
	m2 := p moduleNamed: 'foo.c'.
	self assert: m1 notNil.
	self assert: m2 notNil.
	
	self assert: m1 dependentModules size equals: 1.
	self assert: m1 dependentModules anyOne equals: m2.
	
	self assert: m2 dependentModules size equals: 0
]

{ #category : #tests }
CPPProcessor3Test >> testDefault [

	self assert: p numberOfHeaders equals: 0.
	self assert: p numberOfModules equals: 0.
]
