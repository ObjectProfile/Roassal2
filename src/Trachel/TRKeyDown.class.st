"
Event representing a key pressing (but not releasing)

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
v := RTView new.

e := RTBox new color: Color blue; size: 50; element.

v add: e.

e when: TRKeyDown do: [ :event |
	event keyCombination = $r asKeyCombination ifTrue: [
		e color: Color random.
		v signalUpdate.
	]
].

v open
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #TRKeyDown,
	#superclass : #TRShapeEvent,
	#instVars : [
		'keyValue',
		'keyCombination'
	],
	#category : #'Trachel-Events'
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
