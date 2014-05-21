Class {
	#name : #RTLayoutAnimation,
	#superclass : #RTAnimation,
	#instVars : [
		'layout',
		'elements'
	],
	#category : #'Roassal2-Core'
}

{ #category : #accessing }
RTLayoutAnimation >> elements [
	^ elements
]

{ #category : #accessing }
RTLayoutAnimation >> elements: anObject [
	elements := anObject
]

{ #category : #'as yet unclassified' }
RTLayoutAnimation >> hasCompleted [
	^ false
]

{ #category : #'as yet unclassified' }
RTLayoutAnimation >> initialize [
	super initialize.
	layout := RTGridLayout new
]

{ #category : #accessing }
RTLayoutAnimation >> layout [
	^ layout
]

{ #category : #accessing }
RTLayoutAnimation >> layout: anObject [
	layout := anObject
]

{ #category : #'as yet unclassified' }
RTLayoutAnimation >> refresh [
	layout on: elements.
	
]
