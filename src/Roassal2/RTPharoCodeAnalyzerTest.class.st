Class {
	#name : #RTPharoCodeAnalyzerTest,
	#superclass : #RTTest,
	#instVars : [
		'a'
	],
	#category : #'Roassal2-DataStudio'
}

{ #category : #running }
RTPharoCodeAnalyzerTest >> setUp [
	super setUp.
	a := RTPharoCodeAnalyzer new
]

{ #category : #tests }
RTPharoCodeAnalyzerTest >> testAddingClasses [
	a pressAddClasses: 'RT*'.
	self assert: a graph view numberOfElements > 80 
]

{ #category : #tests }
RTPharoCodeAnalyzerTest >> testChangeColor [
	a pressAddClasses: 'RT*'.
	a pressSelect: 'Layout'.
	a pressSetColor: Color red.
	
	self assert: (a graph view elementFromModel: RTShape) trachelShape color equals: Color gray.
	self assert: (a graph view elementFromModel: RTLayout) trachelShape color equals: Color red.

]

{ #category : #tests }
RTPharoCodeAnalyzerTest >> testDefault [

	self assert: a notNil.
	self assert: a graph view numberOfElements equals: 0.
	self assert: a currentSelection isEmpty
]

{ #category : #tests }
RTPharoCodeAnalyzerTest >> testSelecting [
	| t |
	a pressAddClasses: 'RT*'.
	t := a currentSelection size.
	a pressSelect: 'Layout'.
	self assert: a currentSelection size < t.
	

]

{ #category : #tests }
RTPharoCodeAnalyzerTest >> testSelection [
	a pressAddClasses: 'RT*'.
	self assert: a currentSelection size > 80
]
