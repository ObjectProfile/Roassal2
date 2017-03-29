Class {
	#name : #PyAbstractBehavior,
	#superclass : #PyStructuralElement,
	#instVars : [
		'callNames'
	],
	#category : #'Roassal2-Plugins-PythonAnalyzer-Core'
}

{ #category : #accessing }
PyAbstractBehavior >> callNames [
	^ callNames
]

{ #category : #initialization }
PyAbstractBehavior >> initialize [
	super initialize.
	callNames := OrderedCollection new
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
