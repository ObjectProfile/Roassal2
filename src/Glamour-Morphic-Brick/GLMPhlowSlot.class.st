Class {
	#name : #GLMPhlowSlot,
	#superclass : #IndexedSlot,
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'meta-object-protocol' }
GLMPhlowSlot >> write: aValue to: anObject [
	|result|
	result := anObject instVarAt: index put: aValue.
	anObject onSlotChanged: self.
	^ result
]
