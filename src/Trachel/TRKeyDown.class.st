Class {
	#name : #TRKeyDown,
	#superclass : #TRShapeEvent,
	#instVars : [
		'keyValue',
		'keyCombination'
	],
	#category : #'Trachel-Core'
}

{ #category : #comparing }
TRKeyDown >> = anotherKeyDown [
	"Do we really need this method? It has been imported from Roassal1"
	(self class == anotherKeyDown) ifFalse: [  ^ false ].
	^ self keyValue = anotherKeyDown keyValue
]

{ #category : #initialization }
TRKeyDown >> initialize [
	super initialize.
	keyValue := 0
]

{ #category : #accessing }
TRKeyDown >> keyCombination [
	^ keyCombination
]

{ #category : #accessing }
TRKeyDown >> keyCombination: anObject [
	keyCombination := anObject
]

{ #category : #accessing }
TRKeyDown >> keyValue [
	^ keyValue
]

{ #category : #accessing }
TRKeyDown >> keyValue: anObject [
	keyValue := anObject
]
