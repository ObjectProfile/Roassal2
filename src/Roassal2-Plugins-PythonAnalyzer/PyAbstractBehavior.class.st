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
PyAbstractBehavior >> callNames [
	^ callNames
]

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

{ #category : #processing }
PyAbstractBehavior >> processLine: line [
	| trimmed tokens |
	trimmed := line trimLeft.
	(trimmed beginsWith: '#') ifTrue: [ ^ self ].
	tokens := trimmed findTokens: ' (' keep: '('.
	2 to: tokens size do: [ :i |
		(((tokens at: i) = '(') and: [ (tokens at: i - 1) first isLetter ])
			ifTrue: [ callNames add: (tokens at: i -1) ]
	]
]

{ #category : #accessing }
PyAbstractBehavior >> startLine [
	^ startLine
]

{ #category : #accessing }
PyAbstractBehavior >> startLine: anObject [
	startLine := anObject
]
