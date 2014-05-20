Class {
	#name : #RTPharoCodeAnalyzerTest,
	#superclass : #RTTest,
	#instVars : [
		'a'
	],
	#category : #'Roassal2-Builder-Graph'
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
	self assert: a graph view numberOfElements equals: 0
]
