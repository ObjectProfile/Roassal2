Class {
	#name : #GLMPhlowOrigin,
	#superclass : #GLMPhlowTarget,
	#instVars : [
		'slot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'instance creation' }
GLMPhlowOrigin class >> target: anObject slot: aSlotSymbol [

	^ self new phlowObject: anObject; slot: ((anObject class slotsDictionary at: aSlotSymbol)); yourself
]

{ #category : #accessing }
GLMPhlowOrigin >> slot [
	^ slot
]

{ #category : #accessing }
GLMPhlowOrigin >> slot: anObject [
	"must be a GLMPhlowSlot"
	slot := anObject
]
