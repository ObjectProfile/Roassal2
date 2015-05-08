Class {
	#name : #RTMethodAgeTest,
	#superclass : #RTTest,
	#category : #'Roassal2-MorphSpecific'
}

{ #category : #'as yet unclassified' }
RTMethodAgeTest >> testMethodAge [ 
	self assert: RTAbstractElementShape computeYoungestMethod notNil
]
