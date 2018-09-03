Class {
	#name : #PyAbstractBehavior,
	#superclass : #PyStructuralElement,
	#instVars : [
		'callNames',
		'outgoingMethods',
		'incomingMethods'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyAbstractBehavior >> addIncomingMethod: aMethod [
	incomingMethods add: aMethod
]

{ #category : #accessing }
PyAbstractBehavior >> addIncomingMethods: someMethods [
	someMethods do: [ :m | self addIncomingMethod: m ]
	
]

{ #category : #accessing }
PyAbstractBehavior >> addOutgoingMethod: aMethod [
	outgoingMethods add: aMethod
]

{ #category : #accessing }
PyAbstractBehavior >> addOutgoingMethods: someMethods [
	someMethods do: [ :m | self addOutgoingMethod: m ]
	
]

{ #category : #accessing }
PyAbstractBehavior >> callNames [
	^ callNames
]

{ #category : #initialization }
PyAbstractBehavior >> initialize [
	super initialize.
	callNames := OrderedCollection new.
	outgoingMethods := OrderedCollection new.
	incomingMethods := OrderedCollection new.
]

{ #category : #accessing }
PyAbstractBehavior >> outgoingMethods [
	^ outgoingMethods
]

{ #category : #processing }
PyAbstractBehavior >> processLine: line [
	| trimmed tokens |
	trimmed := line trimLeft.
	
	"Nothing to do if this line corresponds to a method declaration"
	(trimmed beginsWith: 'def ') ifTrue: [ ^ self ].
	
	(trimmed beginsWith: '#') ifTrue: [ ^ self ].
	tokens := trimmed findTokens: ' (.=+-/' keep: '('.
	2 to: tokens size do: [ :i |
		(((tokens at: i) = '(') and: [ (tokens at: i - 1) first isLetter ])
			ifTrue: [ callNames add: (tokens at: i -1) ]
	]
]
