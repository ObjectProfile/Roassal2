Class {
	#name : #RTMondrianFrame,
	#superclass : #RTObject,
	#instVars : [
		'topElements'
	],
	#category : #'Roassal2-Builder-NewMondrian'
}

{ #category : #'as yet unclassified' }
RTMondrianFrame >> setTopElements: someElements [
	topElements := someElements
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> topElements [
	^ topElements
]
