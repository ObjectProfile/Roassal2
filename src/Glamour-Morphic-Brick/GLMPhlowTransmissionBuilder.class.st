Class {
	#name : #GLMPhlowTransmissionBuilder,
	#superclass : #Object,
	#instVars : [
		'transmissions'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'instance creation' }
GLMPhlowTransmissionBuilder class >> phlow: anObject [

	^ self new newWithPhlow: anObject
]

{ #category : #combining }
GLMPhlowTransmissionBuilder >> + anotherBuilder [

	self transmissions addAll: anotherBuilder transmissions
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> from: anObject [
	
	self transmissions do: [ :each | each addOrigin: (GLMPhlowOrigin target: (each phlow phlowValue: each phlow) slot: anObject) ].
]

{ #category : #'scripting-deprecated' }
GLMPhlowTransmissionBuilder >> from: anObject port: aSlotSymbol [

	^ self from: anObject slot: aSlotSymbol
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> from: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"aSlotSymbol must be a name of existing GLMPhlowSlot in anObject"
	self transmissions do: [ :each |
		|from|
		from := anObject phlowValue: each phlow.
		each addOrigin: (GLMPhlowOrigin target: from slot: aSlotSymbol) ].
]

{ #category : #'instance creation' }
GLMPhlowTransmissionBuilder >> newWithPhlow: anObject [

	self transmissions add: (GLMPhlowTransmission new phlow: anObject)
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> to: anObject [

	self transmissions do: [ :each | each destination: (GLMPhlowDestination 
		target: each phlow 
		port: (each phlow class slotsDictionary at: anObject)) ]
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> to: anObject port: aPortObject [

	self transmissions do: [ :each  | each destination: (GLMPhlowDestination target: anObject port: aPortObject) ]
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> to: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"aSlotSymbol must be a name of existing Slot in anObject"
	self transmissions do: [ :each | each destination: (GLMPhlowDestination 
		target: anObject 
		port: (anObject class slotsDictionary at: aSlotSymbol)) ]
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> toPort: anObject [

	^ self transmissions do: [ :each  | each destination: (GLMPhlowDestination target: each phlow port: anObject) ]
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> transformed: anObject [

	self transmissions do: [ :each | each transformation: anObject ]
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> transmissions [

	^  transmissions ifNil: [ transmissions := OrderedCollection new ]
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> when: anObject [

	self transmissions do: [ :each | each condition: anObject ]
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> with: anObject [

	self transmissions do: [ :each | each action: anObject ]
]
