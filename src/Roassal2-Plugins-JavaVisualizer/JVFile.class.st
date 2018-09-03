Class {
	#name : #JVFile,
	#superclass : #JVAbstractFile,
	#instVars : [
		'includedNames',
		'incomingHeaders',
		'outgoingHeaders',
		'loc',
		'fileReference'
	],
	#category : #'Roassal2-Plugins-JavaVisualizer'
}

{ #category : #accessing }
JVFile >> baseFilename [
	^ (filename findTokens: '/') last
	 
]

{ #category : #accessing }
JVFile >> baseFilenameWithoutExtension [
	| ts |
	ts := filename findTokens: '/.'.
	^ ts at: (ts size - 1)
]

{ #category : #'gt inspector' }
JVFile >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 5>
	fileReference ifNotNil: [ fileReference gtInspectorContentsIn: composite ]
]

{ #category : #initialization }
JVFile >> initialize [
	super initialize.
	self filename: 'UNAMED'.
	self loc: -1.
]

{ #category : #accessing }
JVFile >> loc [
	"Return the number of lines of code of the file"
	^ loc
]

{ #category : #accessing }
JVFile >> loc: anInteger [
	"Set the number of lines of code of the file"
	loc := anInteger
]

{ #category : #printing }
JVFile >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	filename notEmpty ifTrue: [ str nextPutAll: filename ].
	str nextPut: $>
]
