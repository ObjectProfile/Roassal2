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
