Class {
	#name : #JVProcessorTest,
	#superclass : #TestCase,
	#instVars : [
		'p'
	],
	#category : #'Roassal2-Plugins-JavaVisualizer'
}

{ #category : #initialization }
JVProcessorTest >> setUp [
	super setUp.
	p := JVProcessor new
]

{ #category : #tests }
JVProcessorTest >> testBasic [
	p processFileAsString: 
'
package foo;
import bar.*;
class A {  }
' named: 'A.java'.
	p processFileAsString:
'
package bar;
class B extends C {}' named: 'B.java'.
	p resolveDependencies.
	
	self assert: p numberOfClasses equals: 2.
	self assert: p numberOfPackages equals: 2.
	
	"We check class names"
	self assert: p classes first classname equals: 'A'.
	self assert: p classes second classname equals: 'B'.
	
	"We check LOC"
	self assert: p classes first loc equals: 4.
	self assert: p classes second loc equals: 3.
	
	"We check packages"
	self assert: p packages first packageName equals: 'foo'.
	self assert: p packages second packageName equals: 'bar'.
	self assert: p classes first package equals: p packages first.
	self assert: p classes second package equals: p packages second.
	
	"We check that packages contains classes"
	self assert: (p packages first classes includes: p classes first).
	self assert: (p packages second classes includes: p classes second).
	
	"We check superclasses"
	self assert: p classes first superclassName equals: 'Object'.	
	self assert: p classes second superclassName equals: 'C'.

	"We check imports"
	"self assert: ((p getPackageNamed: 'foo') importingPackages includes: (p getPackageNamed: 'bar')) "
]
