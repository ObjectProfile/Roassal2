Class {
	#name : #PyAbstractBehavior,
	#superclass : #PyObject,
	#instVars : [
		'startLine',
		'endLine',
		'file',
		'name',
		'callNames'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyAbstractBehavior >> endLine [
	^ endLine
]

{ #category : #accessing }
PyAbstractBehavior >> endLine: anObject [
	endLine := anObject
]

{ #category : #accessing }
PyAbstractBehavior >> file [
	^ file
]

{ #category : #accessing }
PyAbstractBehavior >> file: aPyFile [
	file := aPyFile
]

{ #category : #initialization }
PyAbstractBehavior >> initialize [
	super initialize.
	callNames := OrderedCollection new
]

{ #category : #metrics }
PyAbstractBehavior >> loc [
	^ endLine - startLine + 1
]

{ #category : #accessing }
PyAbstractBehavior >> name [
	^ name
]

{ #category : #accessing }
PyAbstractBehavior >> name: nameAsString [
	name := nameAsString
]

{ #category : #metrics }
PyAbstractBehavior >> numberOfLinesOfCode [
	^ self loc
]

{ #category : #accessing }
PyAbstractBehavior >> startLine [
	^ startLine
]

{ #category : #accessing }
PyAbstractBehavior >> startLine: anObject [
	startLine := anObject
]
