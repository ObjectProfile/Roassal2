Class {
	#name : #RTMultiLinearColorForIdentity,
	#superclass : #RTMultiLinearColor,
	#instVars : [
		'objects'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #'as yet unclassified' }
RTMultiLinearColorForIdentity >> initialize [
	super initialize.
	self colors: (ColorPalette qualitative colors: 12 scheme: 'Set3').
	objects := #()
]

{ #category : #'as yet unclassified' }
RTMultiLinearColorForIdentity >> objects: someObjects [
	objects := someObjects
]

{ #category : #'as yet unclassified' }
RTMultiLinearColorForIdentity >> rtValue: anObject [
	^ self level: (objects indexOf: anObject) - 1 / objects size
]
