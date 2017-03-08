Class {
	#name : #CPPFolder,
	#superclass : #CPPAbstractFile,
	#instVars : [
		'files'
	],
	#category : #'Roassal2-Plugins-CProjectVisualizer-Core'
}

{ #category : #adding }
CPPFolder >> addFile: aFile [
	files add: aFile
]

{ #category : #accessing }
CPPFolder >> files [
	^ files copy
]

{ #category : #initialization }
CPPFolder >> initialize [
	super initialize.
	files := OrderedCollection new
]

{ #category : #metrics }
CPPFolder >> numberOfFiles [
	^ files size
]
