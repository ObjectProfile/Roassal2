Class {
	#name : #CPPFile,
	#superclass : #CPPAbstractFile,
	#instVars : [
		'filename',
		'includedNames',
		'incomingHeaders',
		'outgoingHeaders',
		'loc',
		'fileReference'
	],
	#category : #'Roassal2-Plugins-CProjectVisualizer'
}

{ #category : #adding }
CPPFile >> addIncomingHeader: h [ 
	incomingHeaders add: h
]

{ #category : #adding }
CPPFile >> addOutgoingHeader: h [
	outgoingHeaders add: h
]

{ #category : #accessing }
CPPFile >> baseFilename [
	^ (filename findTokens: '/') last
	 
]

{ #category : #accessing }
CPPFile >> baseFilenameWithoutExtension [
	| ts |
	ts := filename findTokens: '/.'.
	^ ts at: (ts size - 1)
]

{ #category : #accessing }
CPPFile >> fileReference [
	"Return the file reference"
	^ fileReference
]

{ #category : #accessing }
CPPFile >> filename [
	^ filename
]

{ #category : #accessing }
CPPFile >> filename: afileName [
	filename := afileName.
	fileReference := afileName asFileReference
]

{ #category : #'gt inspector' }
CPPFile >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 5>
	fileReference ifNotNil: [ fileReference gtInspectorContentsIn: composite ]
]

{ #category : #accessing }
CPPFile >> includedNames [
	"Return the list of names specified in the includes.
	For example, if the file contains #include <foo.h>
	Then the collection returned by includedName contains 'foo.h'"
	^ includedNames
]

{ #category : #accessing }
CPPFile >> incomingHeaders [
	"Return the list of headers included by me"
	^ incomingHeaders
]

{ #category : #initialization }
CPPFile >> initialize [
	super initialize.
	outgoingHeaders := OrderedCollection new.
	incomingHeaders := OrderedCollection new.
	includedNames := OrderedCollection new.
	self filename: 'UNAMED'.
	self loc: -1.
]

{ #category : #initialization }
CPPFile >> initializeFromContentAsString: string [
	| lines includesLines |
	lines := string lines.
	loc := lines size.
	
	includesLines := lines select: [ :l | l beginsWith: '#include ' ].
	includesLines do: [ :l |
		includedNames add: (l findTokens: '<>"') second
	 ].

]

{ #category : #accessing }
CPPFile >> loc [
	"Return the number of lines of code of the file"
	^ loc
]

{ #category : #accessing }
CPPFile >> loc: anInteger [
	"Set the number of lines of code of the file"
	loc := anInteger
]

{ #category : #accessing }
CPPFile >> outgoingHeaders [
	^ outgoingHeaders
]

{ #category : #printing }
CPPFile >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	filename notEmpty ifTrue: [ str nextPutAll: filename ].
	str nextPut: $>
]
