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

{ #category : #accessing }
PyStructuralElement >> getSource [
	| allLines lines |
	lines := self file getSource lines.
	allLines := lines copyFrom: self startLine to: (self endLine min: lines size).
	^ String cr join: allLines
]

{ #category : #inspector }
PyStructuralElement >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 5>
	| s |
	s := self getSource.
	s ifNotNil: [ s gtInspectorTextIn: composite ]
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

{ #category : #printing }
PyStructuralElement >> printOn: stream [
	stream nextPut: $<.
	self name ifNotNil: [ stream nextPutAll: self name ].
	stream nextPut: $>.
]

{ #category : #accessing }
PyStructuralElement >> startLine [
	^ startLine
]

{ #category : #accessing }
PyStructuralElement >> startLine: anObject [
	startLine := anObject
]
