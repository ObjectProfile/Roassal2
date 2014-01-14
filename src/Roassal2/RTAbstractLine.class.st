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

{ #category : #public }
RTAbstractLine >> edgeFrom: el1 to: el2 [
	^ (RTEdge from: el1 to: el2) addShape: self
]

{ #category : #rendering }
RTAbstractLine >> updateFor: edge trachelShape: trachelShape [
	trachelShape from: edge from position.
	trachelShape to: edge to position.
	trachelShape resetPath

]
