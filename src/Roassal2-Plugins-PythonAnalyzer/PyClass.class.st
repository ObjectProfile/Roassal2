Class {
	#name : #PyClass,
	#superclass : #PyStructuralElement,
	#instVars : [
		'superclassName',
		'methods',
		'superclass'
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
	methods := OrderedCollection new.
	superclass := nil
]

{ #category : #accessing }
PyClass >> methods [
	^ methods
]

{ #category : #metrics }
PyClass >> numberOfMethods [
	^ methods size
]

{ #category : #accessing }
PyClass >> superclass [
	^ superclass
]

{ #category : #accessing }
PyClass >> superclass: pyClass [
	superclass := pyClass
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
