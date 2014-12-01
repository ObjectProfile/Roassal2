Class {
	#name : #RTMondrianFrame,
	#superclass : #RTObject,
	#instVars : [
		'topElements',
		'depth'
	],
	#category : #'Roassal2-Builder-NewMondrian'
}

{ #category : #accessing }
RTMondrianFrame >> depth [
	^ depth
]

{ #category : #accessing }
RTMondrianFrame >> depth: anObject [
	depth := anObject
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> increaseDepth [
	depth := depth + 1
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> initialize [
	super initialize.
	depth := 1
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> setTopElements: someElements [
	topElements := someElements
]

{ #category : #'as yet unclassified' }
RTMondrianFrame >> topElements [
	^ topElements
]
