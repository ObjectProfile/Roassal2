Class {
	#name : #PCPPAccess,
	#superclass : #PCPPObject,
	#instVars : [
		'instructionId',
		'id',
		'accessType',
		'referenceId',
		'reference'
	],
	#category : #ProfilerCPP
}

{ #category : #'as yet unclassified' }
PCPPAccess >> accessType [
 ^ accessType 
]

{ #category : #'as yet unclassified' }
PCPPAccess >> accessType: anObject [
 accessType := anObject  
]

{ #category : #'as yet unclassified' }
PCPPAccess >> id [
	^ id
]

{ #category : #'as yet unclassified' }
PCPPAccess >> id: anObject [
	id := anObject
]

{ #category : #'as yet unclassified' }
PCPPAccess >> instructionId [
	^ instructionId
]

{ #category : #'as yet unclassified' }
PCPPAccess >> instructionId: anObject [
 instructionId := anObject  
]

{ #category : #'as yet unclassified' }
PCPPAccess >> reference [
	^ reference
]

{ #category : #'as yet unclassified' }
PCPPAccess >> reference: aReference [
	reference := aReference 
]

{ #category : #'as yet unclassified' }
PCPPAccess >> referenceId [
	^ referenceId
]

{ #category : #'as yet unclassified' }
PCPPAccess >> referenceId: anObject [
 referenceId := anObject  
]
