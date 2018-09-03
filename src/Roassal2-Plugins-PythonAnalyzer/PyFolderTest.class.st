"
A PyFolderTest is a test class for testing the behavior of PyFolder
"
Class {
	#name : #PyFolderTest,
	#superclass : #TestCase,
	#category : #'Roassal2-Plugins-PythonAnalyzer-Tests'
}

{ #category : #tests }
PyFolderTest >> testBasic [
	| folder |
	folder := PyFolder new.
	
	self assert: folder numberOfFiles equals: 0.
	self assert: folder files size equals: 0
]
