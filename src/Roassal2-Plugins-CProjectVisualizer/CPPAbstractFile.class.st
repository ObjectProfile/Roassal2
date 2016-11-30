Class {
	#name : #CPPAbstractFile,
	#superclass : #RTObject,
	#instVars : [
		'filename'
	],
	#category : #'Roassal2-Plugins-CProjectVisualizer'
}

{ #category : #accessing }
CPPAbstractFile >> fileReference [
	"Return the file reference"
	^ self filename asFileReference
]

{ #category : #accessing }
CPPAbstractFile >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #accessing }
CPPAbstractFile >> filename [
	^ filename
]

{ #category : #accessing }
CPPAbstractFile >> filename: afileName [
	filename := afileName.
	fileReference := afileName asFileReference
]

{ #category : #accessing }
CPPAbstractFile >> getSource [
	"Return the source code of the file"
	| c |
	self fileReference exists ifFalse: [ ^ '' ].
	c := self fileReference contents.
	^ c isNil ifTrue: [ '' ] ifFalse: [ c ]
]

{ #category : #inspector }
CPPAbstractFile >> gtInspectorTableIn: composite [
	<gtInspectorPresentationOrder: -15>
	composite text
		title: 'Source';
		display: [ self getSource ]
]
