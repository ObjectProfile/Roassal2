Class {
	#name : #RTAttachPoint,
	#superclass : #RTObject,
	#instVars : [
		'inverted'
	],
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

{ #category : #initialization }
RTAttachPoint >> initialize [
	super initialize.
	inverted := false.
]

{ #category : #'public - hooks' }
RTAttachPoint >> inverted [
	inverted := inverted not.
]

{ #category : #'public - hooks' }
RTAttachPoint >> inverted: aBool [
	inverted := aBool
]

{ #category : #testing }
RTAttachPoint >> isInverted [
	^ inverted
]

{ #category : #'public - hooks' }
RTAttachPoint >> startingPointOf: anEdge [
	self subclassResponsibility 
]
