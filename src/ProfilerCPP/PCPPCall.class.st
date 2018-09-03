Class {
	#name : #PCPPCall,
	#superclass : #PCPPObject,
	#instVars : [
		'calledFunction',
		'callingFunction',
		'endTime',
		'functionId',
		'id',
		'instructionId',
		'startTime',
		'functionCalls',
		'referenceAccesses',
		'totalExecutionTime'
	],
	#category : #ProfilerCPP
}

{ #category : #'as yet unclassified' }
PCPPCall class >> annotation [
	<MSEClass: #PCPPCall super: #PCPPObject>
	<package: #ProfilerCPP>
	^ self
	
]

{ #category : #accessing }
PCPPCall >> calledFunction [
	<MSEProperty: #calledFunction type: #PCPPFunction>
	<MSEComment: 'the called function'>
	^ calledFunction
]

{ #category : #accessing }
PCPPCall >> calledFunction: aFunction [
	calledFunction := aFunction
]

{ #category : #accessing }
PCPPCall >> callingFunction [
	<MSEProperty: #callingFunction type: #PCPPFunction>
	<MSEComment: 'the calling function'>
	^ callingFunction
]

{ #category : #accessing }
PCPPCall >> callingFunction: aFunction [
	callingFunction := aFunction
]

{ #category : #accessing }
PCPPCall >> endTime [
	^ endTime
]

{ #category : #accessing }
PCPPCall >> endTime: anObject [
	endTime := anObject
]

{ #category : #accessing }
PCPPCall >> function [
	^ calledFunction
]

{ #category : #accessing }
PCPPCall >> function: anObject [
	calledFunction := anObject
]

{ #category : #accessing }
PCPPCall >> functionCalls [
	^ functionCalls
]

{ #category : #accessing }
PCPPCall >> functionCalls: aFunctionCallsCollection [
	functionCalls := aFunctionCallsCollection 
]

{ #category : #accessing }
PCPPCall >> functionId [
	^ functionId
]

{ #category : #accessing }
PCPPCall >> functionId: anObject [
	functionId := anObject
]

{ #category : #accessing }
PCPPCall >> id [
	^ id
]

{ #category : #accessing }
PCPPCall >> id: anObject [
	id := anObject
]

{ #category : #accessing }
PCPPCall >> initialize [
	super initialize.
	self totalExecutionTime: 0
]

{ #category : #accessing }
PCPPCall >> instructionId [
	^ instructionId
]

{ #category : #accessing }
PCPPCall >> instructionId: anObject [
	instructionId := anObject
]

{ #category : #accessing }
PCPPCall >> mooseNameOn: aStream [ 

	aStream nextPutAll: '<call ', self id asString, '>'
]

{ #category : #accessing }
PCPPCall >> otherFunctionCalls [

	^ self functionCalls select: [:c | c ~= self ]
]

{ #category : #accessing }
PCPPCall >> referenceAccesses [
	^ referenceAccesses
]

{ #category : #accessing }
PCPPCall >> referenceAccesses: aReferenceAccessesCollection [
	referenceAccesses := aReferenceAccessesCollection
]

{ #category : #accessing }
PCPPCall >> startTime [
	^ startTime
]

{ #category : #accessing }
PCPPCall >> startTime: anObject [
	startTime := anObject
]

{ #category : #accessing }
PCPPCall >> timeToExecute [
	<MSEProperty: #timeToExecute type: #Number>
	<derived>
	<MSEComment: 'Time I took to execute'>
	^ endTime - startTime
]

{ #category : #accessing }
PCPPCall >> totalExecutionTime [
 ^ totalExecutionTime 
]

{ #category : #accessing }
PCPPCall >> totalExecutionTime: aNumber [
 totalExecutionTime := aNumber 
]
