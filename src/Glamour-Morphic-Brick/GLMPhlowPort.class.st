Class {
	#name : #GLMPhlowPort,
	#superclass : #Object,
	#instVars : [
		'transmissions'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #adding }
GLMPhlowPort >> addTransmission: aTransmission [

	(self transmissions includes: aTransmission) ifTrue: [ ^ self ].
	self transmissions add: aTransmission
]

{ #category : #accessing }
GLMPhlowPort >> transmissions [

	^ transmissions ifNil: [ transmissions := OrderedCollection new ]
]

{ #category : #transmitting }
GLMPhlowPort >> transmit [

	self transmissions do: #transmit
]
