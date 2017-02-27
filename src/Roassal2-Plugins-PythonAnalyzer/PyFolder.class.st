"
I am a simple representation of a python folder
"
Class {
	#name : #PyFolder,
	#superclass : #PyAbstractFile,
	#instVars : [
		'files'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #adding }
PyFolder >> addFile: aFile [
	files add: aFile
]

{ #category : #accessing }
PyFolder >> files [
	^ files copy
]

{ #category : #initialization }
PyFolder >> initialize [
	super initialize.
	files := OrderedCollection new
]

{ #category : #metrics }
PyFolder >> numberOfFiles [
	^ files size
]
