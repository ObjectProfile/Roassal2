Class {
	#name : #JVAbstractFile,
	#superclass : #JVObject,
	#instVars : [
		'filename'
	],
	#category : #'Roassal2-Plugins-JavaVisualizer'
}

{ #category : #accessing }
JVAbstractFile >> fileReference [
	"Return the file reference"
	^ self filename asFileReference
]

{ #category : #accessing }
JVAbstractFile >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #accessing }
JVAbstractFile >> filename [
	^ filename
]

{ #category : #accessing }
JVAbstractFile >> filename: afileName [
	filename := afileName.
	fileReference := afileName asFileReference
]

{ #category : #accessing }
JVAbstractFile >> getSource [
	"Return the source code of the file"
	| c |
	self fileReference exists ifFalse: [ ^ '' ].
	c := self fileReference contents.
	^ c isNil ifTrue: [ '' ] ifFalse: [ c ]
]

{ #category : #inspector }
JVAbstractFile >> gtInspectorTableIn: composite [
	<gtInspectorPresentationOrder: -15>
	composite text
		title: 'Source';
		display: [ self getSource ]
]
