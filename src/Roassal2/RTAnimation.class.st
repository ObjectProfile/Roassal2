Class {
	#name : #RTAnimation,
	#superclass : #Object,
	#instVars : [
		'cycleLength',
		'element'
	],
	#category : #Roassal2
}

{ #category : #testing }
RTAnimation >> hasCompleted [
	self subclassResponsibility
]

{ #category : #refreshing }
RTAnimation >> refresh [
	self subclassResponsibility
]
