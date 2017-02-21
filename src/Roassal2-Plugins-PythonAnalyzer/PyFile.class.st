Class {
	#name : #PyFile,
	#superclass : #PyAbstractFile,
	#instVars : [
		'importedFilenames',
		'loc',
		'importedFiles'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyFile >> importedFilenames [
	^ importedFilenames asArray
]

{ #category : #accessing }
PyFile >> importedFiles [
	^ importedFiles asArray
]

{ #category : #initialization }
PyFile >> initialize [
	super initialize.
	importedFilenames := OrderedCollection new.
	importedFiles := OrderedCollection new.
	self filename: 'UNAMED'.
	self loc: -1.
]

{ #category : #initialization }
PyFile >> initializeFromContentAsString: string [
	| lines importLines |
	lines := string lines.
	loc := lines size.
	
	importLines := lines select: [ :l | l beginsWith: 'import ' ].
	importLines do: [ :l |
		importedFilenames add: l substrings second
	 ].

]

{ #category : #accessing }
PyFile >> loc [
	"Return the number of lines of code of the file"
	^ loc
]

{ #category : #accessing }
PyFile >> loc: anInteger [
	"Set the number of lines of code of the file"
	loc := anInteger
]
