Class {
	#name : #RTPharoCodeAnalyzerTest,
	#superclass : #RTTest,
	#instVars : [
		'a'
	],
	#category : #'Roassal2-PharoCodeAnalyzer'
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
RTPharoCodeAnalyzerTest >> testDefault [

	self assert: a notNil.
	self assert: a graph view numberOfElements equals: 0.
	self assert: a currentSelection isEmpty
]

{ #category : #tests }
RTPharoCodeAnalyzerTest >> testSelection [
	a pressAddClasses: 'RT*'.
	self assert: a currentSelection size > 80
]
