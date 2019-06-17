"
I am an abstract file for C project
"
Class {
	#name : #CPPAbstractFile,
	#superclass : #RTObject,
	#instVars : [
		'filename'
	],
	#category : #'DataStudio-CProjectVisualizer-Core'
}

{ #category : #accessing }
CPPAbstractFile >> fileReference [
	"Return the file reference"
	^ self filename asFileReference
]

{ #category : #accessing }
CPPAbstractFile >> filename [
	^ filename
]

{ #category : #accessing }
CPPAbstractFile >> filename: afileName [
	filename := afileName.

]

{ #category : #accessing }
CPPAbstractFile >> getSource [
	"Return the source code of the file"
	| r |
	self fileReference exists ifFalse: [ ^ '' ].
	
	r := self fileReference readStream.
"	r ascii.
	r converter: Latin1TextConverter new.
"	^ r contents.
	
]

{ #category : #inspector }
CPPAbstractFile >> gtInspectorTableIn: composite [
	<gtInspectorPresentationOrder: -15>
	composite text
		title: 'Source';
		display: [ self getSource ]
]
