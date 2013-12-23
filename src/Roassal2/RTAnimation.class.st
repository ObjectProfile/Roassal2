Class {
	#name : #RTAnimation,
	#superclass : #Object,
	#instVars : [
		'cycleLength',
		'element'
	],
	#category : #Roassal2
}

{ #category : #'as yet unclassified' }
RTAnimation >> hasCompleted [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RTAnimation >> refresh [
	self subclassResponsibility
]
