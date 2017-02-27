"
I am the abstract class for files and directories in python
"
Class {
	#name : #PyAbstractFile,
	#superclass : #PyObject,
	#instVars : [
		'filename'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyAbstractFile >> baseFilename [
	^ (filename findTokens: '/') last
	 
]

{ #category : #accessing }
PyAbstractFile >> baseFilenameWithoutExtension [
	| ts |
	ts := filename findTokens: '/.'.
	^ ts at: (ts size - 1)
]

{ #category : #accessing }
PyAbstractFile >> fileReference [
	"Return the file reference"
	^ self filename asFileReference
]

{ #category : #accessing }
PyAbstractFile >> filename [
	^ filename
]

{ #category : #accessing }
PyAbstractFile >> filename: afileName [
	filename := afileName.

]

{ #category : #accessing }
PyAbstractFile >> getSource [
	"Return the source code of the file"
	| c |
	self fileReference exists ifFalse: [ ^ '' ].
	c := self fileReference contents.
	^ c isNil ifTrue: [ '' ] ifFalse: [ c ]
]

{ #category : #inspector }
PyAbstractFile >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 5>
	self fileReference ifNotNil: [ self fileReference gtInspectorContentsIn: composite ]
]

{ #category : #inspector }
PyAbstractFile >> gtInspectorTableIn: composite [
	<gtInspectorPresentationOrder: -15>
	composite text
		title: 'Source';
		display: [ self getSource ]
]
