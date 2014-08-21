Class {
	#name : #RTTimeLineBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'b'
	],
	#category : #'Roassal2-Builder-TimeLine'
}

{ #category : #running }
RTTimeLineBuilderTest >> setUp [
	b := RTTimeLineBuilder new
]

{ #category : #tests }
RTTimeLineBuilderTest >> testAddingElement [

	b add: 5.
	b add: 10.
	b build.
	self assert: b view numberOfElements equals: 2
]

{ #category : #tests }
RTTimeLineBuilderTest >> testAddingElement2 [

	b height: 100.
	b add: 5.
	b build.
	self assert: b view numberOfElements equals: 1.
	self assert: b view elements first trachelShape height equals: 100.
	
	b add: 10.
	b build.
	self assert: b view numberOfElements equals: 2.
	self assert: b view elements first trachelShape height equals: 50.
	self assert: b view elements second trachelShape height equals: 100.
	
]

{ #category : #tests }
RTTimeLineBuilderTest >> testDefault [

	b build.
	self assert: b view numberOfElements equals: 0
]
