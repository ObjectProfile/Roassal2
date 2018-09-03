Class {
	#name : #PyFileTest,
	#superclass : #TestCase,
	#category : #'Roassal2-Plugins-PythonAnalyzer-Tests'
}

{ #category : #tests }
PyFileTest >> testFileAndMethodAndClass [

	| f c m |
	f := PyFile new.
	c := PyClass new.
	m := PyMethod new.
	f addClass: c.
	c addMethod: m.
	
	self assert: c file equals: f.
	self assert: m file equals: f.
]
