Class {
	#name : #RTMultiLinearColorForIdentity,
	#superclass : #RTMultiLinearColor,
	#instVars : [
		'objects'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #initialization }
RTMultiLinearColorForIdentity >> initialize [
	super initialize.
	self colors: (ColorPalette qualitative colors: 12 scheme: 'Set3').
	objects := #()
]

{ #category : #public }
RTMultiLinearColorForIdentity >> numberOfColors: aValue [
	^ self objects: (1 to: aValue)
]

{ #category : #public }
RTMultiLinearColorForIdentity >> objects: someObjects [
	objects := someObjects
]

{ #category : #accessing }
RTMultiLinearColorForIdentity >> rtValue: anObject [
	^ self level: (objects indexOf: anObject) - 1 / objects size
]
