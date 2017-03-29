Class {
	#name : #PyClass,
	#superclass : #PyStructuralElement,
	#instVars : [
		'superclassName',
		'methods'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #adding }
PyClass >> addMethod: aMethod [
	methods add: aMethod
]

{ #category : #initialization }
PyClass >> initialize [
	super initialize.
	methods := OrderedCollection new
]

{ #category : #accessing }
PyClass >> methods [
	^ methods
]

{ #category : #accessing }
PyClass >> superclassName [
	^ superclassName
]

{ #category : #accessing }
PyClass >> superclassName: aString [
	self assert: [ aString isByteString ].
	superclassName := aString
]
