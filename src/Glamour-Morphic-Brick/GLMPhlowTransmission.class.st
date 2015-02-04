Class {
	#name : #GLMPhlowTransmission,
	#superclass : #Object,
	#instVars : [
		'origins',
		'destination',
		'transformation',
		'action',
		'condition',
		'phlow'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #accessing }
GLMPhlowTransmission >> action [
	^ action
]

{ #category : #accessing }
GLMPhlowTransmission >> action: anObject [

	action := anObject
]

{ #category : #adding }
GLMPhlowTransmission >> addOrigin: anObject [
	"anObject must be a GLMPhlowOrigin"
	
	(self origins includes: anObject) ifTrue: [ ^ self ].
	"registering new origin"
	self origins add: anObject.
	"adding myself to the outgoing transmissions of origin"
	anObject phlowObject addTransmission: self from: anObject slot name
]

{ #category : #accessing }
GLMPhlowTransmission >> condition [
	^ condition
]

{ #category : #accessing }
GLMPhlowTransmission >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
GLMPhlowTransmission >> destination [
	^ destination
]

{ #category : #accessing }
GLMPhlowTransmission >> destination: anObject [
	destination := anObject
]

{ #category : #private }
GLMPhlowTransmission >> gatherPortValues [
	"returns a Collection containing values of all assosiated origins"
	^ self origins collect: [ :each | each slot read: each phlowObject ]
]

{ #category : #private }
GLMPhlowTransmission >> meetsCondition: aCollection [
	
	^ ((self condition phlowValue: self destination phlowObject withEnoughArguments: aCollection) = false) not
]

{ #category : #accessing }
GLMPhlowTransmission >> origins [

	^ origins ifNil: [ origins := OrderedCollection new ]
]

{ #category : #accessing }
GLMPhlowTransmission >> phlow [
	^ phlow
]

{ #category : #accessing }
GLMPhlowTransmission >> phlow: anObject [
	phlow := anObject
]

{ #category : #accessing }
GLMPhlowTransmission >> transformation [
	^ transformation
]

{ #category : #accessing }
GLMPhlowTransmission >> transformation: anObject [
	transformation := anObject
]

{ #category : #transmission }
GLMPhlowTransmission >> transmit [
	|portValues value|
	
	portValues := self gatherPortValues.
	
	"we transmit only if meets condition"
	(self meetsCondition: portValues) ifFalse: [ ^ self ].
	"obtaining slot value and transforming it"
	value := self transformation phlowValue: self destination phlowObject withEnoughArguments: portValues.
	"transmiting transformed value to destination port"
	self destination phlowValue: value value: self phlow.
	"performing specified action"
	self action phlowValue: self destination phlowObject value: value
	
]
