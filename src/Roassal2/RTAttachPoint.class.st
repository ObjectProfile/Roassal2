Class {
	#name : #RTAttachPoint,
	#superclass : #RTObject,
	#classInstVars : [
		'instance'
	],
	#category : #'Roassal2-Core'
}

{ #category : #public }
RTAttachPoint class >> instance [
	instance ifNil: [ instance := self new ].
	^ instance
]

{ #category : #'public - hooks' }
RTAttachPoint >> endingPointOf: anEdge [
	self subclassResponsibility 
]

{ #category : #'public - hooks' }
RTAttachPoint >> startingPointOf: anEdge [
	self subclassResponsibility 
]
