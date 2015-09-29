"
I am the superclass of the class hierarchy describing attach points. An attach point indicates where lines start and end. 
"
Class {
	#name : #RTAttachPoint,
	#superclass : #RTObject,
	#instVars : [
		'inverted'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Roassal2-AttachPoint'
}

{ #category : #public }
RTAttachPoint class >> instance [
	instance ifNil: [ instance := self new ].
	^ instance
]

{ #category : #'public - hooks' }
RTAttachPoint >> basicEndingPointOf: anEdge [
	self subclassResponsibility 
]

{ #category : #'public - hooks' }
RTAttachPoint >> basicStartingPointOf: anEdge [
	self subclassResponsibility 
]

{ #category : #'public - hooks' }
RTAttachPoint >> endingPointOf: anEdge [
    ^ inverted
        ifTrue: [ self basicStartingPointOf: anEdge ]
        ifFalse: [ self basicEndingPointOf: anEdge ]
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
    ^ inverted
        ifTrue: [ self basicEndingPointOf: anEdge ]
        ifFalse: [ self basicStartingPointOf: anEdge ]

]
