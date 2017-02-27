"
I am a simple python processor code, to analyze code and resolve dependecies
"
Class {
	#name : #PyProcessor,
	#superclass : #PyObject,
	#instVars : [
		'files',
		'directories'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyProcessor >> directories [
	^ directories
]

{ #category : #accessing }
PyProcessor >> files [
	^ files
]

{ #category : #initialization }
PyProcessor >> initialize [
	super initialize.
	files := Dictionary new.
	directories := OrderedCollection new
]

{ #category : #accessing }
PyProcessor >> moduleNamed: afilename [
	| fn |
	fn := afilename.
	(afilename beginsWith: '.') 
		ifTrue: [ fn := fn copyFrom: 2 to: fn size ].
	^ files at: fn ifAbsent: [ nil ]
]

{ #category : #properties }
PyProcessor >> numberOfFiles [
	^ files size
]

{ #category : #properties }
PyProcessor >> numberOfModules [
	^ files size
]

{ #category : #processing }
PyProcessor >> processFileAsString: fileContentAsString named: filename [
	| f |
	f := PyFile new.
	f filename: filename.
	f initializeFromContentAsString: fileContentAsString.
	files at: f baseFilename put: f
]

{ #category : #'resolving dependencies' }
PyProcessor >> resolveDependencies [
	self resolveDependenciesBetweenModules
]

{ #category : #'resolving dependencies' }
PyProcessor >> resolveDependenciesBetweenModules [
	self files copy do: [ :m | | ext |
		m importedFilenames do: [ :file | 
			ext := self moduleNamed: file,'.py'.
			ext ifNotNil: [ 
				ext addDependentModules: (Array with: m).
				m addImportedFile: ext ]  ].
		 ]
]
