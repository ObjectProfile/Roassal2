"
I am the header of a cpp module
"
Class {
	#name : #CPPHeader,
	#superclass : #CPPFile,
	#instVars : [
		'modules'
	],
	#category : #'DataStudio-CProjectVisualizer-Core'
}

{ #category : #testing }
CPPHeader >> hasModule [
	^ modules notEmpty
]

{ #category : #initialization }
CPPHeader >> initialize [
	super initialize.
	modules := OrderedCollection new
]

{ #category : #accessing }
CPPHeader >> module [
	"This method should not be used"
	^ modules first
]

{ #category : #accessing }
CPPHeader >> module: aModule [
	"Add a module to the header.
	Note that a header may have more than one module, althought it is unfrequent.
	For example, there could be a foo.h in the system, and two foo.c, each importing foo.h"
	modules add: aModule
]

{ #category : #accessing }
CPPHeader >> modules [
	"Return the module associated to the header. Normally, there is only one module, but it could happens that a software systems has:
	- one file foo.h
	- two files foo.c, each importing foo.h"
	^ modules
]
