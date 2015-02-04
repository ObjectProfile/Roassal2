"
I offer an api that adds support of phlow transmissions to any object
"
Trait {
	#name : #GLMPhlowTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'phlow-transmissions' }
GLMPhlowTrait >> addTransmission: aTransmission from: aSlotSymbol [
 
	^ (self portOf: aSlotSymbol) addTransmission: aTransmission
]

{ #category : #'private-phlow' }
GLMPhlowTrait >> onSlotChanged: aSlot [

	(self portOf: aSlot name) transmit
]

{ #category : #'phlow-transmissions' }
GLMPhlowTrait >> portOf: aSlotSymbol [

	^ self ports at: aSlotSymbol ifAbsentPut: [ GLMPhlowPort new ]
]

{ #category : #'phlow-transmissions' }
GLMPhlowTrait >> ports [

	^ self explicitRequirement
]

{ #category : #'phlow-scripting' }
GLMPhlowTrait >> transmit [

	^ GLMPhlowTransmissionBuilder phlow: self
]
