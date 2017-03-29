Class {
	#name : #PyMethod,
	#superclass : #PyAbstractBehavior,
	#instVars : [
		'pythonClass'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyMethod >> pythonClass [
	^ pythonClass
]

{ #category : #accessing }
PyMethod >> pythonClass: aPyClass [
	pythonClass := aPyClass
]
