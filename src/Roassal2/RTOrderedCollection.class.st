Class {
	#name : #RTOrderedCollection,
	#superclass : #RTTest,
	#category : #'Roassal2-Core'
}

{ #category : #tests }
RTOrderedCollection >> testBasic [

	self assert: ((#(5 4 1 5 2) sortedAs: #squared) asArray =  #(1 2 4 5 5) )
]

{ #category : #tests }
RTOrderedCollection >> testReverseBasic [

	self assert: ((#(5 4 1 5 2) reverseSortedAs: #squared) asArray =  #(1 2 4 5 5) reverse )
]
