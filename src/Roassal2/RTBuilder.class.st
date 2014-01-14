Class {
	#name : #RTBuilder,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'interactionBuilder',
		'shapeBuilder'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #protected }
RTBuilder >> elementsOn: collectionOfObjects [
	^ shapeBuilder elementsOn: collectionOfObjects
]

{ #category : #initialization }
RTBuilder >> initialize [
	super initialize.
	view := RTView new.
	shapeBuilder := RTShapeBuilder new.
	interactionBuilder := RTInteractionBuilder new.
]

{ #category : #accessing }
RTBuilder >> interaction [
	^ interactionBuilder
]

{ #category : #'public-ui' }
RTBuilder >> open [
	^ self openIn: view
]

{ #category : #'public-ui' }
RTBuilder >> openIn: aView [
	self renderIn: aView.
	^ aView open
]

{ #category : #hooks }
RTBuilder >> renderIn: aView [
	self subclassReponsibility
]

{ #category : #accessing }
RTBuilder >> shape [
	^ shapeBuilder
]
