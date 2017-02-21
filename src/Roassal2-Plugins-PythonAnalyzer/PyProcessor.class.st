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

{ #category : #properties }
PyProcessor >> numberOfFiles [
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
