Class {
	#name : #PyStructuralElement,
	#superclass : #PyObject,
	#instVars : [
		'startLine',
		'endLine',
		'name',
		'file'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyStructuralElement >> endLine [
	^ endLine
]

{ #category : #accessing }
PyStructuralElement >> endLine: anObject [
	endLine := anObject
]

{ #category : #accessing }
PyStructuralElement >> file [
	^ file
]

{ #category : #accessing }
PyStructuralElement >> file: aPyFile [
	file := aPyFile
]

{ #category : #metrics }
PyStructuralElement >> loc [
	^ endLine - startLine + 1
]

{ #category : #accessing }
PyStructuralElement >> name [
	^ name
]

{ #category : #accessing }
PyStructuralElement >> name: nameAsString [
	name := nameAsString
]

{ #category : #metrics }
PyStructuralElement >> numberOfLinesOfCode [
	^ self loc
]

{ #category : #accessing }
PyStructuralElement >> startLine [
	^ startLine
]

{ #category : #accessing }
PyStructuralElement >> startLine: anObject [
	startLine := anObject
]
