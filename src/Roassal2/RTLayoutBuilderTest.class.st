Class {
	#name : #RTLayoutBuilderTest,
	#superclass : #RTTest,
	#instVars : [
		'builder'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'as yet unclassified' }
RTLayoutBuilderTest >> setUp [
	builder := RTLayoutBuilder new
]

{ #category : #'as yet unclassified' }
RTLayoutBuilderTest >> testAddingPartition [
	builder for: #odd use: RTGridLayout new.
	self assert: builder hasPartition
]

{ #category : #'as yet unclassified' }
RTLayoutBuilderTest >> testDefault [
	self deny: builder hasPartition
]
