Class {
	#name : #RTInteractionBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'builder'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #running }
RTInteractionBuilderTest >> setUp [
	super setUp.
	builder := RTInteractionBuilder new
]

{ #category : #tests }
RTInteractionBuilderTest >> testAddingOneAction [
	builder action: #inspect.
	self assert: builder numberOfMenuEntries equals: 1
]

{ #category : #tests }
RTInteractionBuilderTest >> testAddingTwoActions [
	| e |
	builder action: #inspect; action: #browse.
	self assert: builder numberOfMenuEntries equals: 2.
	
	e := RTElement new.
	builder setUpElements: (Array with: e) asGroup.
	self assert: e announcer numberOfSubscriptions equals: 1.
	
]

{ #category : #tests }
RTInteractionBuilderTest >> testDefault [
	self assert: builder numberOfMenuEntries equals: 0
]
