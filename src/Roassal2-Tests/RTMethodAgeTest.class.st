Class {
	#name : #RTMethodAgeTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Tests'
}

{ #category : #tests }
RTMethodAgeTest >> testMethodAge [ 
	self assert: RTAbstractElementShape computeYoungestMethod notNil
]
