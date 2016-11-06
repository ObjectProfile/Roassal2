Class {
	#name : #CPPFile,
	#superclass : #RTObject,
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
	^ includedNames
]

{ #category : #accessing }
CPPFile >> includedNames: anObject [
	includedNames := anObject
]

{ #category : #accessing }
CPPFile >> incomingHeaders [
	^ incomingHeaders
]

{ #category : #accessing }
CPPFile >> incomingHeaders: anObject [
	incomingHeaders := anObject
]

{ #category : #initialization }
CPPFile >> initialize [
	super initialize.
	outgoingHeaders := OrderedCollection new.
	incomingHeaders := OrderedCollection new.
	includedNames := OrderedCollection new.
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
	^ loc
]

{ #category : #accessing }
CPPFile >> loc: anInteger [
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
