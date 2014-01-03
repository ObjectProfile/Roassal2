Class {
	#name : #RTAbstractLine,
	#superclass : #RTShape,
	#instVars : [
		'width'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTAbstractLine class >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #'as yet unclassified' }
RTAbstractLine class >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #'as yet unclassified' }
RTAbstractLine >> updateFor: edge [
	edge trachelShape from: edge from position.
	edge trachelShape to: edge to position.
	edge trachelShape resetPath

]

{ #category : #'as yet unclassified' }
RTAbstractLine >> updateFor: edge [
	edge trachelShape from: edge from position.
	edge trachelShape to: edge to position.
	edge trachelShape resetPath

]
