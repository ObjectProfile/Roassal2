Class {
	#name : #CPPAbstractFile,
	#superclass : #RTObject,
	#instVars : [
		'filename'
	],
	#category : #'Roassal2-Plugins-CProjectVisualizer'
}

{ #category : #accessing }
CPPAbstractFile >> fileReference [
	"Return the file reference"
	^ fileReference
]

{ #category : #accessing }
CPPAbstractFile >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #accessing }
CPPAbstractFile >> filename [
	^ filename
]

{ #category : #accessing }
CPPAbstractFile >> filename: afileName [
	filename := afileName.
	fileReference := afileName asFileReference
]
