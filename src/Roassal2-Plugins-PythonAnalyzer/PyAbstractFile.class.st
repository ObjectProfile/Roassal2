"
I am the abstract class for files and directories in python
"
Class {
	#name : #PyAbstractFile,
	#superclass : #PyObject,
	#instVars : [
		'filename',
		'parentFolder'
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
PyAbstractFile >> filename: aFullFilename [
	filename := aFullFilename.

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
	<gtInspectorPresentationOrder: -110>
	self fileReference ifNotNil: [ self fileReference gtInspectorContentsIn: composite ]
]

{ #category : #accessing }
PyAbstractFile >> parent [
	"Return the full path of the folder that contains myself"
	^ self fileReference parent pathString
]

{ #category : #accessing }
PyAbstractFile >> parentFolder [
	^ parentFolder
]

{ #category : #accessing }
PyAbstractFile >> parentFolder: aPyFolder [
	self assert: [ aPyFolder class == PyFolder ] description: 'Provide a PyFolder please'.
	parentFolder := aPyFolder
]

{ #category : #printing }
PyAbstractFile >> printOn: str [
	str nextPut: $<.
	self baseFilename notNil ifTrue: [ str nextPutAll: self baseFilename ].
	str nextPut: $>.
]
